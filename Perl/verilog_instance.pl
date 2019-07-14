#!/usr/bin/perl -w
#
if ( @ARGV < 1) {
	die "Too few arguments!\nUsage: verilog_instance.pl filename\n";
}

$filename = $ARGV[0];
@_ = split /\./, $filename;
$tmp = $_[0];
print "\$tmp is $tmp\n";
$instance = $tmp."_inst.v";
print "\$instance is $instance\n";

die "$filename is not exists.\n" if (! -e $filename);
die "$instance is exists.\n" if -e $instance;


if(! open FI, '<', $filename ) {
	die "Cannot open $filename: $!";
}

die "$instance is exists!\n" if -e $instance;

if(! open FO, '>', $instance ) {
	die "Cannot open $filename: $!"	
}
while (<FI>){
	chomp;
	if (/^\s*module/){
		s/\s*module\s*//;
		print FO "$_\n";
	}
	elsif (s/\/\/.*//)
	{
	}
	elsif(s/\/\*.*\*\///)
	{
	}
	elsif(s/^\s*\`.*//)
	{
	}
	elsif (/\)\s*\;/) {
		print FO "$_\n";
		last;
	}
	elsif (s/\/\/.*//)
	{
	}
	elsif (/^\s*$/)
	{
	}
	else{
		print "\$_ before mod is $_\n";
		if(/^\s*parameter/) {
			s/^\s*parameter\s*.*\s+(\w+)\s*=\s*(.*)\s*(,)/\t\t\.$1($2)$3/;
			s/^\s*parameter\s*.*\s+(\w+)\s*=\s*(.*)\s*/\t\t\.$1($2)/;
			print "\$_ after mod is $_\n";
			print FO "$_\n";
		}
		else {
			s/^.*\s+(\w+)\s*(,)/\t\t\.$1\t\t($1\t\t)$2/;
			s/^.*\s+(\w+)\s*/\t\t\.$1\t\t($1\t\t)/;
			print "\$_ after mod is $_\n";
			print FO "$_\n";
		}
		#print FO "$_\n";
	}
}


