package SeoulPM::Model::Page::Root;
use Mojo::Base 'SeoulPM::Model::Page::Base';

has table_name => 'Root';

sub posts {
    return undef;
}

1;
