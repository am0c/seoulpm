package SeoulPM::Model::Page;
use warnings;
use strict;

no strict 'refs';

sub new {
    my ($class, $schema) = @_;
    $schema->isa('DBIx::Class::Schema') or die;
    return bless { 
        schema => $schema,
        pagers => {},
    }, $class;
}

sub page_to {
    my ($self, $name) = @_;

    die unless $name eq lc $name;

    if (!defined $self->{pagers}{$name}) {
        my $subclass = join "::",  __PACKAGE__, ucfirst $name;
        eval "require $subclass";
        die $@ if $@;
        $self->{pagers}{$name} = $subclass->new($self->{schema});
    }

    return $self->{pagers}{$name};
}

1;
