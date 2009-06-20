#!/usr/bin/env perl
package Bot::IRCBot::Modules::YouTube;
use Moose;
use Carp::Assert;
use XML::Smart;

extends 'Bot::IRCBot::Module';

use constant {
    DEVKEY => "AI39si7Go6tZquV3D4E-8_J-DsF81lJkoeOhgtw4RFmCdrvQ".
              "PYzrZW7E57u_ZJ_IjCggDu6kIyNWGPQ7u0H-0_pQol-I6xRPvg"
};

has 'name' => (
    is      => 'ro',
    isa     => 'Str',
    default => 'YouTube Information',
);

sub said {
    my $self = shift;
    my $args = shift;

    my ($user, $body, $channel) =
            ($args->{who}, $args->{body}, $args->{channel});

    assert($self->loaded);

    return undef
        unless $body =~ /youtube\.\w{2,3}\S+v=([\w-]+)/i;

    my $video_id = $1;

    my $xml = XML::Smart->new(
        "http://gdata.youtube.com/feeds/api/videos/$video_id"
    );


    my $entry = $xml->{entry};

    return sprintf(
        "YouTube: \"%s\" (uploaded by: %s) (avg rating %.2f after %d votes)",
        $entry->{title}->content,
        $entry->{author}{name}->content,
        $entry->{"gd:rating"}{average},
        $entry->{"gd:rating"}{numRaters}
    );
}

1;

