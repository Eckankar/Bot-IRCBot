#!/usr/bin/env perl
package Bot::IRCBot::Modules::UrbanDictionary;
use Moose;
use Carp::Assert;
use WWW::Search;


extends 'Bot::IRCBot::Module';

use constant {
    # Stolen from https://cyanox.nl/trac/noxbot/changeset/21
    DEVKEY => "a237993550175803efbf9530ff4de2bc"
};

has 'name' => (
    is      => 'ro',
    isa     => 'Str',
    default => 'Urban Dictionary lookup',
);

sub said {
    my $self = shift;
    my $args = shift;

    my ($user, $body, $channel) =
            ($args->{who}, $args->{body}, $args->{channel});

    assert($self->loaded);

    return undef
        unless $body =~ /!urban (.+)/i;

    my $query = $1;

    my $urban = WWW::Search->new("UrbanDictionary", key => DEVKEY);

    $urban->native_query($query);

    my $start = sprintf("UrbanDictionary lookup of %s", $query);

    my $res = $urban->next_result();

    return sprintf("%s: No definition found.", $start)
        unless defined($res);

    return sprintf(
        "%s:\n%s\n%s",
        $start,
        $res->{'definition'},
        $res->{'example'}
    );
}

1;

