#!/usr/bin/perl
use strict;
use warnings;

use Scalar::Util qw(looks_like_number);


print "Enter text to repeat: ";
my $text = <STDIN>;
chomp $text;

print "Enter number of repetitions: ";
my $n = <STDIN>;
chomp $n;

if (!looks_like_number($n)) {
    print "Please specify a numeric value for the number of repetitions.\n";
    exit;
}

while ($n > 0) {
    print "$text\n";
    $n -= 1;
}
