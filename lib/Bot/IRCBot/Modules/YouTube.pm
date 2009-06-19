#!/usr/bin/env perl
package Bot::IRCBot::Modules::YouTube;
use Moose;
use Carp::Assert;

extends 'Bot::IRCBot::Module';

has 'name' => (
    is      => 'r',
    isa     => 'Str',
    default => 'YouTube Information',
);

sub said {
    $self = shift;
    $args = shift;

    assert();
}
1;

