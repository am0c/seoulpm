package SeoulPM::Profile;
use Mojo::Base 'Mojolicious::Controller';
use File::Path qw(make_path);

has page_name => 'profile';

sub index {
    my $self = shift;
    $self->render('profile/default');
}

sub edit_info {
    my $self = shift;
    $self->render('profile/edit_info');
}

sub edit_info_submit {
    my $self = shift;

    use File::Type;
    use GD;

    my $picture = $self->param('pic');
    
    if (ref $picture && UNIVERSAL::isa($picture, "Mojo::Upload")) {
        my $data = $picture->asset->slurp;
        my $type = File::Type->new->checktype_contents($data);
        my $img;

        if ($type !~ m{^image/}) {
            $self->flash('Type of file is not an image.');
            $self->redirect_to('profile/edit/info');
        }
        elsif ($type =~ m{png$}) {
            $img = GD::Image->newFromPngData($data);
        }
        elsif ($type =~ m{jpeg$}) {
            $img = GD::Image->newFromJpegData($data);
        }
        elsif ($type =~ m{gif$}) {
            $img = GD::Image->newFromGifData($data);
        }
        else {
            $self->flash('The file type of you submitted is not supported currently.');
            return $self->redirect_to('profile/edit/info');
        }

        my $dir = "/profile_image";
        my $user = $self->stash('user');
        my $id = $user->get_column('id');

        $self->_save_profile_with_size($img, $id, "full.png");
        $self->_save_profile_with_size($img, $id, "default.png", 200);
        $self->_save_profile_with_size($img, $id, "thumb.png", 40);

        $user->update({
            image_full => "$dir/$id/full.png",
            image_default => "$dir/$id/default.png",
            image_thumb => "$dir/$id/thumb.png",
        });

        return $self->redirect_to('profile/edit/info');
    }

    return $self->redirect_to('profile/edit/info');
}

sub edit_preference {
    my $self = shift;
    $self->render('profile/edit_preference');
}

sub edit_preference_submit {}

sub edit_password {
    my $self = shift;
    $self->render('profile/edit_password');
}

sub edit_password_submit {}

# -- /edit bridge

sub edit {
    my $self = shift;
    if (defined $self->stash('user')) {
        return 1;
    }
    else {
        return $self->redirect_to('/');
    }
}

# -- private methods

sub _create_profile_image {
    my ($self, $image, $new_size) = @_;

    return $image unless defined $new_size;

    my $width = $image->width;
    my $height = $image->height;

    my $crop = do {
        my ($wide, $short);
        my @pos;

        if ($width >= $height) {
            ($wide, $short) = ($width, $height);
            @pos = (($wide - $short) / 2, 0);
        }
        else {
            ($wide, $short) = ($height, $width);
            @pos = (0, ($wide - $short) / 2);
        }

        my $img = GD::Image->new($short, $short);
        $img->copy(
             $image,
             (0, 0),
             @pos,
             ($short, $short),
        );
        $img;
    };
    
    my $size = $crop->width;
    my $img = GD::Image->new($new_size, $new_size);

    if ($new_size > $size) {
        $img->copyResized(
            $crop,
            (0, 0) => (0, 0),
            ($new_size) x 2, ($size) x 2,
        );
    }
    else {
        $img->copyResampled(
            $crop,
            (0, 0) => (0, 0),
            ($new_size) x 2, ($size) x 2,
        );
    }
    
    $img;
}

sub _save_profile_with_size {
    my ($self, $image, $id, $fn, $size) = @_;
    my $path = $self->app->home->rel_dir("data/profile_image") . "/" . $id;
    make_path($path);

    open my $fh, ">", "$path/$fn" or die "$path: $!";
    binmode $fh;
    print { $fh } $self->_create_profile_image($image, $size)->png;
}


1;
