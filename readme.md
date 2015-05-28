Tie-Hash-Attribute
==================
Print hash values as rotating HTML attributes.

Synopsis
--------
```perl
use Tie::Hash::Attribute;

tie my %tag, 'Tie::Hash::Attribute';
%tag = (
    table => { border => 0 },
    tr => {
        style => { color => 'red', align => 'right' },
    },
    td => {
        style => {
            align => [qw( left right )],
            color => [qw( red blue green )],
    },
};
 
print $tag{-table};
  # border: 0

print $tag{-tr};
  # style="align: right; color: red;"

print $tag{-td} for 1 .. 4;
  # style="align: left; color: red;"',
  # style="align: right; color: blue;"',
  # style="align: left; color: green;"',
  # style="align: right; color: red;"',
```

Installation
------------
To install this module, you should use CPAN. A good starting
place is [How to install CPAN modules](http://www.cpan.org/modules/INSTALL.html).

If you truly want to install from this github repo, then
be sure and create the manifest before you test and install:
```
perl Makefile.PL
make
make manifest
make test
make install
```

Support and Documentation
-------------------------
After installing, you can find documentation for this module with the
perldoc command.
```
perldoc Spreadsheet::HTML
```
You can also find documentation at [metaCPAN](https://metacpan.org/pod/Spreadsheet::HTML).

License and Copyright
---------------------
See [source POD](/lib/Tie/Hash/Attribute.pm).
