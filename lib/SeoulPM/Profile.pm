package SeoulPM::Profile;
use Mojo::Base 'Mojolicious::Controller';

has page_name => 'profile';

sub index {
    my $self = shift;
    $self->render('profile');
}

1;
