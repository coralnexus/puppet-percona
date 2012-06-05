
class percona::config::server (

  $server = $percona::params::server,
  $port   = $percona::params::port,

) inherits percona::params {

  #-----------------------------------------------------------------------------

  if $server {
    File {
      owner   => $percona::params::user,
      group   => $percona::params::group,
      notify  => Service[$percona::params::service],
      require => Class['percona::install'],
    }

    if $percona::params::confdir {
      file { $percona::params::confdir:
        ensure => directory;
      }
    }

    file {
      $percona::params::config:
        ensure  => present,
        content => template("percona/my.cnf.erb");

      $percona::params::datadir:
        ensure => directory,
        mode   => '0700';
    }
  }
}
