#!perl

use strict;
use warnings;

use Test::More tests => 1;

use ExtUtils::MakeMaker;
use File::Spec::Functions;
use List::Util qw/max/;

my @modules = qw(
  CGI::Deurl::XS
  Capture::Tiny
  Carp
  Config::Any
  Crypt::URandom
  Cwd
  Data::Dumper
  Digest::SHA
  Digest::SHA1
  Encode
  Exporter
  ExtUtils::MakeMaker
  Fcntl
  File::Basename
  File::Copy
  File::Find
  File::Spec
  File::Spec::Functions
  File::Temp
  FindBin
  HTTP::Body
  HTTP::Date
  HTTP::Headers
  HTTP::Request::Common
  HTTP::Server::Simple::PSGI
  IO::File
  JSON
  JSON::XS
  LWP::UserAgent
  List::Util
  MIME::Base64
  MIME::Types
  Math::Random::ISAAC::XS
  Module::Build
  Moo
  Moo::Role
  MooX::Types::MooseLike
  MooX::Types::MooseLike::Base
  MooX::Types::MooseLike::Numeric
  POSIX
  Path::Class
  Plack::Request
  Scalar::Util
  Template
  Template::Tiny
  Test::Builder
  Test::Fatal
  Test::MockTime
  Test::More
  Test::TCP
  URI
  URI::Escape
  URL::Encode::XS
  YAML
  YAML::Any
  overload
  parent
  perl
  strict
  utf8
  vars
  warnings
);

# replace modules with dynamic results from MYMETA.json if we can
# (hide CPAN::Meta from prereq scanner)
my $cpan_meta = "CPAN::Meta";
if ( -f "MYMETA.json" && eval "require $cpan_meta" ) { ## no critic
  if ( my $meta = eval { CPAN::Meta->load_file("MYMETA.json") } ) {
    my $prereqs = $meta->prereqs;
    delete $prereqs->{develop};
    my %uniq = map {$_ => 1} map { keys %$_ } map { values %$_ } values %$prereqs;
    $uniq{$_} = 1 for @modules; # don't lose any static ones
    @modules = sort keys %uniq;
  }
}

my @reports = [qw/Version Module/];

for my $mod ( @modules ) {
  next if $mod eq 'perl';
  my $file = $mod;
  $file =~ s{::}{/}g;
  $file .= ".pm";
  my ($prefix) = grep { -e catfile($_, $file) } @INC;
  if ( $prefix ) {
    my $ver = MM->parse_version( catfile($prefix, $file) );
    $ver = "undef" unless defined $ver; # Newer MM should do this anyway
    push @reports, [$ver, $mod];
  }
  else {
    push @reports, ["missing", $mod];
  }
}

if ( @reports ) {
  my $vl = max map { length $_->[0] } @reports;
  my $ml = max map { length $_->[1] } @reports;
  splice @reports, 1, 0, ["-" x $vl, "-" x $ml];
  diag "Prerequisite Report:\n", map {sprintf("  %*s %*s\n",$vl,$_->[0],-$ml,$_->[1])} @reports;
}

pass;

# vim: ts=2 sts=2 sw=2 et: