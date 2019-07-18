#!/usr/bin/perl -w
#
use File::Basename;
if ( @ARGV < 1) {
	die "Too few arguments!\nUsage: verilog_instance.pl filename\n";
}

# verilog file is the first arguments
my $filename = $ARGV[0];

#####################
# Parameter style. Used for Verilog which have a parameter list
# Two Kinds of style. 0 for parameter default value in statement
#                     1 for parameter default value in instance
my $parameter_style = 0;

# get the module name, Used to make instance file
my $tmp = basename $filename;

# $tmp may contain path, must removed
# \x2e is '.' , make xxx.v -> xxx
$tmp =~ s/\x2ev$//;

# set the output file to $module_name_tb.v
my $instance_module = $tmp.'_tb';
my $instance = $tmp."_tb.v";

# debug output 
print "\nRunning\.\.\.\n";
print "The verilog file is: '$filename'\n";
print "The testbench file is: '$instance'\n\n";


# check the exists of both file, prepare for open
die "$filename is not exists.\n" if (! -e $filename);
die "$instance is exists.\n" if -e $instance;

# Open the verilog file to read
if(! open FI, '<', $filename ) {
	die "Cannot open $filename: $!";
}

# Read the verilog file to buffer list
my @data = <FI>;

# close the verilog file for safe
close FI;

# Clean the line comment, \x2f means '\' in ASCII, and clean verilog attribution 
my $modules_cnt = 0;
foreach (@data) {
  chomp;
  if(/\(\*.*\*\)/) {
    print "Find a attribution in files, remove it:\n $_\n\n";
    s/\(\*.*\*\)\s*//;
  }
  s/\x2f\x2f.*$//; # \x2f means '/' in ASCII, removing the line comment
  if(/^\s*module\s+/) {
    $modules_cnt ++;
  }
}

if($modules_cnt > 1 || $modules_cnt == 0 ) {
  print "There are $modules_cnt modules in file, please check and process!\n";
  die;
}

# Clean the block comments
#  \x2a means '*', \x2f means '/'
&remove_block('\x2f\x2a','\x2a\x2f',@data);


# delete task or function block
&remove_block('task','endtask',@data);
&remove_block('function','endfunction',@data);
#&for_debug(@data);


################################################################################
## Storage DEFINES in verilog file
################################################################################
my @DEF_MACRO;
foreach(@data) {
  chomp;
  if(/^\s*(\`define .*$)/) {
    push(@DEF_MACRO, $1);
  }
}
my $MACRO_count = $#DEF_MACRO + 1;
#print "There are $MACRO_count MACROS in file\n";
#&for_debug(@DEF_MACRO);

my @MACRO_DEFINE;
foreach (@data) {
  chomp;
  if (/^\s*`(ifdef|ifndef)\s+(\w+)/) {
    push(@MACRO_DEFINE, $2);
  }
}

if ($#MACRO_DEFINE != -1) { 
  print "The Verilog file contain ifdef/ifndef block. The list is:\n";
  &for_debug(@MACRO_DEFINE);
  &remove_block('`ifdef','`endif',@data);
  &remove_block('`ifndef','`endif',@data);
}

################################################################################
## Storage signal ports in verilog file
################################################################################
# 1. collect port signal and save it. if end with ',' change to ';'
#    \x2c means ',', \x3c means ';' and remove 'reg', 'wire' defines
#    which is not need in testbench.

# save the port signal and convert to reg | wire
my @ports_tmp;
foreach(@data) {
  chomp;
  if(/^\s*(input|output|inout)/) {
    s/(input|output|inout)\s+(reg|wire)\s+/$1 /g; #input  wire a, -->input a,
    s/\x2c\s*$/\x3b/; # End ',' change to ';'
    s/\x3b\s*$//;     # remove end ';'
    s/\x2c\s*(input|output|inout)/\x3b $1/g;  #input [31:0] a,b, input [2:0] c->input [31:0] a,b; input [2:0] c
    s/^\s*//;
    if(/\x3b/) {
      my @tmp = split /\x3b/,$_;
      foreach(@tmp) {
        chomp;
        s/^\s*//;
        push(@ports_tmp,$_);
      }
    } else {
      push(@ports_tmp,$_);
    }
  }
}

#print "for debug, Ports_tmp:\n";
#&for_debug(@ports_tmp);

# 2. dispart multi signal in one line. dispart comb ports, eg:
#    input [31:0] a,b,c --> input [31:0] a
#                           input [31:0] b
#                           input [31:0] c





my @ports;
foreach (@ports_tmp) {
  if(/^\s*(input|output|inout).*\x2c/){ #at least two signal in one line, by dectect comma(',')
    #s/\x3b\s*$//;
    my @one_line = split /\x2c/,$_;
    my $tmp1 = shift (@one_line);
    my $direct = $tmp1;
    if(/\x5b.*\x5d/) {
      $direct =~ s/^\s*(input|output|inout)(\s+)(\x5b.*\x5d)(\s+)(\w+)/$1$2$3$4/;
    } else {
      $direct =~ s/^\s*(input|output|inout)(\s+)(\w+)/$1$2/;
    }
    #print "\$direct is $direct\n";
    #$tmp1 = $tmp1.';';
    push(@ports, $tmp1);
    while($tmp1 = shift(@one_line)){
      chomp;
      $tmp1 =~ s/\s*(\w+)/$1/;
      $tmp1 = $direct.$tmp1;
      push(@ports, $tmp1);
    }
  } else {
    push(@ports, $_);
  }
}

# turn input to reg, output to wire, inout to wire
foreach(@ports){
  s/^\s*input/reg/;
  s/^\s*output/wire/;
  s/^\s*inout/wire/;
  s/\x3b\s*$//; #delete ending';'
  s/\s*$/\x3b/; #add ending ';'
}
my $port_len = $#ports;
# For debug output
#print "Ports is:\n";
#&for_debug(@ports);

# Calculate the max bus vectors length
my $port_bus_max_length = 0;
my $port_name_max_length =0;
foreach(@ports) {
  my $tmp_name;
  if(/(\x5b.*\x5d)\s*(\w+)\s*\x3b$/) {
    my $tmp_bus = $1;
    $tmp_name = $2;
    my $tmp_bus_length = length($tmp_bus);
    if($port_bus_max_length < $tmp_bus_length) {
      $port_bus_max_length = $tmp_bus_length;
    }
  } else {
    /(reg|wire)\s+(\w+)\s*\x3b$/;
    $tmp_name = $2;
  }
#  print "For debug\n";
  my $tmp_name_length = length($tmp_name);
#  print "\$tmp_name = $tmp_name. \$tmp_name_length = $tmp_name_length\n";
  if($port_name_max_length < $tmp_name_length) {
    $port_name_max_length = $tmp_name_length;
  }
}
# for debug 
#print "The port list length: bus length = $port_bus_max_length, name_length = $port_name_max_length\n";


##########################################################################################################
# reg initialized
my @reg_list;
foreach(@ports) {
  if (/^\s*reg/) {
    my $i =$_;
    $i =~ s/^\s*reg.*\s+(\w+)\s*\x3b/$1 = 0\x3b/;
    push (@reg_list,$i);
  }
}

#debug output
#print "For debug, \@reg_list is :\n";
#&for_debug(@reg_list);


################################################################################
## module head process
################################################################################
# copy the module block and dispart more ports in one line
my @file_head;
my $file_head_block = -1;

foreach(@data) {
  if($file_head_block == 1 || /^\s*module\s+/) { # filehead block body
    if($file_head_block == -1) { # means filehead block begin
      if(/\x29\s*\x3b/) { # detected ');' means one line block
        $file_head_block = -1;
      } else {
        $file_head_block = 1;
      }
    } else {
      if(/\x29\s*\x3b/) { # detected ');' means one line block
        $file_head_block = -1;
      } else {
        $file_head_block = 1;
      }
    }
    if(/^\s*$/) { # blank line
	  } else {
	    push(@file_head, $_);
	  }
  }  
} 

my $have_parameter = -1;
my $ansi_c_type = -1;
my $real_module_name;
my $verilog_2k = -1;
foreach(@file_head) {
  if(/\x23/) { #check whether there is a parameter block
    $ansi_c_type = 1;
    $have_parameter = 1;
 #   print "Debug $_\n";
  }
  if(/^\s*module/){ # grep the real module name 
    $real_module_name = $_;
	  $real_module_name =~ s/^\s*module\s+(\w+)\s+.*$/$1/;	
  }
  if (/^\s*(input|output|inout)/ || /\x2c\s*(input|output|inout)/) { #verilog_2001 ansi_c type
    $verilog_2k = 1;
  }
}
# for debug
#print "For debug, The file_head is:\n";
#&for_debug(@file_head);

my $instance_module_name = 'u_'.$real_module_name;
print "\$real_module_name is \'$real_module_name\'\n";
print "\$instance_module_name is \'$instance_module_name\'\n\n";

my $parameter_block = -1;
my @parameter_tmp;
my @parameter;

if($have_parameter == 1) {
  print "The verilog is an ansi c type port define, have a parameter block.\n\n";
  # get a primary parameter block
  foreach(@file_head) {
    if($parameter_block == 1 || /\x23/) { #in block or begin
	    #print "in if\n";
      if(/(\x29\s*$|\x29\s*\x28)/) { # one line block
	      $parameter_block = -1;
	    } else {
	      $parameter_block = 1;
	    }
	    my $tmp = $_;
      if ($tmp =~ m/\x23/) { # begin, must delete the '#(' and before
        $tmp =~ s/^.*\x23//;
      }
      if ($tmp =~ m/\x28/) {
        $tmp =~ s/^\s*\x28\s*(.*)/$1/;
      }
      if ($tmp =~/\x29\s*$/) {
        $tmp =~ s/\x29.*$//;
      }
      if ($tmp =~ /\x29\s*\x28/) { #') (' type
        $tmp =~ s/\x29\s*\x28\.*$//;
      }
      if ($tmp =~ /^\s*$/) { # blank line

      } else {
        $tmp =~ s/^\s*//;
        $tmp =~ s/\x2c\s*$//; # delete end ','
        $tmp =~ s/\s*$//; #delete ending blank
        push(@parameter_tmp,$tmp);
      }
	  }
  } 

  # dispart one line parameter block
  foreach(@parameter_tmp) {
    if(/\x2c/) {
      my @tmp = split /,/,$_;
      foreach (@tmp) {
        s/^\s*//;
        push (@parameter,$_);
      }
    } else {
      push (@parameter,$_);
    }
  } 
}

# for debug
#print "for debug, parameter list is\n";
#&for_debug(@parameter);

my $parameter_name_max_length = 0;
my $parameter_value_max_length = 0;
my $parameter_bus_max_length = 0;
my @parameter_var;
foreach (@parameter) {
  my $tmp_name;
  my $tmp_value;
  if(/\x5b.*\x5d/) { # bus type
    #print "$_\n";
    /parameter\s*\x5b(.*)\x5d\s*(\w+)\s*\=\s*(.*)\s*$/;
    my $tmp_bus = $1;
    $tmp_name = $2;
    $tmp_value = $3;
    #print "My tmp_bus is \"$tmp_bus\"  \"$tmp_name\"  \"$tmp_value\"\n";
    my $tmp_bus_length = length($tmp_bus);
    if($parameter_bus_max_length < $tmp_bus_length) {
      $parameter_bus_max_length = $tmp_bus_length;
    }
  } else {
    /\s+(\w+)\s*\=\s*(.*)\s*$/;
    $tmp_name = $1;
    $tmp_value = $2;
  }
  my $tmp_name_length = length($tmp_name);
  push(@parameter_var,$tmp_name);
  if($parameter_name_max_length < $tmp_name_length) {
    $parameter_name_max_length = $tmp_name_length;
  }

  my $tmp_value_length = length($tmp_value);
  if($parameter_value_max_length < $tmp_value_length) {
    $parameter_value_max_length = $tmp_value_length;
  }
}

# for debug
#print "\$parameter_name_max_length = $parameter_name_max_length\n";
#print "\$parameter_value_max_length = $parameter_value_max_length\n";
#print "\$parameter_bus_max_length = $parameter_bus_max_length\n";

# For debug
# print "For debug, After :The file_head is:\n";
# foreach(@file_head) {
  # print "$_\n";
# }


#######################################################################################
## grep the port blocks
#######################################################################################
# my @file_head1 = @file_head;
# foreach (@file_head1){
#   s/\x5b.*\x5d/ /;
#   s/^\s*(input|output|inout)\s+(\w+)/$2/;
# }

my @port_blocks_tmp;
my $in_port_block = -1;

my $port_list;
my $port_list1;
######################prepare for port_list###########################################
foreach(@ports) {
  my $tmp = $_;
  $tmp =~ s/\x5b.*\x5d//; #remove bus vector define;
  $tmp =~ s/(reg|wire)\s+(\w+)/$2/;
  $tmp =~s/(\w+)\x3b/$1/;
  push(@port_list,$tmp);
}
if ($verilog_2k == 1) {

} else { #verilog -95
  my @reverse_file_head = reverse @file_head;
  foreach (@reverse_file_head) {
    if($in_port_block == 1 || /\x29\s*\x3b/) {
      if(/(^\s*\x28|\x29\s*\x28)/) {
        $in_port_block = -1;
      } else {
        $in_port_block = 1;
      }

      if(/^\s*$/) {

      } else {
        $tmp = $_;
        if($tmp =~ m/\x28/) {
          $tmp =~ s/^.*\x28//;
        }
        if($tmp =~ m/\x29\s*\x3b/) {
          $tmp =~ s/\x29\s*\x3b.*$//;
        }
        $tmp =~ s/^\s*//;
        $tmp =~ s/\s*$//;
        $tmp=~s/\x2c\s*$//; # remove ending comma(',')
        if($tmp =~ m/^\s*$/) {

        } else {          
          unshift(@port_list_tmp,$tmp);
        }
      }
    }
  }
  #print "The port_list is:\n";
  #&for_debug(@port_list_tmp);
  foreach(@port_list_tmp) {
    chomp;
    if(/\x2c/) {
      my @i = split /\x2c/,$_;
      foreach (@i) {
        s/^\s*//;
        s/^\s*$//;
        push(@port_list1,$_);
      }
    } else {
      push(@port_list1,$_);
    }
  }
  #print ">>>for_debug: port_list:\n";
  #&for_debug(@port_list);
  #print ">>>for_debug: port_list1:\n";
  #&for_debug(@port_list1);
  my $header_port_length = $#port_list;
  my $port_define_length = $#port_list1;
  if ($port_define_length != $header_port_length) {
    print "\n";
    print "Be careful! The signal numbers in port define and headers are not equal!\n";
    print "There are '$header_port_length' ports in 'header list'!\n";
    print "There are '$port_define_length' ports in 'define statements'!\n";
    print "Please check by using a simulator or synthesis tools!\n\n";
  }
  #reverse for future use for list unmatch ports.etc
  foreach (@port_list) {
    my $current =$_;
    my $match = -1;
    for ($i=0; $i<= $port_define_length; $i ++) {
      if ($port_list1[$i] eq $current) {
        $match =1;
        last;
      }
    }
    if ($match == -1) {
      print "Port '$current' is in port define statement. but not in header port list\n";
    }
  }
  print "\n";
  
  foreach (@port_list1) {
    my $current =$_;
    my $match = -1;
    for (my $i=0; $i<= $header_port_length; $i ++) {
      if ($port_list[$i] eq $current) {
        $match =1;
        last;
      }
    }
    if ($match == -1) {
      print "Port '$current' is in header port list. but not in port define statement\n";
    }
  }
  print "\n";
}

#for debug 
#print "The port_blocks is:\n";
#&for_debug(@port_blocks);

die "$instance is exists!\n" if -e $instance;

if(! open FO, '>', $instance ) {
  die "Cannot open $instance: $!"  
}
$slash = "//"x40;
print "Generated the verilog file is '$instance'\n";
##################################################################################################
## output to file
##################################################################################################
&print_header();
if ($have_parameter == 1 && $parameter_style ==0) {
  print FO "$slash\n";
  print FO "// Parameter list\n";
  print FO "$slash\n";
  my $parameter_bus_max_length_plus2 = $parameter_bus_max_length + 2;
  my $blank_fill = ' 'x$parameter_bus_max_length_plus2;
  foreach(@parameter) {
    if(/(\x5b.*\x5d)\s*(\w+)\s*\=\s*(.*)\s*$/) {
      #my $tmp1 = "\[".$1."\]";
      #printf FO "parameter \[%-${parameter_bus_max_length}s\] %-${parameter_name_max_length}s \= %-${parameter_value_max_length}s\;\n",$1,$2,$3;
      printf FO "parameter %-${parameter_bus_max_length_plus2}s %-${parameter_name_max_length}s \= %-${parameter_value_max_length}s\;\n",$1,$2,$3;
    } else {
      if(/parameter\s+(\w+)\s+(\w+)\s*\=\s*(.*)\s*$/) {
        printf FO "parameter %-${parameter_bus_max_length_plus2}s %-${parameter_name_max_length}s \= %-${parameter_value_max_length}s\;\n",$1,$2,$3;
      } else {
        /parameter\s+(\w+)\s*\=\s*(.*)\s*$/;
        printf FO "parameter %s %-${parameter_name_max_length}s \= %-${parameter_value_max_length}s\;\n",$blank_fill,$1,$2;
      }
    }
  }
}
print FO "$slash\n";
print FO "// signal list\n";
print FO "$slash\n";
#foreach (@ports) {
#  print FO "$_\n";
#}

#print "for debug, The ports is:\n";
#&for_debug(@ports);
my $port_blank_fill = ' 'x$port_bus_max_length;
foreach (@ports) {
  if(/^\s*reg/) {
    if(/(\x5b.*\x5d)\s*(\w+)/) {
      printf FO "reg  %-${port_bus_max_length}s %-${port_name_max_length}s\;\n",$1,$2;
    } else {
      /reg\s+(\w+)/;
      printf FO "reg  %s %-${port_name_max_length}s\;\n",$port_blank_fill,$1;
    }
  } else {
    if(/(\x5b.*\x5d)\s*(\w+)/) {
      printf FO "wire %-${port_bus_max_length}s %-${port_name_max_length}s\;\n",$1,$2;
    } else {
      /wire\s+(\w+)/;
      printf FO "wire %s %-${port_name_max_length}s\;\n",$port_blank_fill,$1;
    }
  }
}

print FO "\n";
print FO "\n";

print FO "$slash\n";
print FO "// initial block\n";
print FO "initial begin\n";
# print output the initial value
#foreach (@reg_list) {
#  print FO "\t$_\n";
#}
foreach(@ports) {
  if(/^\s*reg/) {
    if(/\x5b.*\x5d\s*(\w+)/) {
      printf FO "  %-${port_name_max_length}s = 0\;\n",$1;
    } else {
      /reg\s+(\w+)/;
      printf FO "  %-${port_name_max_length}s = 0\;\n",$1;
    }
  }
}

print FO "  #100;\n";
print FO "end\n";

print FO "\n";
print FO "\n";
print FO "\n";
print FO "\n";



print FO "$slash\n";
print FO "// UUT instance\n";
print FO "$slash\n";
print FO "$real_module_name ";
#print "have_parameter is $have_parameter\n";
if($have_parameter == 1) {
#  print "begin to start \n";
  print FO "\#\x28\n";
  if ($parameter_style ==0){
    &print_instance($parameter_name_max_length,@parameter_var);
  } else {
    my $parameter_length = $#parameter;
    for (my $i =0 ;$i<=$parameter_length;$i++) {
      my $tmp = $parameter[$i];
      $tmp =~ /\s*(\w+)\s*\x3d\s*(.*)\s*$/;
      printf FO "  \x2e%-${parameter_name_max_length}s\x28%-${parameter_value_max_length}s\x29",$1,$2;
      if ($i != $parameter_length) {
        print FO "\x2c\n";
      } else {
        print FO "\x2c\n";
      }

    }
  }
}

#print "The the port_blocks is:\n";
#&for_debug(@port_blocks);


print FO "$instance_module_name \x28\n";
&print_instance($port_name_max_length,@port_list);
print FO "\x29\x3b\n";

print FO "\n";
print FO "\n";
print FO "\n";
print FO "$slash\n";
print FO "// Clock Generate use if you need\n";
print FO "$slash\n";
print FO "// always #5 clk = ~clk\n\n\n";

print FO "endmodule\n";

close FO;


###################################################################################
## function defines
###################################################################################
sub print_header {
  print FO "`timescale 1ns/1ps\n";
  if($MACRO_count > -1) {
    foreach (@DEF_MACRO) {
      print FO "$_\n";
    }
  }
  print FO "$slash\n";
  print FO "//\n";
  print FO "// Filename:    $instance\n";
  print FO "// Author:      FangXinjia\n";
  my $create_time = gmtime;
  print FO "// Create Time: $create_time\n";
  print FO "// Release:     First Release\n";
  print FO "// Project:     \n";
  print FO "// Modified:\n";
  print FO "//\n";
  print FO "//\n";
  print FO "//\n";
  print FO "// Description: \n";
  print FO "//\n";
  print FO "//\n";
  print FO "//\n";
  print FO "//\n";
  print FO "$slash\n";
  print FO "module $instance_module; \n";
}

###################################################################################
sub for_debug {
  print "<===============For Debug, Begin======================>\n";
  foreach(@_) {
    print "$_\n";
  }
  print "<===============For Debug, END========================>\n";
  print "\n";
}

###################################################################################
sub remove_block {
  my $block_start = shift;
  my $block_end = shift;
  my $in_block = -1;
  foreach (@_) {
    chomp;
    if($in_block == 1 || /$block_start/) { # in block comments or block comments start
      if($in_block == -1){ #not in block comments, any way means block start
        if(/$block_end/){ # one line comment '*/'
          s/${block_start}.*${block_end}//;
          $in_block = -1;
        } else { # not one line comment, block comment start
          s/${block_start}.*$//;
          $in_block = 1;
        }
      } else { # $in_block =1 means in block comment body
        if (/$block_end/){ # in_block end
          s/^.*$block_end//g;
          $in_block = -1;
        } else { # in_block body
          s/^.*$//;
          $in_block = 1;
        }
      }
    }
  }
}


###################################################################################

sub print_instance {
  my $max_length = shift;
  my @list = @_;
  my $list_length = $#list;
  for (my $i = 0 ; $i <= $list_length; $i ++ ) {
    printf FO "  \x2e%-${max_length}s\x28%-${max_length}s\x29",$list[$i],$list[$i];
    if ($i != $list_length) {
      print FO "\,\n";
    } else {
      print FO "\n";
    }  
  }  
}
