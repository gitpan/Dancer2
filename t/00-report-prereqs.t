#!perl

use strict;
use warnings;

use Test::More tests => 1;

use ExtUtils::MakeMaker;
use File::Spec::Functions;
use List::Util qw/max/;

my @modules = qw(
  App::Cmd::Setup
  CGI::Deurl::XS
  Capture::Tiny
  Carp
  Class::Load
  Class::Load::XS
  Config::Any
  Crypt::URandom
  Cwd
  Data::Dumper
  Digest::SHA
  Encode
  Exporter
  ExtUtils::MakeMaker
  Fcntl
  File::Basename
  File::Copy
  File::Find
  File::Path
  File::ShareDir
  File::ShareDir::Install
  File::Spec
  File::Spec::Functions
  File::Temp
  FindBin
  HTTP::Body
  HTTP::Date
  HTTP::Headers
  HTTP::Request
  HTTP::Request::Common
  HTTP::Server::PSGI
  HTTP::Server::Simple::PSGI
  Hash::Merge::Simple
  IO::File
  IO::Handle
  IPC::Open3
  JSON
  JSON::XS
  LWP::Protocol::PSGI
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
  POSIX
  Plack::Builder
  Plack::Request
  Plack::Test
  Pod::Simple::Search
  Pod::Simple::SimpleTree
  Return::MultiLevel
  Role::Tiny
  Scalar::Util
  Scope::Upper
  Template
  Template::Tiny
  Test::Builder
  Test::Fatal
  Test::MockTime
  Test::More
  Test::Script
  Test::TCP
  URI
  URI::Escape
  URL::Encode::XS
  YAML
  lib
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
