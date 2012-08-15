
define percona::conf (

  $content  = '',
  $ensure   = 'present',
  $user     = $percona::params::user,
  $group    = $percona::params::group,
  $conf_dir = $percona::params::conf_dir,

) {

  include percona

  #-----------------------------------------------------------------------------

  file { "${conf_dir}/${name}.cnf":
    ensure  => $ensure,
    owner   => $user,
    group   => $group,
    mode    => '0640',
    content => $content,
    require => File['percona_config'],
    notify  => Service['mysql'],
  }
}
