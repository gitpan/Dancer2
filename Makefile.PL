
use strict;
use warnings;

use 5.005030;

use ExtUtils::MakeMaker 6.30;



my %WriteMakefileArgs = (
  "ABSTRACT" => "Lightweight yet powerful web application framework",
  "AUTHOR" => "Dancer Core Developers",
  "BUILD_REQUIRES" => {
    "Capture::Tiny" => "0.12",
    "ExtUtils::MakeMaker" => 0,
    "File::Find" => 0,
    "File::Spec::Functions" => 0,
    "File::Temp" => "0.22",
    "FindBin" => 0,
    "HTTP::Body" => 0,
    "HTTP::Request::Common" => 0,
    "HTTP::Server::Simple::PSGI" => 0,
    "LWP::UserAgent" => 0,
    "Module::Build" => "0.3601",
    "Path::Class" => 0,
    "Test::Fatal" => 0,
    "Test::MockTime" => 0,
    "Test::More" => "0.92",
    "Test::TCP" => "1.13",
    "YAML" => 0,
    "YAML::Any" => 0,
    "utf8" => 0,
    "vars" => 0
  },
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => "6.30",
    "Module::Build" => "0.3601"
  },
  "DISTNAME" => "Dancer2",
  "EXE_FILES" => [],
  "LICENSE" => "perl",
  "NAME" => "Dancer2",
  "PREREQ_PM" => {
    "Carp" => 0,
    "Config::Any" => 0,
    "Cwd" => 0,
    "Data::Dumper" => 0,
    "Digest::SHA" => 0,
    "Digest::SHA1" => 0,
    "Encode" => 0,
    "Exporter" => "5.57",
    "Fcntl" => 0,
    "File::Basename" => 0,
    "File::Copy" => 0,
    "File::Spec" => 0,
    "HTTP::Body" => 0,
    "HTTP::Date" => 0,
    "HTTP::Headers" => 0,
    "HTTP::Server::Simple::PSGI" => 0,
    "IO::File" => 0,
    "JSON" => 0,
    "List::Util" => 0,
    "MIME::Base64" => "3.13",
    "MIME::Types" => 0,
    "Moo" => "0.009014",
    "Moo::Role" => 0,
    "MooX::Types::MooseLike" => "0.16",
    "MooX::Types::MooseLike::Base" => 0,
    "MooX::Types::MooseLike::Numeric" => 0,
    "POSIX" => 0,
    "Plack::Request" => 0,
    "Scalar::Util" => 0,
    "Template" => 0,
    "Template::Tiny" => 0,
    "Test::Builder" => 0,
    "Test::More" => 0,
    "URI" => 0,
    "URI::Escape" => 0,
    "YAML::Any" => 0,
    "overload" => 0,
    "parent" => 0,
    "strict" => 0,
    "warnings" => 0
  },
  "VERSION" => "0.02",
  "test" => {
    "TESTS" => "t/*.t t/roles/*.t t/template_tiny/*.t"
  }
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.56) } ) {
  my $br = delete $WriteMakefileArgs{BUILD_REQUIRES};
  my $pp = $WriteMakefileArgs{PREREQ_PM};
  for my $mod ( keys %$br ) {
    if ( exists $pp->{$mod} ) {
      $pp->{$mod} = $br->{$mod} if $br->{$mod} > $pp->{$mod};
    }
    else {
      $pp->{$mod} = $br->{$mod};
    }
  }
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);



