use inc::Module::Install;
name 'Aplon-Model-OAuth2-Client-WebServer';
all_from 'lib/Aplon/Model/OAuth2/Client/WebServer.pm';

requires 'Aplon';
requires 'OAuth::Lite2';

tests 't/*.t';

build_requires 'Test::More';
use_test_base;
auto_include;
WriteAll;
