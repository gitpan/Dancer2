
BEGIN {
  unless ($ENV{AUTHOR_TESTING}) {
    require Test::More;
    Test::More::plan(skip_all => 'these tests are for testing by the author');
  }
}

use strict;
use warnings;

# this test was generated with Dist::Zilla::Plugin::Test::NoTabs 0.09

use Test::More 0.88;
use Test::NoTabs;

my @files = (
    'lib/Dancer2.pm',
    'lib/Dancer2/CLI.pm',
    'lib/Dancer2/CLI/Command/gen.pm',
    'lib/Dancer2/CLI/Command/version.pm',
    'lib/Dancer2/Config.pod',
    'lib/Dancer2/Cookbook.pod',
    'lib/Dancer2/Core.pm',
    'lib/Dancer2/Core/App.pm',
    'lib/Dancer2/Core/Cookie.pm',
    'lib/Dancer2/Core/DSL.pm',
    'lib/Dancer2/Core/Dispatcher.pm',
    'lib/Dancer2/Core/Error.pm',
    'lib/Dancer2/Core/Factory.pm',
    'lib/Dancer2/Core/HTTP.pm',
    'lib/Dancer2/Core/Hook.pm',
    'lib/Dancer2/Core/MIME.pm',
    'lib/Dancer2/Core/Request.pm',
    'lib/Dancer2/Core/Request/Upload.pm',
    'lib/Dancer2/Core/Response.pm',
    'lib/Dancer2/Core/Role/ConfigReader.pm',
    'lib/Dancer2/Core/Role/DSL.pm',
    'lib/Dancer2/Core/Role/Engine.pm',
    'lib/Dancer2/Core/Role/Handler.pm',
    'lib/Dancer2/Core/Role/HasLocation.pm',
    'lib/Dancer2/Core/Role/Headers.pm',
    'lib/Dancer2/Core/Role/Hookable.pm',
    'lib/Dancer2/Core/Role/Logger.pm',
    'lib/Dancer2/Core/Role/Serializer.pm',
    'lib/Dancer2/Core/Role/SessionFactory.pm',
    'lib/Dancer2/Core/Role/SessionFactory/File.pm',
    'lib/Dancer2/Core/Role/StandardResponses.pm',
    'lib/Dancer2/Core/Role/Template.pm',
    'lib/Dancer2/Core/Route.pm',
    'lib/Dancer2/Core/Runner.pm',
    'lib/Dancer2/Core/Session.pm',
    'lib/Dancer2/Core/Time.pm',
    'lib/Dancer2/Core/Types.pm',
    'lib/Dancer2/FileUtils.pm',
    'lib/Dancer2/Handler/AutoPage.pm',
    'lib/Dancer2/Handler/File.pm',
    'lib/Dancer2/Logger/Capture.pm',
    'lib/Dancer2/Logger/Capture/Trap.pm',
    'lib/Dancer2/Logger/Console.pm',
    'lib/Dancer2/Logger/Diag.pm',
    'lib/Dancer2/Logger/File.pm',
    'lib/Dancer2/Logger/Note.pm',
    'lib/Dancer2/Logger/Null.pm',
    'lib/Dancer2/Manual.pod',
    'lib/Dancer2/Manual/Migration.pod',
    'lib/Dancer2/Plugin.pm',
    'lib/Dancer2/Plugin/Ajax.pm',
    'lib/Dancer2/Plugins.pod',
    'lib/Dancer2/Policy.pod',
    'lib/Dancer2/Serializer/Dumper.pm',
    'lib/Dancer2/Serializer/JSON.pm',
    'lib/Dancer2/Serializer/Mutable.pm',
    'lib/Dancer2/Serializer/YAML.pm',
    'lib/Dancer2/Session/Simple.pm',
    'lib/Dancer2/Session/YAML.pm',
    'lib/Dancer2/Template/Implementation/ForkedTiny.pm',
    'lib/Dancer2/Template/Simple.pm',
    'lib/Dancer2/Template/TemplateToolkit.pm',
    'lib/Dancer2/Template/Tiny.pm',
    'lib/Dancer2/Test.pm',
    'lib/Dancer2/Tutorial.pod',
    'script/dancer2',
    't/00-compile.t',
    't/00-report-prereqs.dd',
    't/00-report-prereqs.t',
    't/ajax_plugin.t',
    't/any.t',
    't/app.t',
    't/app/t1/bin/app.psgi',
    't/app/t1/config.yml',
    't/app/t1/lib/App1.pm',
    't/app/t1/lib/Sub/App2.pm',
    't/app/t2/.dancer',
    't/app/t2/config.yml',
    't/app/t2/lib/App3.pm',
    't/app_alone.t',
    't/auto_page.t',
    't/caller.t',
    't/charset_server.t',
    't/classes/Dancer2-Core-Factory/create.t',
    't/classes/Dancer2-Core-Hook/base.t',
    't/classes/Dancer2-Core-Response/new_from.t',
    't/classes/Dancer2-Core-Role-Engine/base.t',
    't/classes/Dancer2-Core-Role-Handler/base.t',
    't/classes/Dancer2-Core-Role-HasLocation/FakeDancerDir/bin/.exists',
    't/classes/Dancer2-Core-Role-HasLocation/FakeDancerDir/blib/bin/.exists',
    't/classes/Dancer2-Core-Role-HasLocation/FakeDancerDir/blib/lib/fakescript.pl',
    't/classes/Dancer2-Core-Role-HasLocation/FakeDancerDir/lib/fake/inner/dir/.exists',
    't/classes/Dancer2-Core-Role-HasLocation/FakeDancerFile/.dancer',
    't/classes/Dancer2-Core-Role-HasLocation/FakeDancerFile/fakescript.pl',
    't/classes/Dancer2-Core-Role-HasLocation/base.t',
    't/classes/Dancer2-Core-Role-Headers/with.t',
    't/classes/Dancer2-Core-Role-StandardResponses/base.t',
    't/classes/Dancer2-Core-Runner/base.t',
    't/classes/Dancer2-Core-Runner/environment.t',
    't/classes/Dancer2-Core-Runner/psgi_app.t',
    't/classes/Dancer2-Core/camelize.t',
    't/classes/Dancer2/import.t',
    't/config.yml',
    't/config/config.yml',
    't/config/environments/failure.yml',
    't/config/environments/merging.yml',
    't/config/environments/production.yml',
    't/config/environments/staging.json',
    't/config_multiapp.t',
    't/config_reader.t',
    't/config_settings.t',
    't/context-in-before.t',
    't/cookie.t',
    't/corpus/pretty/505.tt',
    't/corpus/pretty_public/404.html',
    't/corpus/pretty_public/510.html',
    't/corpus/static/1x1.png',
    't/corpus/static/index.html',
    't/custom_dsl.t',
    't/dancer-test.t',
    't/dancer-test/config.yml',
    't/deserialize.t',
    't/dispatcher.t',
    't/dsl.t',
    't/dsl/content.t',
    't/dsl/extend.t',
    't/dsl/extend_config/config.yml',
    't/dsl/halt.t',
    't/dsl/pass.t',
    't/dsl/to_app.t',
    't/engine.t',
    't/error.t',
    't/error_template.t',
    't/factory.t',
    't/file_utils.t',
    't/forward.t',
    't/forward_before_hook.t',
    't/forward_test_tcp.t',
    't/handler_file.t',
    't/hooks.t',
    't/http_methods.t',
    't/http_status.t',
    't/issues/gh-634.t',
    't/issues/gh-723.t',
    't/issues/gh-730.t',
    't/lib/App1.pm',
    't/lib/App2.pm',
    't/lib/DancerPlugin.pm',
    't/lib/Foo.pm',
    't/lib/FooPlugin.pm',
    't/lib/Hookee.pm',
    't/lib/MyDancerDSL.pm',
    't/lib/PluginWithImport.pm',
    't/lib/SubApp1.pm',
    't/lib/SubApp2.pm',
    't/lib/TestApp.pm',
    't/lib/TestPod.pm',
    't/log_die_before_hook.t',
    't/log_levels.t',
    't/logger.t',
    't/logger_console.t',
    't/lwp-protocol-psgi.t',
    't/memory_cycles.t',
    't/mime.t',
    't/multi_apps.t',
    't/multi_apps_forward.t',
    't/multiapp_template_hooks.t',
    't/named_apps.t',
    't/plugin_import.t',
    't/plugin_multiple_apps.t',
    't/plugin_register.t',
    't/plugin_syntax.t',
    't/psgi_app.t',
    't/psgi_app_forward_and_pass.t',
    't/public/file.txt',
    't/redirect.t',
    't/request.t',
    't/request_params.t',
    't/request_upload.t',
    't/response.t',
    't/roles/hook.t',
    't/route-pod-coverage/route-pod-coverage.t',
    't/route.t',
    't/runner.t',
    't/serializer.t',
    't/serializer_json.t',
    't/serializer_mutable.t',
    't/server_standalone.t',
    't/session_config.t',
    't/session_engines.t',
    't/session_forward.t',
    't/session_hooks.t',
    't/session_in_template.t',
    't/session_lifecycle.t',
    't/session_object.t',
    't/sessions/VBzn5-yKiV0ZEaZqEtEvK_pmMT8n4QQx.yml',
    't/sessions/VD8wIQAAIErosiPuPzgc7Feo60_y7s2K.yml',
    't/sessions/VD8xFwAAIfVHBp2nUIRlhPrHBxZFewkg.yml',
    't/sessions/VD8xPwAAIqUQa3U0CK_Q43bf7JSaXj68.yml',
    't/sessions/VDKr30YvCd7R3WEniUv5Re5999E6SJmQ.yml',
    't/sessions/VDf4nIP4n0A4Ya5vcE7SaaDntyVZj9oB.yml',
    't/sessions/VDfsgXhalKhiOdSVDEk4iwyf_j3JJ1lU.yml',
    't/sessions/VDgFcPJynjsERU0GCt8fE9hhT-R3ErKV.yml',
    't/sessions/VDgH-lQYfi_XUNztQLT-6ebJ_gzwGZKp.yml',
    't/sessions/VDgHth9A4cXrh0fLlBodXUMnCXkcPlOO.yml',
    't/sessions/VDsBvbCel9L5vqAA8X12v_IKYwpqtEIb.yml',
    't/sessions/VDsC67174msADj1P2kEtWWWWqenpf_Gh.yml',
    't/sessions/VDsdec7YkN_t5HYgYTY4UTO0rGbd3quL.yml',
    't/sessions/VDskH-mTqVSrtI7vn3Cfjc22M3sDZ4nf.yml',
    't/sessions/VDxpkwmXPxXgntfDkSbIJIW3-ZmOV6F2.yml',
    't/sessions/VDxr8vlFwjuihF5Oq6qfdcX_C-sqJFst.yml',
    't/sessions/VDxsUBz1JAMQos-edO9ShtnKnIqjRugy.yml',
    't/sessions/VDxszUJNZJrCm2146wLcBL4Tauj5tlx3.yml',
    't/sessions/VDxtWd3557qlVPhU5y4QeEnoTzopT4XL.yml',
    't/sessions/VDxuf7UcBT5V58xfDyZ2akeLCE0stVRe.yml',
    't/sessions/VE1LtAAAI1ug7lcj3FDxEJY_qRPhfoA1.yml',
    't/sessions/VE1kdAAAROjzAe8ZtNQUKGC4lxSPjTdr.yml',
    't/sessions/VE1o4wAAS5VfIRWDZD6mSTy-ytif0XA-.yml',
    't/sessions/VE1tnAAAUNnRsHJYuMwKK9g-F4v26HBh.yml',
    't/sessions/VE27BgAAHJqJxusuS6yVI_5EYRhjTQbw.yml',
    't/sessions/VE27agAAHXnzZhVBaOsvWl1uOsOcnvfT.yml',
    't/sessions/VE2OEAAAXUMpJr0fKv_R132CQL6llNO6.yml',
    't/sessions/VE2VaAAAZacndokHehKRMngyv8UNxKT6.yml',
    't/sessions/VE2XCwAAZ9ygkhxx0mE_K_zWzXOmEhxE.yml',
    't/sessions/VE2YUAAAarbI4Jc7p_1EsANQn3BiZ7Ac.yml',
    't/sessions/VE2YygAAa2BSyhqX_xSUyxT98h-go-pc.yml',
    't/sessions/VE2ZKgAAbLz495eORolB6FjskBnNB9ap.yml',
    't/sessions/VE2ZjwAAbbYAr6pxPtFGzvqacCdwMll6.yml',
    't/sessions/VE2e9QAAc2wGVnxW-a8HhiC98g7YEx3g.yml',
    't/sessions/VE2enQAAcsZVTzEKdLzR9CDcSky4ZqUI.yml',
    't/sessions/VE2fRwAAdAiI1T-NFBekMmSKBrwpHDUK.yml',
    't/sessions/VE2gEAAAdOWFQRoXFFphEDM1iwFguvo-.yml',
    't/sessions/VE2gXgAAdircA43YYaJojXFPnqLvT9M5.yml',
    't/sessions/VE2grAAAdvaf8h_9-67vWmqukDEjs7vb.yml',
    't/sessions/VE4s2AAAN-mIHpV45UJy67IvQVuZVeoG.yml',
    't/sessions/VEcEMgAADIiqAdXb4PP-YxIqDskws7Qd.yml',
    't/shared_engines.t',
    't/splat.t',
    't/template.t',
    't/template_default_tokens.t',
    't/template_ext.t',
    't/template_name.t',
    't/template_simple.t',
    't/template_tiny/01_compile.t',
    't/template_tiny/02_trivial.t',
    't/template_tiny/03_samples.t',
    't/template_tiny/04_compat.t',
    't/template_tiny/05_preparse.t',
    't/template_tiny/samples/01_hello.tt',
    't/template_tiny/samples/01_hello.txt',
    't/template_tiny/samples/01_hello.var',
    't/template_tiny/samples/02_null.tt',
    't/template_tiny/samples/02_null.txt',
    't/template_tiny/samples/02_null.var',
    't/template_tiny/samples/03_chomp.tt',
    't/template_tiny/samples/03_chomp.txt',
    't/template_tiny/samples/03_chomp.var',
    't/template_tiny/samples/04_nested.tt',
    't/template_tiny/samples/04_nested.txt',
    't/template_tiny/samples/04_nested.var',
    't/template_tiny/samples/05_condition.tt',
    't/template_tiny/samples/05_condition.txt',
    't/template_tiny/samples/05_condition.var',
    't/template_tiny/samples/06_object.tt',
    't/template_tiny/samples/06_object.txt',
    't/template_tiny/samples/06_object.var',
    't/template_tiny/samples/07_nesting.tt',
    't/template_tiny/samples/07_nesting.txt',
    't/template_tiny/samples/07_nesting.var',
    't/template_tiny/samples/08_foreach.tt',
    't/template_tiny/samples/08_foreach.txt',
    't/template_tiny/samples/08_foreach.var',
    't/template_tiny/samples/09_trim.tt',
    't/template_tiny/samples/09_trim.txt',
    't/template_tiny/samples/09_trim.var',
    't/time.t',
    't/types.t',
    't/uri_for.t',
    't/vars.t',
    't/views/auto_page.tt',
    't/views/beforetemplate.tt',
    't/views/folder/page.tt',
    't/views/index.tt',
    't/views/layouts/main.tt',
    't/views/session_in_template.tt',
    't/views/template_simple_index.tt',
    't/views/tokens.tt'
);

notabs_ok($_) foreach @files;
done_testing;
