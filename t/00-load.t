#!perl -T
use 5.006;
use strict;
use warnings FATAL => 'all';
use Test::More tests => 13;

use_ok 'Tie::Hash::Attribute';

tie my %attr, 'Tie::Hash::Attribute';
$attr{foo} = "bar";
$attr{bar} = "foo";

is $attr{foo}, "bar",   "foo key correct";
is $attr{bar}, "foo",   "bar key correct";

is exists $attr{foo}, 1,    "foo key exists";
is exists $attr{bar}, 1,    "bar key exists";
is exists $attr{baz}, '',   "baz key exists";

is delete $attr{foo}, "bar",    "foo key deleted";
is exists $attr{foo}, '',       "foo key no longer exists";

$attr{foo} = "new";
is $attr{foo}, "new",   "new foo key correct";

$attr{table}{bgcolor} = [qw(red blue green yellow)];
$attr{td} = { style => [ 'color: red', 'color: black', ] };

is scalar %attr,
    q(bar="foo" foo="new" table="bgcolor: red;" td="style: color: red;"),
    "correct values for 1st rotate";
is scalar %attr,
    q(bar="foo" foo="new" table="bgcolor: blue;" td="style: color: black;"),
    "correct values for 2nd rotate";
is scalar %attr,
    q(bar="foo" foo="new" table="bgcolor: green;" td="style: color: red;"),
    "correct values for 3rd rotate";
is scalar %attr,
    q(bar="foo" foo="new" table="bgcolor: yellow;" td="style: color: black;"),
    "correct values for 4th rotate";
