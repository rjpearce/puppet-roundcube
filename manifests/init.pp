define roundcube(
  $mysql_password,
  $mysql_username,
  $vhost=$name,
  $mysql_dbname=$name,
  $mysql_hostname='localhost',
  $create_vhost=true,
  $create_db=true,
  $docroot="/var/www/$name",
  $serveradmin='root@localhost',
  $imap_server='localhost',
  $imap_port='993',
  $imap_auth_type='null',
  $smtp_server='localhost',
  $smtp_port='25',
  $version='0.9.1',
  $ensure=present
) {

  $archive_name="roundcubemail-${version}.tar.gz"
  $download_url="http://downloads.sourceforge.net/project/roundcubemail/roundcubemail/${version}/roundcubemail-${version}.tar.gz?r=http%3A%2F%2Froundcube.net%2Fdownload"

  roundcube::install { $name:
    ensure       => $ensure,
    docroot      => $docroot,
    archive_name => $archive_name,
    download_url => $download_url;
  }
  roundcube::config { $name:
    ensure         => $ensure,
    mysql_password => $mysql_password,
    mysql_username => $mysql_username,
    docroot        => $docroot,
    mysql_hostname => $mysql_hostname,
    mysql_dbname   => $mysql_dbname,
    vhost          => $vhost,
    serveradmin    => $serveradmin,
    create_vhost   => $create_vhost,
    create_db      => $create_db,
    imap_server    => $imap_server,
    imap_port      => $imap_port,
    imap_auth_type => $imap_auth_type,
    smtp_server    => $smtp_server,
    smtp_port      => $smtp_port;
  }
}

