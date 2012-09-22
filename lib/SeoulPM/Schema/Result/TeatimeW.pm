use utf8;
package SeoulPM::Schema::Result::TeatimeW;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

SeoulPM::Schema::Result::TeatimeW

=cut

use strict;
use warnings;

=head1 BASE CLASS: L<SeoulPM::Schema::ResultBase>

=cut

use Moose;
use MooseX::NonMoose;
use namespace::autoclean;
extends 'SeoulPM::Schema::ResultBase';

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::InflateColumn::DateTime>

=item * L<DBIx::Class::TimeStamp>

=item * L<DBIx::Class::PassphraseColumn>

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime", "TimeStamp", "PassphraseColumn");

=head1 TABLE: C<teatime_w>

=cut

__PACKAGE__->table("teatime_w");

=head1 ACCESSORS

=head2 post_id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 0

=head2 order

  data_type: 'tinyint'
  default_value: 0
  extra: {unsigned => 1}
  is_nullable: 0

=head2 name

  data_type: 'char'
  is_nullable: 0
  size: 32

=head2 data

  data_type: 'varchar'
  is_nullable: 1
  size: 1024

=cut

__PACKAGE__->add_columns(
  "post_id",
  { data_type => "integer", extra => { unsigned => 1 }, is_nullable => 0 },
  "order",
  {
    data_type => "tinyint",
    default_value => 0,
    extra => { unsigned => 1 },
    is_nullable => 0,
  },
  "name",
  { data_type => "char", is_nullable => 0, size => 32 },
  "data",
  { data_type => "varchar", is_nullable => 1, size => 1024 },
);


# Created by DBIx::Class::Schema::Loader v0.07033 @ 2012-09-21 02:52:02
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:t4gfR+SVT+J5W67LeO7JqQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
