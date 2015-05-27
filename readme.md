Tie-Hash-Attribute
==================
Print hash as scalar and emit HTML attributes.

Synopsis
--------
```perl
use Tie::Hash::Attribute;

tie my %tr, 'Tie::Hash::Attribute';
%tr = (tr => { style => ['color: red', 'color: black'] });
print "<tr", scalar %tr, ">";
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
