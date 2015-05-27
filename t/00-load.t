#!perl -T
use 5.006;
use strict;
use warnings FATAL => 'all';
use Test::More tests => 7;

use_ok 'Tie::Hash::Attribute';

tie my %tag, 'Tie::Hash::Attribute';

$tag{style} = 'color: red';
is scalar %tag,
    'style="color: red"',
    "one key, value with colon correct";

delete $tag{style};
$tag{style}{color} = 'red';
$tag{style}{align} = 'right';
is scalar %tag,
    'style="align: right; color: red;"',
    "multi key, values without colons correct";

$tag{style}{align} = [qw(left right)];
$tag{style}{color} = [qw(red blue green)];
is scalar %tag, 
    'style="align: left; color: red;"',
    "multi key, multi values 1st access correct";

is scalar %tag, 
    'style="align: right; color: blue;"',
    "multi key, multi values 2nd access correct";

is scalar %tag, 
    'style="align: left; color: green;"',
    "multi key, multi values 3rd access correct";

is scalar %tag, 
    'style="align: right; color: red;"',
    "multi key, multi values 4th access correct";
