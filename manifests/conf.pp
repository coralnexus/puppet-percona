
define percona::conf (

  $configurations = {},
  $ensure         = 'present',
  $user           = $percona::params::user,
  $group          = $percona::params::group,
  $conf_dir       = $percona::params::conf_dir,
  $template       = $percona::params::generic_template

) {

  include percona

  #-----------------------------------------------------------------------------

  file { "${conf_dir}/${name}.cnf":
    ensure  => $ensure,
    owner   => $user,
    group   => $group,
    mode    => 0640,
    content => template($template),
    require => File['percona_config'],
    notify  => Service['mysql'],
  }
}
