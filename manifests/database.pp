
define percona::database (

  $ensure,
  $dump = undef

) {

  Exec {
    path    => [ '/bin', '/usr/bin' ],
    require => Class['percona::service'],
  }

  case $ensure {
    present: {
      exec { "MySQL create $name db":
        command => "mysql --defaults-file=/etc/mysql/debian.cnf --execute=\"CREATE DATABASE ${name}\";",
        unless  => "mysql --defaults-file=/etc/mysql/debian.cnf --execute=\"SHOW DATABASES;\" | grep -x '${name}'",
      }
    }

    importdb: {
      exec { "MySQL import $name db":
        command => "mysql --defaults-file=/etc/mysql/debian.cnf --execute=\"CREATE DATABASE ${name}\";
              mysql --defaults-file=/etc/mysql/debian.cnf ${name} < ${dump}",
      }
    }

    absent: {
      exec { "MySQL drop $name db":
        command => "mysql --defaults-file=/etc/mysql/debian.cnf --execute=\"DROP DATABASE ${name}\";",
        onlyif  => "mysql --defaults-file=/etc/mysql/debian.cnf --execute=\"SHOW DATABASES;\" | grep -x '${name}'",
      }
    }

    default: {
      fail "Invalid 'ensure' value '$ensure' for mysql::database"
    }
  }
}
