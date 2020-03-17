#!/usr/bin/perl

use Term::ANSIColor qw( colored );

$NETSTAT="netstat --listening -t4en | sort";

open (AUTH, "</home/callhome/.ssh/authorized_keys") || die "Unable to read auth file: $!";
while (<AUTH>) {
    my ($p, $comment) = /echo (\d+)\".*\s([^\s]+)$/;
    $auth{$p} = $comment;
}

print "\n";
open(FILE, "$NETSTAT |") || die "Unable to netstat: $!";
while (<FILE>) {
    next unless /1001/;
    my ($port) = /\s+[^\s:]+:(\d+)\s/;
    my ($login, $com) = split(/:/, $auth{$port});
    $com =~ s/_/ /g;
    $login =~ s/^!//;
    printf "%-11s %-30s %10s (port %s)\n", $login, $com, colored('online ', 'green'), $port;
    delete $auth{$port};
}
close (FILE);
print "\n";

foreach $p (sort keys %auth) {
    my ($login, $com) = split(/:/, $auth{$p});
    next if $login =~ /^!/;
    $com =~ s/_/ /g;
    $login =~ s/^!//;
    printf "%-11s %-30s %10s (port %s)\n", $login, $com, colored('offline', 'red'), $p;
}
print "\n";
