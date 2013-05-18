
define percona::conf (

  $configurations = {},
  $ensure         = 'present',
  $user_name      = $percona::params::user_name,
  $group          = $percona::params::group,
  $conf_dir       = $percona::params::conf_dir,
  $template       = $percona::params::generic_template

) {

  include percona

  #-----------------------------------------------------------------------------

  file { "${conf_dir}/${name}.cnf":
    ensure  => $ensure,
    owner   => $user_name,
    group   => $group,
    mode    => '0640',
    content => template($template),
    require => File['percona_config'],
    notify  => Service['mysql'],
  }
}
