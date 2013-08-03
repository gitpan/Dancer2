use strict;
use warnings;

# This test was generated via Dist::Zilla::Plugin::Test::Compile 2.017

use Test::More 0.88;


use Capture::Tiny qw{ capture };

my @module_files = qw(
  Dancer2.pm
  Dancer2/Core.pm
  Dancer2/Core/App.pm
  Dancer2/Core/Context.pm
  Dancer2/Core/Cookie.pm
  Dancer2/Core/DSL.pm
  Dancer2/Core/Dispatcher.pm
  Dancer2/Core/Error.pm
  Dancer2/Core/Factory.pm
  Dancer2/Core/HTTP.pm
  Dancer2/Core/Hook.pm
  Dancer2/Core/MIME.pm
  Dancer2/Core/Request.pm
  Dancer2/Core/Request/Upload.pm
  Dancer2/Core/Response.pm
  Dancer2/Core/Role/Config.pm
  Dancer2/Core/Role/DSL.pm
  Dancer2/Core/Role/Engine.pm
  Dancer2/Core/Role/Handler.pm
  Dancer2/Core/Role/Headers.pm
  Dancer2/Core/Role/Hookable.pm
  Dancer2/Core/Role/Logger.pm
  Dancer2/Core/Role/Serializer.pm
  Dancer2/Core/Role/Server.pm
  Dancer2/Core/Role/SessionFactory.pm
  Dancer2/Core/Role/SessionFactory/File.pm
  Dancer2/Core/Role/StandardResponses.pm
  Dancer2/Core/Role/Template.pm
  Dancer2/Core/Route.pm
  Dancer2/Core/Runner.pm
  Dancer2/Core/Server/PSGI.pm
  Dancer2/Core/Server/Standalone.pm
  Dancer2/Core/Session.pm
  Dancer2/Core/Time.pm
  Dancer2/Core/Types.pm
  Dancer2/FileUtils.pm
  Dancer2/Handler/AutoPage.pm
  Dancer2/Handler/File.pm
  Dancer2/Logger/Capture.pm
  Dancer2/Logger/Capture/Trap.pm
  Dancer2/Logger/Console.pm
  Dancer2/Logger/Diag.pm
  Dancer2/Logger/File.pm
  Dancer2/Logger/Note.pm
  Dancer2/Logger/Null.pm
  Dancer2/ModuleLoader.pm
  Dancer2/Plugin.pm
  Dancer2/Plugin/Ajax.pm
  Dancer2/Serializer/Dumper.pm
  Dancer2/Serializer/JSON.pm
  Dancer2/Serializer/YAML.pm
  Dancer2/Session/Simple.pm
  Dancer2/Session/YAML.pm
  Dancer2/Template/Implementation/ForkedTiny.pm
  Dancer2/Template/Simple.pm
  Dancer2/Template/TemplateToolkit.pm
  Dancer2/Template/Tiny.pm
  Dancer2/Test.pm
);

my @scripts = qw(
  script/dancer2
);

# no fake home requested

my @warnings;
for my $lib (@module_files) {
    my ( $stdout, $stderr, $exit ) = capture {
        system( $^X, '-Mblib', '-e', qq{require q[$lib]} );
    };
    is( $?, 0, "$lib loaded ok" );
    warn $stderr if $stderr;
    push @warnings, $stderr if $stderr;
}

is( scalar(@warnings), 0, 'no warnings found' ) if $ENV{AUTHOR_TESTING};

use Test::Script 1.05;
foreach my $file (@scripts) {
    script_compiles( $file, "$file compiles" );
}


done_testing;
