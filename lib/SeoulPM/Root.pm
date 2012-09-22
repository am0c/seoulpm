package SeoulPM::Root;
use Mojo::Base 'SeoulPM::Page::Base';

has page_name => 'root';

sub login {
    my $self = shift;
    my $config = $self->app->plugin('Config');

    $self->stash(title => $config->{title}{root});
    $self->render('root/login');
}

sub logout {
    my $self = shift;
    delete $self->stash->{user_id};
    delete $self->session->{user_id};
    $self->redirect_to('/');
}

sub login_submit {
    my $self = shift;
    my $db = $self->app->db('User');
    
    if (defined $self->session->{user}) {
        $self->redirect_to('/');
    }

    my $user = $db->single({
        nickname => $self->req->param('user')
    });
    
    if (!defined $user) {
        return $self->redirect_to('/login');
    }
    if ($user->check_passphrase($self->req->param('pass'))) {
        $self->session(
            user_id => $user->get_column('id'),
        );
        return $self->redirect_to('/');
    }
    else {
        return $self->redirect_to('/login');
    }
}

sub comment {
    my $self = shift;
    my $page = $self->stash('page');
    my $page_id = $self->stash('id');
    my $user_id = $self->session->{user_id};

    if (!defined $user_id) {
        return $self->redirect_to("$page/$page_id");
    }

    $self->db(ucfirst($page)."Cmt")->create({
        post_id => $page_id,
        user_id => $user_id,
        text => $self->param('text'),
    });

    return $self->redirect_to("$page/$page_id");
}

sub auto {
    my $self = shift;
    my $user_id = $self->session->{user_id};
    if (defined $user_id) {
        $self->stash(user => $self->db('User')->single({id => $user_id}));
    }
    else {
        $self->stash(user => undef);
    }
    $self->app->w_manager->app($self->app);

    return 1;
}

1;
