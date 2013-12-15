# plugin_import.t

use strict;
use warnings;
use Test::More;

{
    use Dancer2;
    use t::lib::PluginWithImport;

    get '/test' => sub {
        dancer_plugin_with_import_keyword;
    };
}

use Dancer2::Test;

response_content_is '/test', 'dancer_plugin_with_import_keyword',
  "the plugin exported its keyword";

is_deeply(
    t::lib::PluginWithImport->stuff,
    { 't::lib::PluginWithImport' => 'imported' },
    "the original import method of the plugin is still there"
);

subtest 'import flags' => sub {
    eval "
        package Some::Plugin;
        use Dancer2::Plugin ':no_dsl';

        register 'foo' => sub { request };
    ";
    like $@, qr{Bareword "request" not allowed while "strict subs"}, 
      "with :no_dsl, the Dancer's dsl is not imported.";

    eval "
        package Some::Plugin;
        use Dancer2::Plugin;

        register 'foo' => sub { request };
    ";
    is $@, '', "without any import flag, the DSL is imported";


};

done_testing;
