package Mojolicious::Plugin::MoreHelpers;
use Mojo::Base 'Mojolicious::Plugin';
use Mojolicious::Plugin::DefaultHelpers;

our $VERSION = '0.01';

sub register {
    my ($self, $app) = @_;
    
    $app->helper(content_after => \&_content_helper);
}

sub _content_helper {
    my ($self, $name) = (shift, shift);
    local *_content = \&Mojolicious::Plugin::DefaultHelpers::_content;
    _content($self, $name, @_, _content($self, $name));
}


1;
__END__

=head1 NAME

Mojolicious::Plugin::MoreHelpers - Mojolicious Plugin

=head1 SYNOPSIS

  # Mojolicious
  $self->plugin('MoreHelpers');

  # Mojolicious::Lite
  plugin 'MoreHelpers';

=head1 DESCRIPTION

L<Mojolicious::Plugin::MoreHelpers> is a L<Mojolicious> plugin.

=head1 METHODS

L<Mojolicious::Plugin::MoreHelpers> inherits all methods from
L<Mojolicious::Plugin> and implements the following new ones.

=head2 C<register>

  $plugin->register(Mojolicious->new);

Register plugin in L<Mojolicious> application.

=head1 SEE ALSO

L<Mojolicious>, L<Mojolicious::Guides>, L<http://mojolicio.us>.

=cut
