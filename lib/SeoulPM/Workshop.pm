package SeoulPM::Workshop;
use Mojo::Base 'SeoulPM::Page::Base';

has page_name => 'workshop';

sub test {
    my $self = shift;
    $self->render('component/page/workshop');
}

1;
