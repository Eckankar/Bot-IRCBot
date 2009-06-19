#!/usr/bin/env perl
package Bot::IRCBot::Module;
use Moose;

has 'name' => (
    is      => 'r',
    isa     => 'Str',
    default => 'Default Module Name (override this!)',
);

has 'loaded' => (
    is      => 'rw',
    isa     => 'Bool',
    default => 0,
);

sub init {
    my $self = shift;
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
}

1;


