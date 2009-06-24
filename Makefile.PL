use inc::Module::Install;

name           'Bot-IRCBot';
all_from       'lib/Bot/IRCBot.pm';
githubmeta;

requires 'Bot::BasicBot';
requires 'YAML';
requires 'Moose';
requires 'Carp::Assert';

# Google ImageSearch
recommends 'JSON';
recommends 'LWP::Simple';

# YouTube, among others
recommends 'XML::Smart';

# UrbanDictionary
recommends 'WWW::Search';
recommends 'WWW::Search::UrbanDictionary';

WriteAll;

