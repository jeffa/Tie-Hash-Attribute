#!perl -T
# see http://www.w3.org/TR/html-markup/syntax.html#syntax-attributes
use 5.006;
use strict;
use warnings FATAL => 'all';
use Test::More tests => 6;

use Tie::Hash::Attribute;

tie my %tag, 'Tie::Hash::Attribute';

$tag{foo} = { bar => 'baz' };
$tag{Foo} = { baz => 'bar' };
is scalar %tag, ' Foo="baz: bar"',                      "access keys not case insensitive, but first wins";

$tag{foo} = { bar => 1, Bar => 2, BAr => 3, BAR => 4 };
is $tag{-foo}, ' BAR="4"',                              "attribute keys are case insensitive, first wins";

$tag{foo} = { q(foo.<bar>="stuff's"/0) => 1 };
is $tag{-foo}, ' foo.<bar&amp;gt;&amp;#61;&amp;quot;stuff&amp;#39;s&amp;quot;&amp;#47;0="1"',  "keys scrubbed";

$tag{foo} = { bar => '"hello"' };
is $tag{-foo}, ' bar="&quot;hello&quot;"',              "values scrubbed";

$tag{foo} = { bar => '    ' };
is $tag{-foo}, ' bar=""',                               "values of all spaces squashed";

$tag{code} = { title => 'U+003C LESS-THAN SIGN' };
is $tag{-code}, ' title="U+003C LESS-THAN SIGN"',       "correct value for W3C example";
