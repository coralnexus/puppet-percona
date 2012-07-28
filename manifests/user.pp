
define percona::user (

  $user_name     = $name,
  $ensure        = 'present',
  $password      = $percona::params::user_password,
  $database      = $percona::params::user_database,
  $host          = $percona::params::user_host,
  $port          = $percona::params::port,
  $permissions   = $percona::params::user_permissions,
  $grant         = $percona::params::user_grant,
  $defaults_file = $percona::params::os_defaults_file,

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

      $message = "MySQL: Grant ${user_name}@${host}:${database} ${grant_option}"

      if ! defined(Exec[$message]) {
        exec { $message:
          command => "mysql --defaults-file=${defaults_file} --port=${port} --execute=\"GRANT ${permissions} ON ${database}.* TO '${user_name}'@'${host}' IDENTIFIED BY '${password}' ${grant_option}\";",
          unless  => "mysql --user=${user_name} --password=${password} --database=${database} --port=${port}",
        }
      }
    }

    'absent': {
      exec { "MySQL: drop user ${user_name}":
        command => "mysql --defaults-file=${defaults_file} --port=${port} --execute=\"DROP USER ${user_name}\";",
        onlyif  => "mysql --user=${user_name} --password=${password} --port=${port}",
      }
    }
  }
}
