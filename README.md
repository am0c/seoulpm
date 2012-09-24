


credential.pl
-------------

    {
      database => 'seoulpm',
      dsn  => 'dbi:mysql:database=seoulpm;host=localhost',
      user => '***',
      pass => '***',
      password => '***',
    }


How to load MySQL schema first time
-----------------------------------

Read `schema/` files alphabetically.

    mysql -u root -p < schema/*


How to dump modified MySQL schema
----------------------------------

Just execute the script below to create new dump file
which records only schema alternations with new file.

    script/seoul_pm_mysqldump