#!/usr/bin/env perl
package Bot::IRCBot::Module;
use Moose;
use Carp::Assert;

has 'name' => (
    is      => 'ro',
    isa     => 'Str',
    default => 'Default Module Name (override this!)',
);

has 'loaded' => (
    is      => 'rw',
    isa     => 'Bool',
    default => 0,
);

has 'bot' => (
    is      => 'rw',
    isa     => 'Bot::BasicBot',
);

sub init {
    my $self = shift;
    $self->bot(shift);
}

sub load {
    my $self = shift;

    return 0 if $self->loaded;

    $self->loaded(1);
    return 1;
}

sub unload {
    my $self = shift;

    return 0 unless $self->loaded;

    $self->loaded(0);
    return 1;
}

sub said {
    my $self = shift;
    my $args = shift;

    assert($self->loaded);
}


1;


