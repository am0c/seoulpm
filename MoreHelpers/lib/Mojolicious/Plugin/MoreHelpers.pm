package Mojolicious::Plugin::MoreHelpers;
use Mojo::Base 'Mojolicious::Plugin';
use Mojolicious::Plugin::DefaultHelpers;
use Mojolicious 3.43;

our $VERSION = '0.02';

sub register {
    my ($self, $app) = @_;
    
    $app->helper(content_after => \&_content_after);
}

sub _content {
    my ($self, $name, $content) = @_;
    $name ||= 'content';

    # Set (first come)
    my $c = $self->stash->{'mojo.content'} ||= {};
    $c->{$name} ||= ref $content eq 'CODE' ? $content->() : $content
        if defined $content;

    # Get
    return Mojo::ByteStream->new($c->{$name} // '');
}

# sub _content_for {
#     my ($self, $name, $content) = @_;
#     return _content($self, $name) unless defined $content;
#     my $c = $self->stash->{'mojo.content'} ||= {};
#     return $c->{$name} .= ref $content eq 'CODE' ? $content->() : $content;
# }

sub _content_after {
    my ($self, $name, $content) = @_;
    return _content($self, $name) unless defined $content;
    my $c = $self->stash->{'mojo.content'} ||= {};
    my $t = (ref $content eq 'CODE' ? $content->() : $content);
    $c->{$name} = '' unless defined $c->{$name};
    $c->{$name} = $t . $c->{$name};
    return $c->{$name};
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
