# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

use Test::Simple tests => 5;

use Tie::Hash::Cannabinol;
ok(1);

my %hash : Stoned;

my @keys = qw(one two three four);

@hash{@keys} = 1 .. 4;

ok(1) for 2 .. 5;
