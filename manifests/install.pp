# Class: percona::install
#
#
class percona::install (

  $client          = $percona::client,
  $server          = $percona::server,
  $percona_version = $percona::params::percona_version,
  $pkg_common      = $percona::params::pkg_common,
  $pkg_client      = $percona::params::pkg_client,
  $pkg_server      = $percona::params::pkg_server,

) inherits percona::params {

  #-----------------------------------------------------------------------------

  Package {
    require => [
      Class['percona::preinstall'],
    ],
  }

  package {
    $pkg_common:
      ensure => 'present';
  }

  if $client {
    package {
      $pkg_client:
        ensure  => 'present',
        require => Package[$pkg_common];
    }
  }

  if $server {
    package {
      $pkg_server:
        ensure  => 'present',
        require => Package[$pkg_client];
    }
  }
}
