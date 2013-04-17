use Test::More 'no_plan';
use Test::Deep;
use lib '../lib';

use System;
$s = new System;

System::local_run( 'w', sub {
    my ($out, $err) = @_;
    is $out->get(1), 'USER     TTY      FROM             LOGIN@   IDLE   JCPU   PCPU WHAT';
    print $err->get(0);
});
