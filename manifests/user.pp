
define percona::user (

  $user_name     = $name,
  $ensure        = 'present',
  $password      = $percona::params::user_password,
  $database      = $percona::params::user_database,
  $host          = $percona::params::user_host,
  $port          = $percona::params::port,
  $permissions   = $percona::params::user_permissions,
  $grant         = $percona::params::user_grant,
  $defaults_file = $percona::params::user_config,
  $root_user     = $percona::params::root_user,
  $root_password = $percona::params::root_password

) {

  include percona

  #-----------------------------------------------------------------------------

  Exec {
    path    => [ '/bin', '/usr/bin' ],
    require => Service['mysql'],
  }

  case $ensure {
    'present': {

      $grant_option = $grant ? {
        'true'  => 'WITH GRANT OPTION',
        default => '',
      }

      if $database == '*' {
        percona::query { "ensure-${user_name}-${host}-privileges":
          query         => "GRANT ${permissions} ON *.* TO '${user_name}'@'${host}' IDENTIFIED BY '${password}' ${grant_option}; FLUSH PRIVILEGES",
          port          => $port,
          access        => 'unless',
          condition     => "SELECT * FROM user WHERE User = '${user_name}' AND Host = '${host}'",
          database      => 'mysql',
          defaults_file => $defaults_file,
          exec_user     => $root_user,
          exec_passwd   => $root_password,
          require       => Percona::Query['update-root-password'],
        }
      }
      else {
        percona::query { "ensure-${user_name}-${host}-privileges":
          query         => "GRANT ${permissions} ON ${database}.* TO '${user_name}'@'${host}' IDENTIFIED BY '${password}' ${grant_option}; FLUSH PRIVILEGES",
          port          => $port,
          access        => 'unless',
          condition     => "SELECT * FROM db WHERE Db = '${database}' AND User = '${user_name}' AND Host = '${host}'",
          database      => 'mysql',
          defaults_file => $defaults_file,
          exec_user     => $root_user,
          exec_passwd   => $root_password,
          require       => Percona::Query['update-root-password'],
        }
      }

      #---

      percona::query { "update-${user_name}-${host}-password":
        query         => "UPDATE user SET Password = PASSWORD('${password}') WHERE User = '${user_name}' AND Host = '${host}'; FLUSH PRIVILEGES",
        access        => 'unless',
        condition     => "SELECT * FROM user WHERE User = '${user_name}' AND Host = '${host}' AND Password = PASSWORD('${password}')",
        port          => $port,
        database      => 'mysql',
        defaults_file => $defaults_file,
        exec_user     => $root_user,
        exec_passwd   => $root_password,
        require       => Percona::Query["ensure-${user_name}-${host}-privileges"],
      }
    }

    'absent': {
      percona::query { "drop-${user_name}":
        query         => "DROP USER ${user_name}",
        port          => $port,
        access        => 'onlyif',
        user_name     => $user_name,
        password      => $password,
        database      => undef,
        defaults_file => $defaults_file,
        exec_user     => $root_user,
        exec_passwd   => $root_password,
        require       => Percona::Query['update-root-password'],
      }
    }
  }
}
