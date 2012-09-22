package SeoulPM::Plugin::MoreHelpers;
use Mojo::Base 'Mojolicious::Plugin';
use Mojolicious::Plugin::DefaultHelpers;

sub register {
    my ($self, $app) = @_;
    
    $app->helper(content_after => sub {
        my ($self, $name) = (shift, shift);
        _content($self, $name, @_, _content($self, $name));
    });
}

local *_content = Mojolicious::Plugin::DefaultHelpers::_content;

1;
