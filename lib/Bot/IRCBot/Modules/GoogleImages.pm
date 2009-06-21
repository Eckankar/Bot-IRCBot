#!/usr/bin/env perl
package Bot::IRCBot::Modules::GoogleImages;
use Moose;
use Carp::Assert;
use JSON;
use LWP::Simple;

extends 'Bot::IRCBot::Module';

use constant {
    DEVKEY => "ABQIAAAAIlzQlYE_XUpT2_ADo1nSfRTuKWVDkilQiDX2X".
              "znjpeugS3EiWRTzG323J-Yy8xDC1Kg1dVDpkDWfzg"
};

has 'name' => (
    is      => 'ro',
    isa     => 'Str',
    default => 'Google ImageSearch',
);

sub said {
    my $self = shift;
    my $args = shift;

    my ($user, $body, $channel) =
            ($args->{who}, $args->{body}, $args->{channel});

    assert($self->loaded);

    return undef
        unless $body =~ /^!gis (.+)/i;

    my $query = $1;

    my $url = "http://www.google.com/uds/GimageSearch?context=0".
              "&lstkp=0&rsz=small&hl=en&source=gsc&gss=.com".
              "&sig=ceae2b35bf374d27b9d2d55288c6b495&q=${query}".
              "&safe=off&key=".DEVKEY."&v=1.0";

    my $response = decode_json(get $url);

    my @results = @{ $response->{responseData}{results} };

    my $result = (
        @results == 0 ?
        "No results found." :
        $results[rand @results]->{url}
    );

    return sprintf(
        "Google ImageSearch for %s: %s",
        $query,
        $result
    );
}

1;

