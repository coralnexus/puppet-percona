
class percona::config::client (

  $client = $percona::params::client,

) inherits percona::params {

  #-----------------------------------------------------------------------------

  if $client {
    File {
      owner   => $percona::params::user,
      group   => $percona::params::group,
      notify  => Service[$percona::params::service],
      require => Class['percona::install'],
    }
  }
}
