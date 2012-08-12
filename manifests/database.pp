
define percona::database (

  $database      = $name,
  $ensure        = 'present',
  $host          = $percona::params::user_host,
  $port          = $percona::params::port,
  $sql_dump_file = $percona::params::database_sql_dump_file,
  $user_name     = $percona::params::user_name,
  $password      = $percona::params::user_password,
  $permissions   = $percona::params::user_permissions,
  $grant         = $percona::params::user_grant,
  $remote        = $percona::params::allow_remote,
  $defaults_file = $percona::params::os_defaults_file,

) {

  include percona

  #-----------------------------------------------------------------------------
  # Database management

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

  #-----------------------------------------------------------------------------
  # Database users

  if $user_name {
    Percona::User {
      ensure        => present,
      host          => $host,
      port          => $port,
      user_name     => $user_name,
      password      => $password,
      database      => $database,
      permissions   => $permissions,
      grant         => $grant,
      defaults_file => $defaults_file,
    }

    percona::user { "${user_name}-${database}-local":
      host => 'localhost',
    }

    if $remote == 'true' {
      percona::user { "${user_name}-${database}-remote":
        host => '%',
      }
    }
  }
}
