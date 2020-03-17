#!/usr/bin/perl

# Access list, which tunnels should each user have access to
$access{"grinje"} = [ 2001, 2002 ];


$user = $ARGV[0];
$port = $ENV{SSH_ORIGINAL_COMMAND};

# Check for authorization
%tunnels = map { $_ => 1 } @{$access{$user}};
if (exists($tunnels{$port})) {
    exec("/bin/nc localhost $port");
} else {
    print "Unauthorized access!\n";
    exit 1;
}

exit 0;
