define roundcube::mysql(
  $mysql_hostname,
  $mysql_password,
  $mysql_username,
  $mysql_dbname,
  $mysql_import,
  $ensure=present) {

  if ($ensure =~ /present/) {
    exec { "load ${mysql_dbname} initial database":
      command => "mysql -u root ${mysql_dbname} < ${mysql_import}",
      path    => '/usr/bin',
      unless  => "test `mysql ${mysql_dbname} -e 'show tables' | wc -l` -gt 1",
      onlyif  => "test -f ${mysql_import}",
      require => [
        Mysql::Db[$mysql_dbname],
        Exec["extract roundcube archive for ${name}"]
      ];
    }
  }
  mysql::db { $mysql_dbname:
    ensure   => $ensure,
    user     => $mysql_username,
    password => $mysql_password,
    host     => $mysql_hostname,
    grant    => ['all'],
  }
}

