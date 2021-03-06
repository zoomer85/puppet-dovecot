# records expire's in an sqlite
# database
class dovecot::expire::sqlite {
  include ::sqlite
  file{
    '/var/lib/dovecot/expire.db':
      ensure  => file,
      replace => false,
      require => Package['sqlite'],
      owner   => root,
      group   => 0,
      mode    => '0600';
    '/var/lib/dovecot/expire.sql':
      source  => 'puppet:///modules/dovecot/expire/expire.sqlite.sql',
      require => File['/var/lib/dovecot/expire.db'],
      notify  => Exec['create_expire_db'],
      owner   => root,
      group   => 0,
      mode    => '0600';
  }

  exec{'create_expire_db':
    command     => 'cat /var/lib/dovecot/expire.sql | sqlite3 /var/lib/dovecot/expire.db',
    refreshonly => true,
  }
}
