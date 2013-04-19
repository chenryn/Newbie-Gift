use Test::More;
use lib '../lib';
use NG;

my $password = $ARGV[0];
SKIP: {
    skip 'no one know your username/password~~', 4, unless $password;
    mail_get 'pop3.renren-inc.com', 'chenlin.rao', $password, sub {
        my ( $headers, $body, $num, $pop ) = @_;
        isa_ok $headers, 'Hashtable';
        isa_ok $body, 'Array';
        isa_ok $body->get(0), 'HTTP::DOM';
        isa_ok $pop, 'Net::POP3';

        say $headers->{Subject};
        say $body->get(0)->text;
        $body->get(0)->find('div')->each(sub {
            say $_[1]->text;
        });
        exit;
    };
};

done_testing();
