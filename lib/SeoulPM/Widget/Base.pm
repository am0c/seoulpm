package SeoulPM::Widget::Base;
use Mojo::Base -base;

has 'id' => sub {
    my $self = shift;
    if (ref($self) =~ /^SeoulPM::Widget::(.+)$/) {
        return join "_", ( map { lc } split "::", $1 );
    }
};

has 'data';
has 'manager';

sub clone {
    my $self = shift;
    my $data = $self->data;
    my $w = $self->new(manager => $self->manager);

    return defined $data ? $w->data($data) : $w;
}

sub prepare {
    my $self = shift;
    my $ws = $self->manager->app->stash('post_widgets') || [];
    $self->before_prepare;

    $self->manager->app->stash(post_widgets => [ @$ws, {
        id => $self->id,
        data => $self->data,
    }]);
    
    $self->after_prepare;
    return $self;
}

sub before_prepare { }
sub after_prepare { }

1;
