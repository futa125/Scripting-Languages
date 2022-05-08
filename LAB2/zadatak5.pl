#!/usr/bin/perl
use strict;
use warnings;
use open ':locale';
use locale;

my %students;
my @components;

while (<>) {
    if ($_ =~ /^\s*#.*$/g)  {
        next;
    }

    if ($_ =~ /^(\d+\.?\d*;)+(\d+\.?\d*)$/g) {
        @components = split(';', $_);
        next;
    }

    if ($_ =~ /^(\d{10});(\w*);(\w*);(((\d+\.?\d*;)|-;)+((\d+\.?\d*)|-))$/) {
        my $jmbag = $1;
        my $surname = $2;
        my $name = $3;
        my @points = split(';', $4);
        my $total = 0;

        for my $i (0..$#points) {
            if ($points[$i] eq '-') {
                next;
            }
            $total += $components[$i] * $points[$i];
        }

        $students{$surname . ', ' . $name . ' (' . $jmbag . ')'} = $total;
    }
}

my $max = 0;
for (keys %students) {
    $max = length($_) if length($_) > $max;
}

my $i;
foreach my $student (reverse sort {$students{$a} <=> $students{$b}} keys %students) {
    $i += 1;
    printf "%d. %-*s  : %.2f\n", $i, $max, $student, $students{$student};
}
