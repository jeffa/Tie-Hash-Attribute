package Tie::Hash::Attribute;
use 5.006;
use strict;
use warnings FATAL => 'all';
our $VERSION = '0.01';

our @ISA = 'Tie::Hash';

use Data::Dumper;

sub TIEHASH     { bless {@_[1..@_-1]}, $_[0] }
sub FETCH       { $_[0]{$_[1]} }
sub STORE       { $_[0]{$_[1]} = $_[2] }
sub EXISTS      { exists $_[0]{$_[1]} }
sub FIRSTKEY    { keys %{$_[0]}; each %{$_[0]} }
sub NEXTKEY     { each %{$_[0]} } 
sub DELETE      { delete $_[0]{$_[1]} }
sub CLEAR       { delete $_[0]{$_} for keys %{$_[0]} }

sub SCALAR {
    my $self = shift;
    my $str = '';
    for my $K (sort keys %$self) {
        my $V = $self->{$K};
        if (ref $V eq 'HASH') {
            $V = join('; ', map {
                my $val = (ref $V->{$_} eq 'ARRAY')
                    ? _rotate( $V->{$_} )
                    : $V->{$_};
                join( ': ', $_, $val || '' );
            } sort keys %$V) . ';';
        }
        $V = _rotate($V) if ref($V) eq 'ARRAY';
        $str .= qq($K="$V" ) unless $V =~ /^$/;
    }
    chop $str;
    return $str;
}

sub _rotate {
    my $ref  = shift;
    my $next = shift @$ref;
    push @$ref, $next;
    return $next;
}

1;

__END__
=head1 NAME

Tie::Hash::Attribute - print hash as scalar and emit HTML attributes.

=head1 SYNOPSIS

  use Tie::Hash::Attribute;

  tie my %attr, 'Tie::Hash::Attribute';
  %attr = ( style => ['color: red', 'color: black'] );
  print "<td", scalar %td, ">\n" for 1 .. 10;

=head1 DESCRIPTION

This module will translate the keys and values into HTML tag attributes.
You just need to provide the tags.

=head1 AUTHOR

Jeff Anderson, C<< <jeffa at cpan.org> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-tie-hash-attribute at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Tie-Hash-Attribute>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Tie::Hash::Attribute


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Tie-Hash-Attribute>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Tie-Hash-Attribute>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Tie-Hash-Attribute>

=item * Search CPAN

L<http://search.cpan.org/dist/Tie-Hash-Attribute/>

=back

=head1 ACKNOWLEDGEMENTS

=head1 LICENSE AND COPYRIGHT

Copyright 2015 Jeff Anderson.

This program is free software; you can redistribute it and/or modify it
under the terms of the the Artistic License (2.0). You may obtain a
copy of the full license at:

L<http://www.perlfoundation.org/artistic_license_2_0>

Any use, modification, and distribution of the Standard or Modified
Versions is governed by this Artistic License. By using, modifying or
distributing the Package, you accept this license. Do not use, modify,
or distribute the Package, if you do not accept this license.

If your Modified Version has been derived from a Modified Version made
by someone other than you, you are nevertheless required to ensure that
your Modified Version complies with the requirements of this license.

This license does not grant you the right to use any trademark, service
mark, tradename, or logo of the Copyright Holder.

This license includes the non-exclusive, worldwide, free-of-charge
patent license to make, have made, use, offer to sell, sell, import and
otherwise transfer the Package with respect to any patent claims
licensable by the Copyright Holder that are necessarily infringed by the
Package. If you institute patent litigation (including a cross-claim or
counterclaim) against any party alleging that the Package constitutes
direct or contributory patent infringement, then this Artistic License
to you shall terminate on the date that such litigation is filed.

Disclaimer of Warranty: THE PACKAGE IS PROVIDED BY THE COPYRIGHT HOLDER
AND CONTRIBUTORS "AS IS' AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES.
THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
PURPOSE, OR NON-INFRINGEMENT ARE DISCLAIMED TO THE EXTENT PERMITTED BY
YOUR LOCAL LAW. UNLESS REQUIRED BY LAW, NO COPYRIGHT HOLDER OR
CONTRIBUTOR WILL BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, OR
CONSEQUENTIAL DAMAGES ARISING IN ANY WAY OUT OF THE USE OF THE PACKAGE,
EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
=cut
