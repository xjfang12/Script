#!/usr/bin/perl -w
#
if ( @ARGV < 1) {
	die "Too few arguments!\nUsage: verilog_instance.pl filename\n";
}

# verilog file is the first arguments
my $filename = $ARGV[0];

# get the module name, Used to make instance file
my $tmp = $filename;

# \x2e is '.' , make xxx.v -> xxx
$tmp =~ s/\x2e.*//;

# set the output file to $module_name_tb.v
my $instance_module = $tmp.'_tb';
my $instance = $tmp."_tb.v";

# debug output 
print "The verilog file is: '$filename'\n\n";


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


# Clean the line comment, \x2f means '\' in ASCII
foreach (@data) {
  chomp;
  s/\x2f\x2f.*$//;
  if (/\x28\x2a.*\x2a\x29/) {
    print "There is an attribution lines: $_\n\n";
    s/\x28\x2a.*\x2a\x29//; # delete (* .... *) attribute
  }
}

# Clean the block comment
my $block_comment = -1;
foreach (@data) {
  chomp;
  if($block_comment == 1 || /\x2f\x2a/) { # in block comments or block comments start, \x2a means '*'
    if($block_comment == -1){ #not in block comments, any way means block start
      if(/\x2a\x2f/){ # one line comment '*/'
        s/\x2f\x2a.*\x2a\x2f//;
        $block_comment = -1;
      } else { # not one line comment, block comment start
        s/\x2f\x2a.*$//;
        $block_comment = 1;
      }
    } else { # $block_comment =1 means in block comment body
      if (/\x2a\x2f/){ # block_comment end
        s/^.*\x2a\x2f//g;
        $block_comment = -1;
      } else { # block_comment body
        s/^.*$//;
        $block_comment = 1;
      }
    }
  }
}

# delete task or function
my $subroutie = -1;
foreach (@data) {
  chomp;
  if($subroutie == 1 || /^\s*(task|function)/) {
    if($subroutie == -1) {
      if(/^\s*task.*endtask/)  {
        s/task.*endtask//;
        $subroutie = -1;
      } elsif (/\s*task/) {
        s/\s*task.*$//;
        $subroutie =1;
      }
      if(/^\s*function.*endfunction/) {
        s/\s*function.*endfunction//;
        $subroutie = -1;
      } elsif (/\s*function/) {
        s/\s*function.*$//;
        $subroutie = 1;
      }
    } else {
      if(/(endtask|endfunction)/) {
        s/^.*(endtask|endfunction)//;
        $subroutie = -1;
      } else {
        s/^.*$//;
        $subroutie = 1;
      }
    }
  }
}

# Find modules, some verilog have more than 1 module, we need warning up
my $modules_cnt = 0;
foreach (@data) {
  if(/^\s*module\s+/) {
    $modules_cnt ++;
  }
}

if($modules_cnt > 1 || $modules_cnt == 0 ) {
  print "There are $modules_cnt modules in file, please check and process!\n";
  die;
}

# save the port signal and convert to reg | wire
my @ports_tmp;
foreach(@data) {
  chomp;
  if(/^\s*(input|output|inout)/) {
    s/\x2c\s*$/\x3b/; # End ',' change to ';'
    s/\x3b\s*$//;
    s/\s+wire\s+/ /;
    s/\s+reg\s+/ /;
    push(@ports_tmp,$_);
  }
}

#print "for debug, Ports_tmp:\n";
#&for_debug(@ports_tmp);

my @ports;
foreach (@ports_tmp) {
  if(/^\s*(input|output|inout).*\x2c/){
    #s/\x3b\s*$//;
    my @one_line = split /\x2c/,$_;
    my $tmp1 = shift (@one_line);
    my $direct = $tmp1;
    if(/\x5b.*\x5d/) {
      $direct =~ s/^\s*(input|output|inout)(\s+)(\x5b\s*\w+\s*\x3a\s*\w+\s*\x5d)(\s*)(\w+)/$1$2$3$4/;
    } else {
      $direct =~ s/^\s*(input|output|inout)(\s+)(\w+)/$1$2/;
    }
    #print "\$direct is $direct\n";
    #$tmp1 = $tmp1.';';
    push(@ports, $tmp1);
    while($tmp1 = shift(@one_line)){
      chomp;
      $tmp1 = $direct.$tmp1;#.';';
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
}
# For debug output
#print "Ports is:\n";
#&for_debug(@ports);

my $port_bus_max_length = 0;
my $port_name_max_length =0;
foreach(@ports) {
  my $tmp_name;
  if(/(\x5b.*\x5d)\s*(\w+)\s*$/) {
    my $tmp_bus = $1;
    $tmp_name = $2;
    my $tmp_bus_length = length($tmp_bus);
    if($port_bus_max_length < $tmp_bus_length) {
      $port_bus_max_length = $tmp_bus_length;
    }
  } else {
    /(reg|wire)\s+(\w+)\s*$/;
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

#debug output
# print "For debug, \@reg_list is :\n";
#&for_debug(@reg_list);

## Deside whether the verilog file is an ANSI_C style or not
#my $v2k_ansi = -1; # -1 means not 1 means yes

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
    #  push(@file_head, $_);
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
	    if($parameter_block == -1) {
	      if(/(\x29\s*$|\x29\s*\x28)/) { # one line block
		      $parameter_block = -1;
		    } else {
		      $parameter_block = 1;
		    }
	    } else {
	      if(/(\x29\s*$|\x29\s*\x28)/) { # end
		      $parameter_block = -1;
		    } else {
		      $parameter_block = 1;
		    }
	    }
	    if(/parameter/) {
	      s/^\s*//;
        if(/^\s*$/) {# blank line

        } else {
          s/\x2c\s*$//;
          push (@parameter_tmp,$_);
        }
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

# dispart the a, b, c, .... in one line
# foreach(@file_head) {

# }

# For debug
# print "For debug, After :The file_head is:\n";
# foreach(@file_head) {
  # print "$_\n";
# }


#######################################################################################
## grep the port blocks
#######################################################################################
my @file_head1 = @file_head;
foreach (@file_head1){
  s/\x5b.*\x5d/ /;
  s/^\s*(input|output|inout)\s+(\w+)/$2/;
}

my @port_blocks_tmp;
my $in_port_block = -1;
my @reverse_file_head = reverse @file_head1;
foreach (@reverse_file_head) {
  if($in_port_block == 1 || /\x29\s*\x3b/) {
    if($in_port_block == -1) {
      if(/(^\s*\x28|\x29\s*\x28)/) {
        $in_port_block = -1;
      } else {
        $in_port_block = 1;
      }
    } else {
      if(/(^\s*\x28|\x29\s*\x28)/) {
        $in_port_block = -1;
      } else {
        $in_port_block = 1;
      }
    }
    s/^\s*.*\x28//;
    s/^.*\x29\s*\x28//;
    s/\x29\s*\x3b.*$//;
    if(/^\s*$/) {

    } else {
      s/^\s*//;
	  s/\x2c\s*$//;
      unshift(@port_blocks_tmp,$_);
    }
  }
}

my @port_blocks;
foreach (@port_blocks_tmp) {
  if(/\x2c/) {
    my @tmp_port = split /,/,$_;
	foreach(@tmp_port) {
	  s/^\s*//;
	  s/\s*$//;
	  push(@port_blocks,$_);
	}
  } else {
    s/^\s*//;
	s/\s*$//;
	push(@port_blocks,$_);
  }
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
if ($have_parameter == 1) {
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
  my $parameter_last_one = pop(@parameter);
  foreach(@parameter) {
    /\s*(\w+)\s*\x3d\s*(.*)\s*$/;
    printf FO "  \x2e%-${parameter_name_max_length}s\x28%-${parameter_value_max_length}s\x29\x2c\n",$1,$2;
  }
#  print "parameter_last_one is $parameter_last_one\n";
  $parameter_last_one =~ m/\s*(\w+)\s*\x3d\s*(.*)\s*$/;
  printf FO "  \x2e%-${parameter_name_max_length}s\x28%-${parameter_value_max_length}s\x29\n",$1,$2;
  print FO "  \x29 ";
}

#print "The the port_blocks is:\n";
#&for_debug(@port_blocks);


print FO "$instance_module_name \x28\n";
&print_instance($port_name_max_length,@port_blocks);
#my $port_last_one = pop (@port_blocks);
#foreach(@port_blocks) {
#  /(\w+)\s*$/;
#  printf FO "  \x2e%-${port_name_max_length}s\x28%-${port_name_max_length}s\x29\x2c\n",$1,$1;
#}
#$port_last_one =~ m/(\w+)\s*$/;
#printf FO "  \x2e%-${port_name_max_length}s\x28%-${port_name_max_length}s\x29\n",$1,$1;
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
  print "<===============For Debug======================>\n";
  foreach(@_) {
    print "$_\n";
  }
  print "\n";
}

###################################################################################

sub print_instance {
  my $max_length = shift;
  my @list = @_;
  my $list_length = $#list;
  for (my $i = 0 ; $i <= $list_length; $i ++ ) {
    printf FO "  \x2e%-${max_length}s\x28%-${max_length}s\x29",$list[$i],$list[$i];
    if ($i != $list_length) {
      print FO "\.\n";
    } else {
      print FO "\n";
    }  
  }  
}
