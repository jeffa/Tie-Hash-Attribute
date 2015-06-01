#!perl -T
# see http://www.w3.org/TR/html-markup/syntax.html#syntax-attributes
use 5.006;
use strict;
use warnings FATAL => 'all';
use Test::More tests => 4;

use Tie::Hash::Attribute;

tie my %tag, 'Tie::Hash::Attribute';

use Data::Dumper;
$tag{foo} = { bar => 'baz' };
$tag{Foo} = { baz => 'bar' };
is_deeply $tag{foo}, {baz => 'bar'},    "value changed";
is $tag{-foo}, $tag{-FOO},              "keys are case insensitive";

$tag{foo} = { q(foo.<bar>="stuff's"/0) => 1 };
is $tag{-foo}, ' foo.<bar&amp;gt;&amp;#61;&amp;quot;stuff&amp;#39;s&amp;quot;&amp;#47;0="1"',  "keys scrubbed";

$tag{foo} = { bar => '"hello"' };
is $tag{-foo}, ' bar="&quot;hello&quot;"',  "values scrubbed";
