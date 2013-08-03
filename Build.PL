
use strict;
use warnings;

use Module::Build 0.3601;


my %module_build_args = (
  "build_requires" => {
    "Module::Build" => "0.3601"
  },
  "configure_requires" => {
    "ExtUtils::MakeMaker" => "6.30",
    "Module::Build" => "0.3601"
  },
  "dist_abstract" => "Lightweight yet powerful web application framework",
  "dist_author" => [
    "Dancer Core Developers"
  ],
  "dist_name" => "Dancer2",
  "dist_version" => "0.07",
  "license" => "perl",
  "module_name" => "Dancer2",
  "recommends" => {
    "CGI::Deurl::XS" => 0,
    "Crypt::URandom" => 0,
    "JSON::XS" => 0,
    "Math::Random::ISAAC::XS" => 0,
    "Plack::Request" => 0,
    "Pod::Simple::Search" => 0,
    "Pod::Simple::SimpleTree" => 0,
    "Test::Builder" => 0,
    "Test::More" => 0,
    "URL::Encode::XS" => 0
  },
  "recursive_test_files" => 1,
  "requires" => {
    "Carp" => 0,
    "Config::Any" => 0,
    "Cwd" => 0,
    "Data::Dumper" => 0,
    "Digest::SHA" => 0,
    "Encode" => 0,
    "Exporter" => "5.57",
    "Fcntl" => 0,
    "File::Basename" => 0,
    "File::Copy" => 0,
    "File::Path" => 0,
    "File::Spec" => 0,
    "File::Spec::Functions" => 0,
    "File::Temp" => 0,
    "Getopt::Long" => 0,
    "HTTP::Body" => 0,
    "HTTP::Date" => 0,
    "HTTP::Headers" => 0,
    "HTTP::Server::Simple::PSGI" => 0,
    "Hash::Merge::Simple" => 0,
    "IO::File" => 0,
    "JSON" => 0,
    "LWP::UserAgent" => 0,
    "List::Util" => 0,
    "MIME::Base64" => "3.13",
    "MIME::Types" => 0,
    "Module::Runtime" => 0,
    "Moo" => "1.003000",
    "Moo::Role" => 0,
    "MooX::Types::MooseLike" => "0.16",
    "MooX::Types::MooseLike::Base" => 0,
    "POSIX" => 0,
    "Plack::Request" => 0,
    "Pod::Simple::Search" => 0,
    "Pod::Simple::SimpleTree" => 0,
    "Pod::Usage" => 0,
    "Scalar::Util" => 0,
    "Template" => 0,
    "Template::Tiny" => 0,
    "Test::Builder" => 0,
    "Test::More" => 0,
    "URI" => 0,
    "URI::Escape" => 0,
    "YAML::Any" => 0,
    "constant" => 0,
    "lib" => 0,
    "overload" => 0,
    "parent" => 0,
    "perl" => "5.00503",
    "strict" => 0,
    "warnings" => 0
  },
  "script_files" => [
    "script/dancer2"
  ],
  "test_requires" => {
    "Capture::Tiny" => "0.12",
    "ExtUtils::MakeMaker" => 0,
    "File::Temp" => "0.22",
    "FindBin" => 0,
    "HTTP::Body" => 0,
    "HTTP::Request::Common" => 0,
    "HTTP::Server::Simple::PSGI" => 0,
    "Test::Fatal" => 0,
    "Test::MockTime" => 0,
    "Test::More" => "0.92",
    "Test::Script" => "1.05",
    "Test::TCP" => "1.13",
    "YAML" => 0,
    "YAML::Any" => 0,
    "blib" => 0,
    "utf8" => 0,
    "vars" => 0
  }
);


unless ( eval { Module::Build->VERSION(0.4004) } ) {
  my $tr = delete $module_build_args{test_requires};
  my $br = $module_build_args{build_requires};
  for my $mod ( keys %$tr ) {
    if ( exists $br->{$mod} ) {
      $br->{$mod} = $tr->{$mod} if $tr->{$mod} > $br->{$mod};
    }
    else {
      $br->{$mod} = $tr->{$mod};
    }
  }
}

my $build = Module::Build->new(%module_build_args);

$build->create_build_script;
