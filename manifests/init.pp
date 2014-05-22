# Class: percona
#
# This class installs percona
#
# Parameters: (see <example/params.json> for Hiera configurations)
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
#      server  => true,
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

  $server                           = false,
  $apt_location                     = $percona::params::apt_location,
  $apt_repos                        = $percona::params::apt_repos,
  $apt_key                          = $percona::params::apt_key,
  $apt_key_server                   = $percona::params::apt_key_server,
  $version                          = $percona::params::version,
  $client_package                   = $percona::params::client_package,
  $client_ensure                    = $percona::params::client_ensure,
  $server_package                   = $percona::params::server_package,
  $server_ensure                    = $percona::params::server_ensure,
  $service                          = $percona::params::service,
  $service_ensure                   = $percona::params::service_ensure,
  $common_packages                  = $percona::params::common_packages,
  $common_ensure                    = $percona::params::common_ensure,
  $config                           = $percona::params::config,
  $config_template                  = $percona::params::config_template,
  $config_dir                       = $percona::params::config_dir,
  $conf_dir                         = $percona::params::conf_dir,
  $configurations                   = $percona::params::configurations,
  $log_dir                          = $percona::params::log_dir,
  $error_log                        = $percona::params::error_log,
  $lib_dir                          = $percona::params::lib_dir,
  $socket                           = $percona::params::socket,
  $data_dir                         = $percona::params::data_dir,
  $pid_file                         = $percona::params::pid_file,
  $mysqlchk_daemon                  = $percona::params::mysqlchk_daemon,
  $cluster_check_user               = $percona::params::cluster_check_user,
  $cluster_check_password           = $percona::params::cluster_check_password,
  $server_id                        = $percona::params::server_id,
  $server_ip                        = $percona::params::server_ip,
  $origin_addresses                 = $percona::params::origin_addresses,
  $cluster_name                     = $percona::params::cluster_name,
  $allow_remote                     = $percona::params::allow_remote,
  $configure_firewall               = $percona::params::configure_firewall,
  $percona_ports                    = $percona::params::percona_ports,
  $port                             = $percona::params::port,
  $mysqlchk_user                    = $percona::params::mysqlchk_user,
  $mysqlchk_port                    = $percona::params::mysqlchk_port,
  $user_name                        = $percona::params::user_name,
  $group                            = $percona::params::group,
  $log_bin                          = $percona::params::log_bin,
  $binlog_format                    = $percona::params::binlog_format,
  $wsrep_provider                   = $percona::params::wsrep_provider,
  $wsrep_sst_method                 = $percona::params::wsrep_sst_method,
  $wsrep_slave_threads              = $percona::params::wsrep_slave_threads,
  $wsrep_certify_non_pk             = $percona::params::wsrep_certify_non_pk,
  $wsrep_max_ws_rows                = $percona::params::wsrep_max_ws_rows,
  $wsrep_max_ws_size                = $percona::params::wsrep_max_ws_size,
  $wsrep_debug                      = $percona::params::wsrep_debug,
  $wsrep_convert_lock_to_trx        = $percona::params::wsrep_convert_lock_to_trx,
  $wsrep_retry_autocommit           = $percona::params::wsrep_retry_autocommit,
  $wsrep_auto_increment_control     = $percona::params::wsrep_auto_increment_control,
  $wsrep_causal_reads               = $percona::params::wsrep_causal_reads,
  $wsrep_notify_cmd                 = $percona::params::wsrep_notify_cmd,
  $default_storage_engine           = $percona::params::default_storage_engine,
  $innodb_data_home_dir             = $percona::params::innodb_data_home_dir,
  $innodb_log_group_home_dir        = $percona::params::innodb_log_group_home_dir,
  $innodb_flush_log_at_trx_commit   = $percona::params::innodb_flush_log_at_trx_commit,
  $innodb_autoinc_lock_mode         = $percona::params::innodb_autoinc_lock_mode,
  $innodb_locks_unsafe_for_binlog   = $percona::params::innodb_locks_unsafe_for_binlog,
  $root_user                        = $percona::params::root_user,
  $root_password                    = $percona::params::root_password,
  $mysql_user                       = $percona::params::mysql_user,
  $mysql_password                   = $percona::params::mysql_password

) inherits percona::params {

  #-----------------------------------------------------------------------------
  # Installation

  case $::operatingsystem {
    debian, ubuntu: {
      apt::source { 'percona':
        location   => $apt_location,
        repos      => $apt_repos,
        key        => $apt_key,
        key_server => $apt_key_server
      }
      Apt::Source['percona'] -> Package['percona_client']
    }
  }

  #---

  package { 'percona_client':
    name    => $client_package,
    ensure  => $client_ensure
  }

  if $server {
    package { 'percona_server':
      name    => $server_package,
      ensure  => $server_ensure,
      require => [ Package['percona_client'], File['percona_config'] ],
    }
  }

  package { $common_packages:
    ensure  => $common_ensure,
    require => Package['percona_client'],
  }

  #-----------------------------------------------------------------------------
  # Configuration

  if $server and $configure_firewall {
    if $port {
      firewall { "400 INPUT Allow new MySQL connections":
        action => 'accept',
        chain  => 'INPUT',
        state  => 'NEW',
        proto  => 'tcp',
        dport  => $port,
      }
    }

    if ! empty($percona_ports) {
      percona::rule { $percona_ports: }
    }
  }

  #---

  if $server {
    group { $group:
      ensure => present,
      system => true,
    }

    File {
      group   => $group,
      require => Group['mysql'],
      notify  => Service['mysql'],
    }

    file { 'percona_config_dir':
      path   => $config_dir,
      ensure => directory,
      mode   => '0770',
    }

    file { 'percona_conf_dir':
      path    => $conf_dir,
      ensure  => directory,
      mode    => '0770',
      require => File['percona_config_dir'],
    }

    file { 'percona_data_dir':
      path   => $data_dir,
      ensure => directory,
      mode   => '0700',
    }

    file { 'percona_config':
      path    => $config,
      content => template($config_template),
      require => File['percona_config_dir'],
    }
  }

  #---

  if ! $origin_addresses {
    percona::query { 'update-root-password':
      query         => "UPDATE user SET Password = PASSWORD('${root_password}') WHERE User = '${root_user}'; FLUSH PRIVILEGES",
      access        => 'onlyif',
      condition     => "SELECT * FROM user WHERE User = '${root_user}' AND Password != PASSWORD('${root_password}')",
      port          => $port,
      database      => 'mysql',
      hide_query    => true
    }

    percona::user { $mysql_user:
      password      => $mysql_password,
      ensure        => 'present',
      host          => 'localhost',
      port          => $port,
      database      => '*',
      permissions   => 'ALL',
      grant         => false,
      defaults_file => undef,
      root_user     => $root_user,
      root_password => $root_password,
      require       => Percona::Query['update-root-password'],
    }
  }

  #---

  if $server and defined(Class['xinetd']) {
    if ! $origin_addresses {
      percona::user { $cluster_check_user:
        password    => $cluster_check_password,
        ensure      => 'present',
        host        => 'localhost',
        port        => $port,
        database    => '*',
        permissions => 'PROCESS',
        grant       => false
      }
      Percona::User[$cluster_check_user] -> Xinetd::Service['mysqlchk']
    }

    xinetd::service { 'mysqlchk':
      service    => 'mysqlchk',
      attributes => {
        server         => $mysqlchk_daemon,
        port           => $mysqlchk_port,
        disable        => 'no',
        flags          => 'REUSE',
        socket_type    => 'stream',
        wait           => 'no',
        user           => $mysqlchk_user,
        log_on_failure => '+= USERID',
        per_source     => 'UNLIMITED'
      }
    }
  }

  #-----------------------------------------------------------------------------
  # Services

  if $server {
    service { 'mysql':
      name    => $service,
      ensure  => $service_ensure,
      enable  => true,
      require => Package['percona_server'],
    }
  }
}

#-------------------------------------------------------------------------------

define percona::rule( $port = $name ) {

  $rule_description = "200 INPUT Allow Percona Cluster connections: $port"

  #-----------------------------------------------------------------------------

  if $port and ! defined(Firewall[$rule_description]) {
    firewall { $rule_description:
      action => accept,
      chain  => 'INPUT',
      state  => 'NEW',
      proto  => 'tcp',
      dport  => $port,
    }
  }
}
