package Bot::IRCBot;
use Moose;
use YAML 'LoadFile';

extends 'Bot::BasicBot';

do {
    my $conf;
    sub conf {
        $conf = LoadFile('etc/ircbot.conf')
            unless ($conf);

        return $conf->{$_[0]} if @_;
        return wantarray ? %$conf : $conf;
    }
};

1;

