package SeoulPM;
use Mojo::Base 'Mojolicious';
use SeoulPM::Schema;
use SeoulPM::Model::Page;
use SeoulPM::Widget::Manager;

has schema => sub {
    my $self = shift;
    my $config = $self->plugin('Config', file => 'schema.pl');
    SeoulPM::Schema->connect($config->{connect_info});
};

has pager => sub {
    my $self = shift;
    SeoulPM::Model::Page->new($self->app->schema);
};

has w_manager => sub {
    SeoulPM::Widget::Manager->new;
};

# This method will run once at server start
sub startup {
    my $self = shift;

    $self->defaults(post_widgets => []);

    $self->plugin('MoreHelpers');

    $self->helper('widget', sub {
        my $self = shift;
        $self->app->w_manager->app($self)->widget(@_);
    });
    $self->helper('schema', sub { $self->app->schema });
    $self->helper('db', sub { $self->app->schema->resultset($_[1]) });
    $self->helper('page', sub {
        my $self = shift;
        return $self->app->pager->page_to(@_);
    });

    # Router
    my $r = $self->routes;

    # Normal route to controller
    
    $r = $r->bridge('/')->to('root#auto');

    $r->get('/')->to('root#index');
    $r->get('/login')->to('root#login');
    $r->get('/logout')->to('root#logout');
    $r->post('/login/submit')->to('root#login_submit');

    $r->route('/:page/:id/comment/submit',
             id   => qr/\d+/,
             page => [ qw/news techlog workshop teatime/ ],
        )->via('POST')->to('root#comment');

    my $teatime = $r->route('/teatime')->to(controller => 'teatime');

    $teatime->route('/')->via('GET')->to(action => 'index')->name('teatime');
    $teatime->route('/:id', id => qr/\d+/)->via('GET')->to(action => 'view')->name('teatime_id');
    $teatime->route('/post')->via('GET')->to(action => 'post')->name('teatime_post');
    $teatime->route('/post/submit')->via('POST')->to(action => 'submit')->name('teatime_post_submit');

    $r->get('/news')->to('news#index');
    $r->get('/techlog')->to('techlog#index');
    $r->get('/workshop')->to('workshop#index');
    $r->get('/profile')->to('profile#index');

    $r->get('/test')->to('workshop#test');
}

1;

