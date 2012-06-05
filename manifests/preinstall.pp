
class percona::preinstall (

  $client = $percona::params::client,
  $server = $percona::params::server,

) inherits percona::params {

  include apt

  #-----------------------------------------------------------------------------

  if $client {

  }

  #-----------------------------------------------------------------------------

  if $server {

  }

  #-----------------------------------------------------------------------------

  case $::operatingsystem {
    'debian', 'Debian', 'ubuntu', 'Ubuntu': {
      apt::key { 'CD2EFD2A':
        ensure => present,
        notify => Exec['apt-get update'],
      }

      apt::sources_list { 'percona':
        ensure  => present,
        source  => false,
        content => template ('percona/sources.list.erb'),
        notify  => Exec['apt-get update'];
      }

      exec { 'apt-get update':
        path        => [ '/bin', '/usr/bin' ],
        command     => 'apt-get update',
        refreshonly => true;
      }
    }

    default: {
      fail 'Operating system not supported yet.'
    }
  }
}
