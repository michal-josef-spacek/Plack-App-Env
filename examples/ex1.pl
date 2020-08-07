#!/usr/bin/env perl

use strict;
use warnings;

use Plack::App::Env;
use Plack::Runner;

# Run application with one PYX file.
my $app = Plack::App::Env->new->to_app;
Plack::Runner->new->run($app);

# Output:
# HTTP::Server::PSGI: Accepting connections at http://0:5000/

# > curl http://localhost:5000/
# TODO