package SeoulPM::Schema::ResultSet::User;
use Moose;
use MooseX::NonMoose;
use namespace::autoclean;

extends 'DBIx::Class::ResultSet';

sub BUILDARGS { $_[2] }

sub has_role {
    my ( $self, $rolename ) = @_;
    return defined $self->roles->single({ name => $rolename });
}

__PACKAGE__->meta->make_immutable;
1;
