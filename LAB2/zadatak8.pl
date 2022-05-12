#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';

my %attributes;

while (<>) {
    chomp;

    if ($_ =~ /^([A-Za-z\-]+): .*/) {
        $attributes{$1} += 1;
    }
}

my $i = 0;
foreach my $attribute (reverse sort {$attributes{$a} <=> $attributes{$b}} keys %attributes) {
    print "$attribute: $attributes{$attribute}" . "\n";
    $i += 1;

    if ($i >= 40) {
        last;
    }
}
