package NewBie::Gift::DB;
use warnings;
use strict;
use base 'Object';
use Hashtable;
use Array;
use SQL::Abstract;
use AnyEvent::DBI;

sub new {
    my $pkg     = shift;
    my $options = {@_};
    return bless {
        dsn  => $options->{dsn}      || 'DBI:mysql:database=test;host=dbhost',
        user => $options->{username} || 'root',
        pass => $options->{password} || ''
    }, $pkg;
}

sub dbh {
    my $self = shift;
    return new AnyEvent::DBI $self->{dsn}, $self->{user}, $self->{pass};
}

=head2 select
Just use SQL::Abstract to generate SQL, so watch SQL::Abstract for options.
For example:
    my $options = {
        fields => ['col1', 'col2'],
        where  => {
            user => 'nwiger',
            priority => [
                { '=', 2 },
                { '>', 5 },
            ],
        },
        order  => ['col1', {-desc => 'col2'}]
    };
    select $table, $options, sub {
	    my ($array) = @_;
	    $array->each(sub{
	        $_[1]->each(sub{
	            my ($k, $v) = @_;
	        })
	    })
    }
=cut

sub select {
    my ( $self, $table, $options, $cb ) = @_;
    my $cv  = AnyEvent->condvar;
    my $dbh = $self->dbh;
    my $sql = SQL::Abstract->new;
    my ( $stmt, @bind ) =
      $sql->select( $table, $options->{fields}, $options->{where},
        $options->{order} );
    $dbh->exec(
        $stmt,
        \@bind,
        sub {
            my ( $dbh, $rows ) = @_;
            $#_ or die "failure: $@";
            $cb->( Array->new(@$rows) );
            $cv->send;
        }
    );
    $cv->recv;
}

sub insert {

}

sub update {

}

sub delete {

}

1;
