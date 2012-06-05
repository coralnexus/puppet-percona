
class percona::config (

  $client = $percona::params::client,
  $server = $percona::params::server,
  $port   = $percona::params::port,

) inherits percona::params {

  #-----------------------------------------------------------------------------

  class { 'percona::config::server':
    server => $server,
    port   => $port,
  }

  class { 'percona::config::client':
    client => $client,
  }

  #-----------------------------------------------------------------------------

  Class['percona::config::server'] ->
  Class['percona::config::client']
}
