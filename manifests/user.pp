
define percona::user (

  $user_name = $name,
  $password  = '',
  $database  = '*',
  $ensure    = 'present',
  $host      = 'localhost',
  $grant     = true,

) {

  Exec {
    path    => [ '/bin', '/usr/bin' ],
    require => Class['percona::service'],
  }

  case $ensure {
    'present': {

      $grant_option = $grant ? {
        true    => 'WITH GRANT OPTION',
        default => '',
      }

      $message = "MySQL: Grant ${user_name}@${host}:${database} $grant_option"

      if ! defined(Exec[$message]) {
        exec { $message:
          command => "mysql --defaults-file=/etc/mysql/debian.cnf --execute=\"GRANT ALL ON ${database}.* TO '${user_name}'@'${host}' IDENTIFIED BY '${password}' ${grant_option}\";",
          unless  => "mysql --user=${user_name} --password=${password} --database=${database} --host=${host}",
        }
      }
    }

    'absent': {
      exec { "MySQL: create user ${user_name}":
        command => "mysql --defaults-file=/etc/mysql/debian.cnf --execute=\"DROP USER ${user_name}\";",
        onlyif  => "mysql --user=${user_name} --password=${password}",
      }
    }
  }
}
