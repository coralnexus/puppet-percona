
class percona::firewall (

  $port          = $percona::params::port,
  $mysqlchk_port = $percona::params::mysqlchk_port,

) inherits percona::params {

  #-----------------------------------------------------------------------------

  firewall { "400 INPUT Allow new MySQL connections":
    action => 'accept',
    chain  => 'INPUT',
    state  => 'NEW',
    proto  => 'tcp',
    dport  => $port,
  }

  if $mysqlchk_port {
    firewall { "401 INPUT Allow new MySQL status check connections":
      action => 'accept',
      chain  => 'INPUT',
      state  => 'NEW',
      proto  => 'tcp',
      dport  => $mysqlchk_port,
    }
  }
}
