use v5.18;
use warnings;
use feature 'unicode_strings';
use utf8;
use open qw( :encoding(UTF-8) :std );
use Unicode::Normalize;
use Test::More tests => 2;

# code ripped from Unicode::Casing CPAN module
#
my %turkish = (
    uc =>  sub {
        my $string = shift;
        $string =~ s/i/\x{130}/g;
        uc $string;
    },

    lc => sub {
        my $string = shift;
        $string =~ s/I (?! [^\p{ccc=0}\p{ccc=Above}]* \x{0307} )/\x{131}/gx;
        $string =~ s/I ([^\p{ccc=0}\p{ccc=Above}]* ) \x{0307}/i$1/gx;
        $string =~ s/\x{130}/i/g;
        lc $string;
    },
);

is $turkish{uc}->("i"), "\x{0130}", "Unicode 11";

is $turkish{lc}->("I"), "\x{0131}", "Unicode 12";

