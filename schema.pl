my $credential = do {
  open my $fh, "<", "credential.pl" or die;
  my $src = do { local $/; <$fh> };
  eval "$src";
};
{
 #-- Schema Information

 schema_class => 'SeoulPM::Schema',

 connect_info => {
  %$credential,
  mysql_enable_utf8 => 1,
  PrintError => 1,
  RaiseError => 1,
  on_connect_do => [
   'SET NAMES utf8',
   'SET CHARACTER SET utf8',
  ],
 },

 loader_options => {
  dump_directory => 'lib',  
  components => [ 'InflateColumn::DateTime', 'TimeStamp', 'PassphraseColumn' ],
  relationships => 1,
  use_moose => 1,
  only_autoclean => 1,
  col_collision_map => 'column_%s',
  overwite_modifications => 1,
  datetime_undef_if_invalid => 1,
  result_base_class => 'SeoulPM::Schema::ResultBase',
  custom_column_info => sub {
    my ($table, $col_name, $col_info) = @_;
    if ($col_name eq 'password') {
        return {
            data_type        => 'text',
            passphrase       => 'rfc2307',
            passphrase_class => 'SaltedDigest',
            passphrase_args  => {
                algorithm   => 'SHA-1',
                salt_random => 20,
            },
            passphrase_check_method => 'check_passphrase',
        };
    } elsif ($col_name eq 'datetime_create') {
        return {
            set_on_create => 1
        };
    } elsif ($col_name eq 'datetime_modify') {
        return {
            set_on_update => 1
        };
    } elsif ($col_name eq 'datetime_delete') {
        return { };
    }
  },
 },
};
