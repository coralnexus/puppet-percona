
class percona::preinstall (

  $apt_key               = $percona::params::apt_key,
  $sources_list_template = $percona::params::sources_list_template,

) inherits percona::params {

  #-----------------------------------------------------------------------------

  case $::operatingsystem {
    debian, ubuntu: {
      include apt

      apt::key { $apt_key:
        ensure => present,
        notify => Exec['percona_apt_get_update'],
      }

      apt::sources_list { 'percona':
        ensure  => present,
        source  => false,
        content => template($sources_list_template),
        notify  => Exec['percona_apt_get_update'];
      }

      exec { 'percona_apt_get_update':
        path        => [ '/bin', '/usr/bin' ],
        command     => 'apt-get update',
        refreshonly => true;
      }
    }
  }
}
