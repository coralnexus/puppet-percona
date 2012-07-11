# Class: percona::install
#
#
class percona::install (

  $server            = $percona::server,
  $percona_version   = $percona::params::percona_version,
  $pkg_common_ensure = $percona::params::pkg_common_ensure,
  $pkg_client_ensure = $percona::params::pkg_client_ensure,
  $pkg_server_ensure = $percona::params::pkg_server_ensure,

) inherits percona::params {

  #-----------------------------------------------------------------------------

  Package {
    require => Class['percona::preinstall'],
  }

  package { $percona::params::pkg_common:
    ensure => $pkg_common_ensure,
  }

  package { $percona::params::pkg_client:
    ensure  => $pkg_client_ensure,
    require => Package[$percona::params::pkg_common],
  }

  if $server {
    package { $percona::params::pkg_server:
      ensure  => $pkg_server_ensure,
      require => Package[$percona::params::pkg_client],
    }
  }
}
