#!perl -T
use 5.006;
use strict;
use warnings FATAL => 'all';
use Test::More tests => 1;

use_ok( 'Tie::Hash::Attribute' ) or BAIL_OUT( "can't use module" );
