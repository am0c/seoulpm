package SeoulPM::Model::Page::Base;
use Mojo::Base -base;

has 'table_name';

sub new {
    my $class = shift;
    my ($schema, @args) = @_;
    return bless { 
        db => $schema,
        args => [ @args ],
    }, $class;
}

sub widgets {
    return undef;
}

sub posts {
    my $self = shift;
    die unless defined( my $table = $self->table_name );
    return $self->{db}->resultset($table)->search_rs({
        datetime_delete => undef,
        is_published => 1,
    }, {
        rows => 10,
        page => 0,
        order_by => { -desc => 'datetime_create' },
    });
}

1;
