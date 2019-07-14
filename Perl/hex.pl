#!/bin/perl -w
if (@ARGV < 4) {
    print "Usage: hex.pl <hex_file_name> <gen_file_name> <gen_file_size> <gen_file_name>\n";
    exit;
}

$hex_file     = $ARGV[0];
$iram_name    = $ARGV[1];
$iram_size    = $ARGV[2];
$iram_num     = $ARGV[3];
$iram_total_sz= $iram_size * $iram_num;
$nop          = "0"x16;

#print "$nop\n";
if (! open(FI,"<",$hex_file)) {
    die "Cann't open $hex_file for read: $!\n";
}

my @lines = <FI>;
close FI;

my $lines_size = @lines;

my @line_fill;

if ($lines_size > $iram_total_sz) {
    die "The hex file is bigger the $iram_name can hold\n";
} else {
    for($i = 0; $i < $iram_num; $i++){
        for(my $j=0; $j<$iram_size; $j ++) { 
            $line_fill[$j] = ""; # initial 
        }
        for(my $j=0; $j<$iram_size;$j ++) {
            $index = $iram_size * $i + $j;
            if(defined($line_tmp = $lines[$index])){
                chomp($line_tmp);
                $line_tmp =~ s/(\w*)/\L$1/;
                $line_fill[$j] = $line_tmp;
            } else {
                $line_fill[$j] = $nop;
            }
        }
        my $ram_file = $iram_name.$i.'.hex';
        if(!open(FO,">", $ram_file)) {
            die "Cann't open $ram_file for write, Please check:$!\n";
        }
        for(my $j=0; $j<$iram_size;$j ++) {
            my $write_tmp = $line_fill[$j];
            chomp($write_tmp);
            $write_tmp =~ /(................)/;
            print FO "$1\n";
        }
        close FO;
    }
}