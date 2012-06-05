
class percona::firewall ( $port = $percona::params::port ) inherits percona::params {

  firewall { "400 INPUT Allow new MySQL connections":
    action => 'accept',
    chain  => 'INPUT',
    state  => 'NEW',
    proto  => 'tcp',
    dport  => $port,
  }
}
