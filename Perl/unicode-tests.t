use v5.18;
use warnings;
use feature 'unicode_strings';
use utf8;
use open qw( :encoding(UTF-8) :std );
use Unicode::Normalize;
use Test::More tests => 25;

is NFC("c\x{0327}"), "\x{00E7}", 'Unicode 1'; 

isnt "c\x{0327}", "\x{00E7}", 'Unicode 2'; 

is length NFC("noe\x{0308}l"), 4, 'Unicode 3';

is join("", reverse "noe\x{0308}l" =~ /\X/g), "le\x{0308}on", 'Unicode 4';
#is reverse(NFC("noe\x{0308}l")), NFC("le\x{0308}on"), 'Unicode 4';   ## alternative

is join("", @{["noe\x{0308}l" =~ /\X/g]}[0..2]), "noe\x{0308}", 'Unicode 5';
#is substr(NFC("noe\x{0308}l"), 0, 3), NFC("noe\x{0308}"), 'Unicode 5';   ## alternative

is uc "ba\x{FB04}e", "BAFFLE", 'Unicode 6';

is uc NFC("cant\x{00F9}"), "CANT\x{00D9}", 'Unicode 7';

is uc "cantu\x{0300}", "CANTU\x{0300}", 'Unicode 8';

is do { 
    local $_ = "\x{1D11E} - The Treble Clef";
    s/𝄞/𝄢/;     
    #s/\x{1D11E}/\x{1D122}/;    ## alternative that doesn't require "use utf8;" pragma 
    s/Treble/Bass/;
    $_;
}, "\x{1D122} - The Bass Clef", 'Unicode 9';

is length "\x{1D122} - The Bass Clef", 17, 'Unicode 10';

{
    # This changes locale for upper/lower casing etc
    # However in practise there are know Unicode issues with this...
    # and so it doesn't work for Turkish :(
    # It's been decided (thus far) to not change Perl core to cover this Unicode screw up!
    # See:  http://www.nntp.perl.org/group/perl.perl5.porters/2012/01/msg182021.html
    #       http://www.nntp.perl.org/group/perl.perl5.porters/2007/12/msg131478.html
    #   and solution provided via CPAN
    #       https://metacpan.org/pod/Unicode::Casing
    use POSIX 'locale_h';
    my $locale = setlocale(LC_CTYPE);
    {
        use locale;
        setlocale(LC_CTYPE, 'tr_TR.UTF-8');
        is uc "i", "\x{0130}", 'Unicode 11';
        is lc "I", "\x{0131}", 'Unicode 12';
    }
    setlocale(LC_CTYPE, $locale);
}

is uc "stra\x{00DF}e", "STRASSE", 'Unicode 13';

is length NFC("\x{30C8}\x{3099}"), 1, 'Unicode 14';

is length NFC("e\x{0308}\x{1D11E}\x{30C8}\x{3099}"), 3, 'Unicode 15';

is fc("weiss"), fc("weiß"), 'Unicode 16';

is NFD("e\x{0303}\x{033D}\x{032A}"), "e\x{032A}\x{0303}\x{033D}", "Unicode 17";

is "XII", NFKD("\x{216B}"), "Unicode 18";

isnt "XII", NFD("\x{216B}"), "Unicode 19";

is "\x{1E14}", NFC("\x{1E14}"), "Unicode 20";

is "E\x{0304}\x{0300}", NFD("\x{1E14}"), "Unicode 21";

is "\x{1E14}", NFC("\x{0112}\x{0300}"), "Unicode 22";

is "E\x{0304}\x{0300}", NFD("\x{0112}\x{0300}"), "Unicode 23";

is "\x{00C8}\x{0304}", NFC("\x{00C8}\x{0304}"), "Unicode 24";

isnt NFD("e\x{0303}\x{033D}\x{032A}"), "e\x{033D}\x{032A}\x{0303}", "Unicode 25";
