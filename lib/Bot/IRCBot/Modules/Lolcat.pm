#!/usr/bin/env perl
package Bot::IRCBot::Modules::Lolcat;
use Moose;
use Carp::Assert;
use XML::Smart;

extends 'Bot::IRCBot::Module';

has 'name' => (
    is      => 'ro',
    isa     => 'Str',
    default => 'Random lolcat',
);

sub said {
    my $self = shift;
    my $args = shift;

    my ($user, $body, $channel) =
            ($args->{who}, $args->{body}, $args->{channel});

    assert($self->loaded);

    return undef
        unless $body =~ /^!lolcat/i;

    my $xml = XML::Smart->new(
        "http://api.cheezburger.com/xml/category/cats/lol/random"
    );

    return sprintf(
        "Random lolcat: %s",
        $xml->{Lol}{LolImageUrl}->content
    );
}

1;

