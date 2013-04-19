use Test::More 'no_plan';
use Test::Deep;
use lib '../lib';
use NG;

my $html = '<html><meta content="haha"><head></head><body><div id="mid">testcontent</div></body></html>';

my $hd = new HTTP::DOM->new($html);
isa_ok $hd, 'HTTP::DOM';

is $hd->find('#mid')->text, 'testcontent';
is $hd->find('meta')->attr('content'), 'haha';
$hd->find('body')->each(sub {
	isa_ok $_[1], 'HTTP::DOM';
});
