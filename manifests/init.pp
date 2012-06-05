# Class: percona
#
# This class installs percona
#
# Parameters:
#
#  $client          = $percona::params::client,
#  $server          = $percona::params::server,
#  $percona_version = $percona::params::percona_version,
#  $pkg_common      = $percona::params::pkg_common,
#  $pkg_client      = $percona::params::pkg_client,
#  $pkg_server      = $percona::params::pkg_common,
#
# Actions:
#   - Install PerconaDB
#   - Install PerconaXtraDB
#
# Requires:
#   - camp2camp puppet-apt module:
#     source: https://github.com/camptocamp/puppet-apt
#
# Sample Usage:
#
#  node server {
#    class { 'percona':
#      server          => 'true',
#      percona_version => '5.5';
#    }
#
#  node client {
#    include percona'
#  }
#
# Valid options:
#
# Known issues:
#
class percona (

  $client          = $percona::params::client,
  $server          = $percona::params::server,
  $port            = $percona::params::port,
  $percona_version = $percona::params::percona_version,
  $pkg_common      = $percona::params::pkg_common,
  $pkg_client      = $percona::params::pkg_client,
  $pkg_server      = $percona::params::pkg_server,

) inherits percona::params {

  #-----------------------------------------------------------------------------

  class { 'percona::firewall': port => $port }

  class { 'percona::preinstall':
    client => $client,
    server => $server,
  }

  class { 'percona::install':
    client          => $client,
    server          => $server,
    percona_version => $percona_version,
    pkg_common      => $pkg_common,
    pkg_client      => $pkg_client,
    pkg_server      => $pkg_server,
  }

  class { 'percona::config':

  }

  class { 'percona::service':

  }

  #-----------------------------------------------------------------------------

  Class['percona::preinstall'] ->
  Class['percona::install'] ->
  Class['percona::config'] ->
  Class['percona::service']
}
