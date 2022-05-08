#!/usr/bin/perl
use strict;
use warnings;
use open ':locale';
use locale;

my $prefix_length = pop @ARGV;
my @all_words;

while (<>) {
    chomp;

    for my $word (split) {
        $word =~ s/[^\w]//g;
        push(@all_words, lc $word)
    }
}

my %prefixes =  map { length($_) >= $prefix_length ? (substr($_, 0, $prefix_length) => 0) : () } @all_words;

foreach my $prefix (keys %prefixes) {
    foreach my $word (@all_words) {
        if (substr($word, 0, $prefix_length) eq $prefix) {
            $prefixes{$prefix} += 1;
        }
    }
}

foreach my $prefix (sort keys %prefixes) {
    printf "%*s : %d\n", $prefix_length, $prefix, $prefixes{$prefix};
}
