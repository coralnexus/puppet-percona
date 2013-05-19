
define percona::query (

  $query         = $name,
  $host          = undef,
  $port          = $percona::params::port,
  $access        = '',
  $condition     = undef,
  $user_name     = undef,
  $password      = undef,
  $database      = $percona::params::user_database,
  $defaults_file = $percona::params::user_config,
  $exec_user     = undef,
  $exec_passwd   = undef

) {

  include percona

  #-----------------------------------------------------------------------------

  Exec {
    require => Service['mysql'],
  }

  #---

  $defaults_file_option = $defaults_file ? {
    undef   => '',
    default => "--defaults-file=${defaults_file}",
  }

  if $exec_user {
    $auth_user = "--user=${exec_user}"

    if $exec_passwd {
      $auth_passwd = " --password=${exec_passwd}"
    }
    else {
      $auth_passwd = ''
    }

    $auth_option = "${auth_user}${auth_passwd}"
  }
  else {
    $auth_option = ''
  }

  $host_option = $host ? {
    undef   => '',
    '%'     => '',
    default => "--host=${host}",
  }

  $database_option = $database ? {
    undef   => '',
    '*'     => '',
    default => "--database=${database}",
  }

  #---

  $message = "MySQL: Query - ${query}"

  if ! defined(Exec[$message]) {

    if $condition {
      $test_query = "test \"`mysql ${defaults_file_option} ${auth_option} ${database_option} ${host_option} --port=${port} --execute=\"${condition}\"`\" != ''"
    }
    else {
      $test_query = "mysql --user=${user_name} --password=${password} ${database_option} ${host_option} --port=${port}"
    }

    case $access {
      'onlyif': {
        exec { $message:
          command => "mysql ${defaults_file_option} ${auth_option} ${database_option} ${host_option} --port=${port} --execute=\"${query}\"",
          onlyif  => $test_query,
        }
      }
      'unless': {
        exec { $message:
          command => "mysql ${defaults_file_option} ${auth_option} ${database_option} ${host_option} --port=${port} --execute=\"${query}\"",
          unless  => $test_query,
        }
      }
      default: {
        exec { $message:
          command => "mysql ${defaults_file_option} ${auth_option} ${database_option} ${host_option} --port=${port} --execute=\"${query}\"",
        }
      }
    }
  }
}
