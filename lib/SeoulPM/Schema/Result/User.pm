use utf8;
package SeoulPM::Schema::Result::User;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

SeoulPM::Schema::Result::User

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

=head1 TABLE: C<user>

=cut

__PACKAGE__->table("user");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

=head2 nickname

  data_type: 'char'
  is_nullable: 0
  size: 16

=head2 realname

  data_type: 'char'
  is_nullable: 1
  size: 32

=head2 password

  data_type: 'text'
  is_nullable: 0
  passphrase: 'rfc2307'
  passphrase_args: {algorithm => "SHA-1",salt_random => 20}
  passphrase_check_method: 'check_passphrase'
  passphrase_class: 'SaltedDigest'
  size: 140

=head2 datetime_create

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 0
  set_on_create: 1

=head2 datetime_access

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=head2 datetime_delete

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=head2 is_enabled

  data_type: 'tinyint'
  default_value: 1
  is_nullable: 0

=head2 bio

  data_type: 'tinytext'
  is_nullable: 0

=head2 email

  data_type: 'char'
  is_nullable: 0
  size: 255

=head2 link

  data_type: 'char'
  is_nullable: 1
  size: 80

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type => "integer",
    extra => { unsigned => 1 },
    is_auto_increment => 1,
    is_nullable => 0,
  },
  "nickname",
  { data_type => "char", is_nullable => 0, size => 16 },
  "realname",
  { data_type => "char", is_nullable => 1, size => 32 },
  "password",
  {
    data_type => "text",
    is_nullable => 0,
    passphrase => "rfc2307",
    passphrase_args => { algorithm => "SHA-1", salt_random => 20 },
    passphrase_check_method => "check_passphrase",
    passphrase_class => "SaltedDigest",
    size => 140,
  },
  "datetime_create",
  {
    data_type => "datetime",
    datetime_undef_if_invalid => 1,
    is_nullable => 0,
    set_on_create => 1,
  },
  "datetime_access",
  {
    data_type => "datetime",
    datetime_undef_if_invalid => 1,
    is_nullable => 1,
  },
  "datetime_delete",
  {
    data_type => "datetime",
    datetime_undef_if_invalid => 1,
    is_nullable => 1,
  },
  "is_enabled",
  { data_type => "tinyint", default_value => 1, is_nullable => 0 },
  "bio",
  { data_type => "tinytext", is_nullable => 0 },
  "email",
  { data_type => "char", is_nullable => 0, size => 255 },
  "link",
  { data_type => "char", is_nullable => 1, size => 80 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 UNIQUE CONSTRAINTS

=head2 C<nickname>

=over 4

=item * L</nickname>

=back

=cut

__PACKAGE__->add_unique_constraint("nickname", ["nickname"]);


# Created by DBIx::Class::Schema::Loader v0.07033 @ 2012-09-17 08:29:03
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:kJZa6lxIC7fQfNMfBBje/Q

__PACKAGE__->has_many(userroles => 'SeoulPM::Schema::Result::UserRole', 'user_id');
__PACKAGE__->many_to_many(roles => 'userroles', 'role_id');

sub get_roles {
    my ( $self ) = @_;
    return map { $_->get_column('name') } $self->roles;
}

sub has_role {
    my ( $self, $rolename ) = @_;
    return defined $self->roles->single({ name => $rolename });
}

__PACKAGE__->meta->make_immutable;
1;
