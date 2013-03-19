use strict;
use warnings;

use lib '../lib';

use Data::Dumper qw/Dumper/;
use Array;
use Excel;
use Excel::Sheet;
use Excel::Cell;
use Spreadsheet::ParseExcel;

sub parse_excel {
    my ( $filepath, $cb ) = @_;
    my $parser   = Spreadsheet::ParseExcel->new();
    my $workbook = $parser->parse($filepath);
    if ( !defined $workbook ) {
        die $parser->error() . "\n";
    }
    my $ng_sheet_arr = Array->new;
    for my $sheet ( $workbook->worksheets() ) {
        my ( $row_min, $row_max ) = $sheet->row_range();
        my ( $col_min, $col_max ) = $sheet->col_range();

        my $ng_sheet = Excel::Sheet->new(
            name      => $sheet->get_name(),
            row_count => $sheet->row_range(),
            col_count => $sheet->col_range(),
        );

        for my $row ( $row_min .. $row_max ) {
            for my $col ( $col_min .. $col_max ) {
                my $cell = $sheet->get_cell( $row, $col );
                next unless $cell;

                my $ng_cell = Excel::Cell->new(
                    value=>$cell->value(),
                );
                $ng_sheet->{cells}->[$row][$col] = $ng_cell;
            }
        }
        $ng_sheet_arr->push($ng_sheet);
    }

    my $ng_excel = Excel->new($ng_sheet_arr);
}
