package SeoulPM::Widget::Manager;
use Mojo::Base -base;

has widgets => sub { +{} };
has 'app';

sub widget {
    my ($self, $name, $data) = @_;

    my $w = $self->widgets->{$name} 
        || ($self->widgets->{$name} = $self->new_widget($name));

    $w = $w->clone;
    $w->data($data) if defined $data;
    $w;
}

sub new_widget {
    my ($self, $name) = @_;
    my $part = join "::", ( map { ucfirst } split "_", $name );
    my $module = "SeoulPM::Widget::${part}";

    my $w = eval "use ${module}; ${module}->new";
    die unless ref $w eq $module;
    return $w->manager($self);
}

1;
