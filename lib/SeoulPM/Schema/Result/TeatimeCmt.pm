use utf8;
package SeoulPM::Schema::Result::TeatimeCmt;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

SeoulPM::Schema::Result::TeatimeCmt

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

=head1 TABLE: C<teatime_cmt>

=cut

__PACKAGE__->table("teatime_cmt");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

=head2 post_id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 0

=head2 user_id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 0

=head2 text

  data_type: 'varchar'
  is_nullable: 0
  size: 1000

=head2 datetime_create

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 0
  set_on_create: 1

=head2 datetime_delete

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=head2 is_published

  data_type: 'tinyint'
  default_value: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type => "integer",
    extra => { unsigned => 1 },
    is_auto_increment => 1,
    is_nullable => 0,
  },
  "post_id",
  { data_type => "integer", extra => { unsigned => 1 }, is_nullable => 0 },
  "user_id",
  { data_type => "integer", extra => { unsigned => 1 }, is_nullable => 0 },
  "text",
  { data_type => "varchar", is_nullable => 0, size => 1000 },
  "datetime_create",
  {
    data_type => "datetime",
    datetime_undef_if_invalid => 1,
    is_nullable => 0,
    set_on_create => 1,
  },
  "datetime_delete",
  {
    data_type => "datetime",
    datetime_undef_if_invalid => 1,
    is_nullable => 1,
  },
  "is_published",
  { data_type => "tinyint", default_value => 1, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.07033 @ 2012-09-20 23:51:03
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:kd88hjLvIRXK+r/nVasN5Q
__PACKAGE__->has_one(user => 'SeoulPM::Schema::Result::User', { 'foreign.id' => 'self.user_id' });

# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
