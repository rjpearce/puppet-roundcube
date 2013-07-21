puppet-roundcube
================

Roundcube Module for Puppet

Example usage:

  roundcube { 'webmail.example.com':
    docroot        => '/var/www/webmail.example.com',
    mysql_username => 'webmail',
    mysql_password => 'password',
    mysql_dbname   => 'webmail',
    imap_server    => 'ssl://imap.example.com',
    imap_port      => '993',
    version        => '0.91';
  }
