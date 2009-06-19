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

    my ($user, $body, $channel) =
            ($args->{who}, $args->{body}, $args->{channel});

    assert($self->loaded);

    return undef
        unless $body =~ /youtube\.\w{2,3}\S+v=([\w-]+)/;

    my $videoid = $1;

    return "Matched YouTube link; video id: $videoid"
}
1;

