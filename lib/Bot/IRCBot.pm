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
    is          => 'rw',
    isa         => 'ArrayRef',
    default     => sub { [] },
);

sub init {
    my $self = shift;

    my @plugins = ();

    foreach my $plugin (@{conf->{plugins}}) {
        Class::MOP::load_class("Bot::IRCBot::Modules::$plugin");
        push @plugins, "Bot::IRCBot::Modules::$plugin"->new();
    }

    $self->plugins(\@plugins);

    use Data::Dumper;

    foreach my $plugin (@{$self->plugins}) {
        $plugin->init($self) or return 0;
        $plugin->load() or return 0;
    }

    return 1;
}

sub said {
    my $self = shift;
    my @output = ();


    foreach my $plugin (@{$self->plugins}) {
        next unless $plugin->loaded;

        my $ret = $plugin->said(@_);

        push @output, $ret if $ret;
    }

    return join "\n", @output;
}

1;

