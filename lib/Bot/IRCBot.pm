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

has plugins => (
    metaclass   => 'Collection::List',
    is          => 'rw',
    isa         => 'ArrayRef',
    default     => sub { [] },
);

sub init {
    my $self = shift;

    foreach my $plugin (conf->{plugins}) {
        use "Bot::IRCBot::Plugins::$plugin";
        push $self->plugins, Bot::IRCBot::Plugins::$plugin->new();
    }

    foreach my $plugin ($self->plugins) {
        $plugin->load;
    }
}

sub said {
    my $self = shift;
    my @output = ();


    foreach my $plugin (conf->{plugins}) {
        next unless $plugin->loaded;

        my $ret = $plugin->said(@_);

        push @output, $ret if $ret;
    }

    return join "\n", @output;
}

1;

