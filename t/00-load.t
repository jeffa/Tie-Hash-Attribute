#!perl -T
use 5.006;
use strict;
use warnings FATAL => 'all';
use Test::More;

plan tests => 1;

BEGIN {
    use_ok( 'Tie::Hash::Attribute' ) || print "Bail out!\n";
}

diag( "Testing Tie::Hash::Attribute $Tie::Hash::Attribute::VERSION, Perl $], $^X" );
