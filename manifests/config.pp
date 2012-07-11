
class percona::config (

  $server_id     = $percona::params::server_id,
  $server_ip     = $percona::params::server_ip,
  $origin_ip     = $percona::params::origin_ip,
  $port          = $percona::params::port,
  $mysqlchk_port = $percona::params::mysqlchk_port,

) inherits percona::params {

  #-----------------------------------------------------------------------------

  File {
    owner   => $percona::params::user,
    group   => $percona::params::group,
    notify  => Service[$percona::params::service],
    require => Class['percona::install'],
  }

  file { $percona::params::confdir:
    ensure => 'directory',
  }

  file { $percona::params::config:
    ensure  => 'present',
    content => template("percona/my.cnf.erb"),
    require => File[$percona::params::confdir],
  }

  if defined(Class['xinetd']) {
    xinetd::service { 'mysqlchk':
      server         => $percona::params::mysqlchk_daemon,
      port           => $mysqlchk_port,
      disable        => 'no',
      flags          => 'REUSE',
      socket_type    => 'stream',
      wait           => 'no',
      user           => 'nobody',
      log_on_failure => 'USERID',
      per_source     => 'UNLIMITED',
    }
  }

  file { $percona::params::datadir:
    ensure => 'directory',
    mode   => '0700';
  }
}
