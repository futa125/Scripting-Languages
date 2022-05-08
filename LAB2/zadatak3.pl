#!/usr/bin/perl
use strict;
use warnings;


sub print_file_details {
    my %access_times = %{shift()};
    my $date = $_[0];

    print "Datum: $date\n";
    print "sat : broj pristupa\n";
    print "-------------------------------\n";

    foreach my $key (sort keys %access_times) {
        print "$key: $access_times{$key}\n";
    }

    print "\n";
}

my %months; @months{qw/Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec/} = (1..12);

my $date;
my %access_times;

while (my $line = <>) {
    chomp $line;
    $line =~ /^.*\[(\d{2})\/(\w{3})\/(\d{4}):(\d{2}):\d{2}:\d{2} \+\d{4}\].*$/;

    my $current_date = sprintf("%d-%02d-%d", $3, $months{$2}, $1);

    if (!defined $date) {
        $date = $current_date;
    }

    if ($current_date ne $date) {
        print_file_details(\%access_times, $date);

        $date = $current_date;
        %access_times = ();
    }

    $access_times{$4} += 1;
}

print_file_details(\%access_times, $date);
