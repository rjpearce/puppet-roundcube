define roundcube::config(
  $docroot,
  $vhost,
  $serveradmin,
  $create_vhost,
  $create_db,
  $mysql_password,
  $mysql_username,
  $mysql_hostname,
  $mysql_dbname,
  $imap_server,
  $imap_port,
  $imap_auth_type,
  $smtp_server,
  $smtp_port,
  $ensure=present) {

  validate_string(
    $docroot,
    $vhost,
    $mysql_password,
    $mysql_username,
    $mysql_hostname,
    $mysql_dbname,
    $imap_server,
    $imap_port,
    $imap_auth_type,
    $smtp_server,
    $smtp_port
  )

  $mysql_db_dsnw = "mysql://${mysql_username}:${mysql_password}@${mysql_hostname}/${mysql_dbname}"

  file {
    "$docroot/config/db.inc.php":
      ensure  => $ensure,
      content => template('roundcube/db.inc.php.erb');

    "$docroot/config/main.inc.php":
      ensure  => $ensure,
      content => template('roundcube/main.inc.php.erb');
  }

  if ($create_db =~ /true/) {
    roundcube::mysql { $name:
      ensure         => $ensure,
      mysql_import   => "$docroot/SQL/mysql.initial.sql",
      mysql_dbname   => $mysql_dbname,
      mysql_hostname => $mysql_hostname,
      mysql_username => $mysql_username,
      mysql_password => $mysql_password,
    }
  }
  if ($create_vhost =~ /true/) {
    roundcube::apache { $name:
      ensure      => $ensure,
      vhost       => $name,
      serveradmin => $serveradmin,
      docroot     => $docroot;
    }
  }
}

