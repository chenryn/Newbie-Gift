use lib '../lib';
use NG;

mail_get 'pop3.163.com', 'user', 'pass', sub {
        my ( $headers, $body, $num, $pop ) = @_;
        say $headers->get('Subject');
        say $body->get(0);
};
