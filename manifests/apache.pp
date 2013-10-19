define roundcube::apache(
  $docroot,
  $serveradmin,
  $vhost,
  $ensure=present) {

  validate_string($docroot, $vhost)

  apache::vhost { "$vhost redirect":
    ensure          => $ensure,
    docroot         => $docroot,
    port            => '80',
    redirect_dest   => "https://$vhost",
    redirect_status => 'permanent';
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

