#!/usr/bin/perl -w

if(@ARGV < 1) {
	die "no argument!!!\n Usage: create_perl.pl \[module name\]\n";
}

my $modulename = $ARGV[0];
my $filename = "$modulename\.v";

die "The $filename is exists!\n" if -e $filename;
if (! open FILE, '>', $filename) {
	die "Cannot open $filename for write\n";
}
my $slash = "//"x40;
print FILE "`timescale 1ns/1ps\n";
print FILE "$slash\n";
print FILE "//\n";
print FILE "// Filename:    $filename\n";
print FILE "// Author:      FangXinjia\n";
my $create_time = gmtime;
print FILE "// Create Time: $create_time\n";
print FILE "// Release:     First Release\n";
print FILE "// Project:     \n";
print FILE "// Modified:\n";
print FILE "//\n";
print FILE "//\n";
print FILE "//\n";
print FILE "// Description: \n";
print FILE "//\n";
print FILE "//\n";
print FILE "//\n";
print FILE "//\n";
print FILE "$slash\n";
print FILE "module $modulename (\n";
print FILE "\n";
print FILE ");\n";
print FILE "\n";
print FILE "\n";
print FILE "\n";
print FILE "$slash\n";
print FILE "// Local parameter define\n";
print FILE "$slash\n\n";

print FILE "$slash\n";
print FILE "// Wire and Reg define\n";
print FILE "$slash\n\n";

print FILE "$slash\n";
print FILE "// Main body\n";
print FILE "$slash\n\n";



print FILE "endmodule\n";
print "$filename is created. Enjoy\n";
close FILE;
