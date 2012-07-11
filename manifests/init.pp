# Class: percona
#
# This class installs percona
#
# Parameters:
#
#    $server            = false,
#    $server_id         = $percona::params::server_id,
#    $server_ip         = $percona::params::server_ip,
#    $origin_ip         = $percona::params::origin_ip,
#    $port              = $percona::params::port,
#    $mysqlchk_port     = $percona::params::mysqlchk_port,
#    $allow_remote      = $percona::params::allow_remote,
#    $percona_version   = $percona::params::percona_version,
#    $pkg_common_ensure = $percona::params::pkg_common_ensure,
#    $pkg_client_ensure = $percona::params::pkg_client_ensure,
#    $pkg_server_ensure = $percona::params::pkg_server_ensure,
#
# Actions:
#   - Install Percona XtraDB Cluster
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

  $server            = false,
  $server_id         = $percona::params::server_id,
  $server_ip         = $percona::params::server_ip,
  $origin_ip         = $percona::params::origin_ip,
  $port              = $percona::params::port,
  $mysqlchk_port     = $percona::params::mysqlchk_port,
  $allow_remote      = $percona::params::allow_remote,
  $percona_version   = $percona::params::percona_version,
  $pkg_common_ensure = $percona::params::pkg_common_ensure,
  $pkg_client_ensure = $percona::params::pkg_client_ensure,
  $pkg_server_ensure = $percona::params::pkg_server_ensure,

) inherits percona::params {

  #-----------------------------------------------------------------------------

  if $port {
    class { 'percona::firewall':
      port          => $port,
      mysqlchk_port => $mysqlchk_port,
    }
  }

  include percona::preinstall

  class { 'percona::install':
    server            => $server,
    percona_version   => $percona_version,
    pkg_common_ensure => $pkg_common_ensure,
    pkg_client_ensure => $pkg_client_ensure,
    pkg_server_ensure => $pkg_server_ensure,
  }

  if $server {
    class { 'percona::config':
      server_id     => $server_id,
      server_ip     => $server_ip,
      origin_ip     => $origin_ip,
      port          => $port,
      mysqlchk_port => $mysqlchk_port,
    }

    include percona::service

    #---

    percona::user { $percona::params::cluster_check_user:
      password    => $percona::params::cluster_check_pw,
      ensure      => 'present',
      host        => 'localhost',
      port        => $port,
      database    => '*',
      permissions => 'PROCESS',
      grant       => false,
    }

    #---

    Class['percona::install']
    -> Class['percona::config']
    -> Percona::User[$percona::params::cluster_check_user]
    -> Class['percona::service']
  }

  #-----------------------------------------------------------------------------

  Class['percona::preinstall'] -> Class['percona::install']
}
