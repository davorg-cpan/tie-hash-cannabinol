# $Id$

=head1 NAME

Tie::Hash::Cannabinol - Perl extension for creating hashes that forget things

=head1 SYNOPSIS

  use Tie::Hash::Cannabinol;

  my %hash;
  tie %hash, 'Tie::Hash::Cannabinol';

or

  my %hash : Stoned;

  # % hash can now be treated exactly like a normal hash - but don't trust
  # anything it tells you.

=head1 DESCRIPTION

Tie::Hash::Cannabinol is a completely useless demonstration of how to use
Tie::StdHash to pervert the behaviour of Perl hashes. Once a hash has been
C<tie>d to Tie::Hash::Cannabinol, there is a 25% chance that it will forget
anything that you tell it immediately and a further 25% chance that it 
won't be able to retrieve any information you ask it for. Any information
that it does return will be pulled at random from its keys.

Oh, and the return value from C<exists> isn't to be trusted either :)

=cut

package Tie::Hash::Cannabinol; 

use strict;
use vars qw($VERSION @ISA);
use Tie::Hash;
use Attribute::Handlers autotie => { "__CALLER__::Stoned" => __PACKAGE__ };

$VERSION = sprintf "%d.%02d", '$Revision$ ' =~ /(\d+)\.(\d+)/;
@ISA = qw(Tie::StdHash);

=head2 STORE

Stores data in the hash 3 times out of 4.

=cut

sub STORE {
  my ($self, $key, $val) = @_;

  return if rand > .75;

  $self->{$key} = $val;
}

=head2 FETCH

Fetchs I<something> from the hash 3 times out of 4.

=cut

sub FETCH {
  my ($self, $key) = @_;

  return if rand > .75;

  return $self->{(keys %$self)[rand keys %$self]};
}

=head2 EXISTS

Gives very dodgy information about the existance of keys in the hash.

=cut

sub EXISTS {
  return rand > .5;
}

1;
__END__


=head1 AUTHOR

Dave Cross <dave@dave.org.uk>

=head1 COPYRIGHT

Copyright (C) 2001, Magnum Solutions Ltd.  All Rights Reserved.

This script is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.

=head1 SEE ALSO

perl(1), perltie(1), Tie::StdHash(1)

=cut

#
# $Log$
# Revision 1.8  2004/10/23 09:47:21  dave
# Fixed problems caused by moving POD around in the last version.
#
# Revision 1.7  2004/10/23 09:36:50  dave
# Improved test coverage.
#
# Revision 1.6  2002/09/23 19:02:28  dave
# Fixed to work with Perl 5.8.0.
#
# Revision 1.5  2002/07/12 18:32:21  dave
# Corrected Attribute::Handlers dependency.
#
# Revision 1.4  2001/12/09 19:12:54  dave
# Added Attribute::Handlers interface.
#
# Revision 1.3  2001/09/05 19:48:15  dave
# fixed a very serious bug where instead of returning a random value from the hash we were, in fact, almost always returning C<undef>.
#
# Revision 1.2  2001/09/03 19:58:08  dave
# Minor fixes
#
# Revision 1.1  2001/09/02 17:06:18  dave
# Initial revision
#
