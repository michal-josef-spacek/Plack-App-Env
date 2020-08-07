use strict;
use warnings;

use HTTP::Request;
use Plack::App::Env;
use Plack::Test;
use Test::More 'tests' => 2;
use Test::NoWarnings;

# Test.
my $app = Plack::App::Env->new;
my $test = Plack::Test->create($app);
my $res = $test->request(HTTP::Request->new(GET => '/'));
my $right_ret = <<'END';
\ {
    CONTENT_LENGTH      0,
    HTTP_HOST           "localhost",
    PATH_INFO           "/",
    psgi.errors         *main::STDERR  (write-only, layers: unix perlio),
    psgi.input          *HTTP::Message::PSGI::$input  (layers: scalar),
    psgi.multiprocess   "",
    psgi.multithread    "",
    psgi.nonblocking    "",
    psgi.run_once       1,
    psgi.streaming      1,
    psgi.url_scheme     "http",
    psgi.version        [
        [0] 1,
        [1] 1
    ],
    QUERY_STRING        "",
    REMOTE_ADDR         "127.0.0.1",
    REMOTE_HOST         "localhost",
    REMOTE_PORT         ?,
    REQUEST_METHOD      "GET",
    REQUEST_URI         "/",
    SCRIPT_NAME         "",
    SERVER_NAME         "localhost",
    SERVER_PORT         80,
    SERVER_PROTOCOL     "HTTP/1.1"
}
END
my $ret = $res->content;
$ret =~ s/(REMOTE_PORT\s+)\d+/$1\?/ms;
is($ret, $right_ret, 'Get main page.');
