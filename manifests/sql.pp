class dovecot::sql {
  file{'/etc/dovecot-sql.conf':
    source => [ "puppet:///modules/site_dovecot/sql/${::fqdn}/dovecot-sql.conf",
                "puppet:///modules/site_dovecot/sql/${dovecot::type}/dovecot-sql.conf",
                "puppet:///modules/site_dovecot/sql/dovecot-sql.conf",
                "puppet:///modules/site/sql/${::operatingsystem}/dovecot-sql.conf",
                "puppet:///modules/site/sql/dovecot-sql.conf" ],
    require => Package['dovecot'],
    notify => Service['dovecot'],
    owner => root, group => 0, mode => 0600;
  }

  if $dovecot::mysql {
    include ::dovecot::sql::mysql
  }
  if $dovecot::pgsql {
    include ::dovecot::sql::pgsql
  }
  if $dovecot::sqlite {
    include ::dovecot::sql::sqlite
  }
}
