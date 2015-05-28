#!perl -T
use 5.006;
use strict;
use warnings FATAL => 'all';
use Test::More tests => 9;

use_ok 'Tie::Hash::Attribute';

tie my %tag, 'Tie::Hash::Attribute';
%tag = map {($_ => undef)} qw( table tr td );

is_deeply \%tag, { table => undef, tr => undef, td => undef },                  "looks like a hash";

$tag{table}{$_} = 0 for qw( border cellpadding cellspacing );
is_deeply $tag{table}, { border => 0, cellpadding => 0, cellspacing => 0 },     "looks like a hash";
is $tag{-table}, 'border="0" cellpadding="0" cellspacing="0"',                  "correct attributes 1 level deep";

$tag{tr}{style}{color} = 'red';
$tag{tr}{style}{align} = 'right';
is $tag{-tr}, 'style="align: right; color: red;"',                              "correct attributes 2 levels deep";

$tag{td}{style}{align} = [qw(left right)];
$tag{td}{style}{color} = [qw(blue green red)];
is $tag{-td}, 'style="align: left; color: blue;"',                              "correct attributes rotating vals 1";
is $tag{-td}, 'style="align: right; color: green;"',                            "correct attributes rotating vals 2";
is $tag{-td}, 'style="align: left; color: red;"',                               "correct attributes rotating vals 3";
is $tag{-td}, 'style="align: right; color: blue;"',                             "correct attributes rotating vals 4";
