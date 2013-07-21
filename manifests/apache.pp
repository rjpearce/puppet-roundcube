define roundcube::apache(
  $docroot,
  $serveradmin,
  $vhost,
  $ensure=present) {

  validate_string($docroot, $vhost)

  apache::vhost::redirect { $vhost:
    ensure => $ensure,
    port   => 80,
    dest   => "https://$vhost";
  }
  apache::vhost { $vhost:
    ensure        => $ensure,
    port          => 443,
    ssl           => true,
    docroot       => $docroot,
    override      => 'all',
    logroot       => "/var/log/apache2/${vhost}",
    serveradmin   => $serveradmin,
  }
}

