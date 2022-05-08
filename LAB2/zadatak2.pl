#!/usr/bin/perl
use strict;
use warnings;

use Scalar::Util qw(looks_like_number);


my $total = 0;
my $count = 0;

foreach (@ARGV) {
    if (looks_like_number($_)) {
        $total += $_;
        $count += 1;
    }
}

my $average = $total / $count;

print "Average: $average\n";
