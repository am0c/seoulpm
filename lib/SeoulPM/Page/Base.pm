package SeoulPM::Page::Base;
use Mojo::Base 'Mojolicious::Controller';

has page_name => undef;

# This action will render a template
sub index {
    my $self = shift;
    $self->_validate;

    my $config = $self->app->plugin('Config');
    my $name = $self->page_name;

    $self->stash(title => $config->{title}{$name});
    $self->stash(page_name => $self->page_name);
    $self->stash(page_posts => $self->page($name)->posts);
    $self->stash(page_widgets => $self->page($name)->widgets);

    $self->render('component/page/index');
}

sub post {
    my $self = shift;
    $self->_validate;

    my $user_id = $self->session('user_id');
    my $user = $self->db('User')->single({ id => $user_id });

    if (defined $user && $user->has_role('admin')) {
        return $self->render('component/page/post');
    }
    else {
        return $self->redirect_to($self->_base_url);
    }
}

sub submit {
    my $self = shift;
    $self->_validate;

    my $user_id = $self->session('user_id');
    my $user = $self->db('User')->single({ id => $user_id });

    if (!defined $user || !$user->has_role('admin')) {
        return $self->redirect_to($self->_base_url);
    }

    # Unicode decoded automatically
    my $title = $self->param('title');
    my $body = $self->param('body');

    require HTML::TreeBuilder::LibXML;
    require Text::MultiMarkDown;

    my $tree = HTML::TreeBuilder::LibXML->new;
    $tree->parse(Text::MultiMarkDown::markdown($body));

    $self->db($self->_base_model)->create({
        writer_id => $user_id,
        title => $title,
        text => $body,
        text_striped => $tree->as_trimmed_text,
    });

    $tree->eof;
    return $self->redirect_to($self->_base_url);
}

sub view {
    my $self = shift;
    $self->_validate;
    
    my $config = $self->app->plugin('Config');
    my $id = $self->param('id');
    my $rs = $self->db($self->_base_model)->single({id => $id});
    my $name = $self->page_name;

    if (defined $rs) {
        for my $rs ($rs->widgets) {
            my $w = $self->widget($rs->name, $rs->data);
            $w->prepare;
        }

        $self->stash(title => $config->{title}{$name});
        $self->stash(page_id => $id);
        $self->stash(page_name => $name);
        $self->stash(page_post => $rs);
        $self->render('component/page/view');
    }
    else {
        $self->redirect_to($self->_base_url);
    }
}

sub _base_url {
    my $self = shift;
    return $self->url_for($self->page_name);
}

sub _base_model {
    my $self = shift;
    return ucfirst $self->page_name;
}

sub _validate {
    my $self = shift;
    die unless defined $self->page_name;
}

1;
