define roundcube::install(
  $docroot,
  $archive_name,
  $download_url,
  $ensure=present
) {
  case $ensure {
    /absent/: { $directory_ensure = 'absent' }
    default:  { $directory_ensure = 'directory' }
  }
  file {
    $docroot:
      ensure  => $directory_ensure,
      owner   => 'www-data',
      group   => 'www-data',
      recurse => true;

    "$docroot/config":
      ensure  => $directory_ensure;

    "$docroot/temp":
      ensure => $ensure,
      owner  => 'www-data',
      group  => 'www-data',
      mode   => '0770';

    "$docroot/logs":
      ensure => $ensure,
      owner  => 'www-data',
      group  => 'www-data',
      mode   => '0770';
  }
  if ($ensure =~ /present/) {
    exec {
      "download roundcube archive for ${name}":
        command => "wget ${download_url} -O ${docroot}/${archive_name}",
        path    => ['/bin', '/usr/bin'],
        creates => "${docroot}/${archive_name}";

      "extract roundcube archive for ${name}":
        command => "tar -zxvf ${archive_name} --strip-components=1",
        path    => ['/bin', '/usr/bin'],
        cwd     => $docroot,
        onlyif  => "test -f ${docroot}/${archive_name}",
        creates => "${docroot}/index.php",
        require => Exec["download roundcube archive for ${name}"];

      "remove installer folder after extraction for ${name}":
        command => 'rm -Rf installer',
        path    => ['/bin', '/usr/bin'],
        cwd     => $docroot,
        onlyif  => "test -f ${docroot}/installer",
        require => Exec["extract roundcube archive for ${name}"];
    }
    if !defined(Package['php5-mysql']) {
      package { 'php5-mysql':
        ensure => 'installed';
      }
    }
  }
}

