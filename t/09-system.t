use Test::More 'no_plan';
use Test::Deep;
use lib '../lib';
use NG;
use System;
use Data::Dumper;

my $s = new System;
isa_ok $s, 'System';

System::local_run( 'w', sub {
    my ($out, $err) = @_;
    is $out->get(1), 'USER     TTY      FROM             LOGIN@   IDLE   JCPU   PCPU WHAT';
});

for my $i (qw /a b c/ ) {
    System::fork_run(
        sub { my $parent = shift; my $ppid = $parent->pid; my $line = $parent->read; $parent->say("$ppid teach $line") },
        sub { my $child = shift; $child->say("$i");printf "%d learn: %s\n", $child->pid, $child->read; },
    );
};
