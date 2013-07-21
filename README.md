puppet-roundcube
================

## Overview

Install and configure roundcube with optional apache/mysql configuration.

 * `roundcube` : Main define for the roundcube.

## Examples

Typical user with apache and mysql configuration :

    roundcube { 'webmail.example.com':
      docroot        => '/var/www/webmail.example.com',
      mysql_username => 'webmail',
      mysql_password => 'password',
      mysql_dbname   => 'webmail',
      imap_server    => 'ssl://imap.example.com',
      imap_port      => '993',
      version        => '0.91';
    }
