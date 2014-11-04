use inc::Module::Install;
name 'Aplon-Model-OAuth2-Client-WebServer';
all_from 'lib/Aplon/Model/OAuth2/Client/WebServer.pm';

requires (
    'Aplon' => '0.01_04',
    'OAuth::Lite2' => 0,
);

tests 't/*.t';

configure_requires (
  'Module::Install::TestBase'
);

build_requires (
  'Test::More',
);
use_test_base;
auto_include;
WriteAll;
