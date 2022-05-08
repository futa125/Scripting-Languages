#!/usr/bin/perl
use strict;
use warnings;
use open ':locale';
use locale;

while (<>) {
    chomp $_;

    if ($_ =~ /^(\d{10});(\w*);(\w*);(\d{4})-(\d{2})-(\d{2}) (\d{2}):(\d{2}) (\d{2}):(\d{2}) .*;(\d{4})-(\d{2})-(\d{2}) (\d{2}):(\d{2}):(\d{2})$/) {
        my $jmbag = $1;
        my $surname = $2;
        my $name = $3;
        my $start_date = sprintf("%02d%02d%02d%02d%02d%02d", $4, $5, $6, $7, $8, 0);
        my $turned_in_date = sprintf("%02d%02d%02d%02d%02d%02d", $11, $12, $13, $14, $15, $16);

        if ($turned_in_date - $start_date > 10000) {
            print "$jmbag $surname $name - PROBLEM: $4-$5-$6 $7:$8 --> $11-$12-$13 $14:$15:$16\n"
        }
    }
}
