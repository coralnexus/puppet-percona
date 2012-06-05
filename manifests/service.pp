# Class: percona::service
#
#
class percona::service (

  $server = $percona::params::server,

) inherits percona::params {

  #-----------------------------------------------------------------------------

  Service {
    require => Class['percona::config'],
    enable  => true,
  }

  if $server {
    service {
      $percona::params::service:
        ensure => running,
        enable => true,
    }
  }
}
