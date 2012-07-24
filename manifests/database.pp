
define percona::database (

  $database      = $name,
  $ensure        = 'present',
  $port          = $percona::params::port,
  $sql_dump_file = $percona::params::database_sql_dump_file,
  $defaults_file = $percona::params::os_defaults_file,

) {

  include percona

  #-----------------------------------------------------------------------------

  Exec {
    path    => [ '/bin', '/usr/bin' ],
    require => Service['mysql'],
  }

  case $ensure {
    present: {
      exec { "MySQL create $database db":
        command => "mysql --defaults-file=${defaults_file} --port=${port} --execute=\"CREATE DATABASE ${database}\";",
        unless  => "mysql --defaults-file=${defaults_file} --port=${port} --execute=\"SHOW DATABASES;\" | grep -x '${database}'",
      }
    }

    importdb: {
      if $sql_dump_file {
        exec { "MySQL import $database db":
          command => "mysql --defaults-file=${defaults_file} --port=${port} --execute=\"CREATE DATABASE ${database}\";
                mysql --defaults-file=${defaults_file} ${database} --port=${port} < ${sql_dump_file}",
        }
      }
    }

    absent: {
      exec { "MySQL drop $database db":
        command => "mysql --defaults-file=${defaults_file} --port=${port} --execute=\"DROP DATABASE ${database}\";",
        onlyif  => "mysql --defaults-file=${defaults_file} --port=${port} --execute=\"SHOW DATABASES;\" | grep -x '${database}'",
      }
    }
  }
}
