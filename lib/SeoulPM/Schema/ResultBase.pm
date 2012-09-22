package SeoulPM::Schema::ResultBase;
use Moose;
use MooseX::NonMoose;
use namespace::autoclean;

extends 'DBIx::Class::Core';

__PACKAGE__->load_components(qw/
  InflateColumn::DateTime
  TimeStamp
  PassphraseColumn
/);

__PACKAGE__->meta->make_immutable;

1;
