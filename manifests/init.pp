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
  $apt_key                          = $percona::params::apt_key,
  $sources_list_template            = $percona::params::sources_list_template,
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
  $conf_dir                         = $percona::params::conf_dir,
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
  $origin_ip                        = $percona::params::origin_ip,
  $cluster_name                     = $percona::params::cluster_name,
  $allow_remote                     = $percona::params::allow_remote,
  $configure_firewall               = $percona::params::configure_firewall,
  $port                             = $percona::params::port,
  $mysqlchk_port                    = $percona::params::mysqlchk_port,
  $user                             = $percona::params::user,
  $group                            = $percona::params::group,
  $skip_external_locking            = $percona::params::skip_external_locking,
  $key_buffer_size                  = $percona::params::key_buffer_size,
  $max_allowed_packet               = $percona::params::max_allowed_packet,
  $table_open_cache                 = $percona::params::table_open_cache,
  $sort_buffer_size                 = $percona::params::sort_buffer_size,
  $read_buffer_size                 = $percona::params::read_buffer_size,
  $read_rnd_buffer_size             = $percona::params::read_rnd_buffer_size,
  $myisam_sort_buffer_size          = $percona::params::myisam_sort_buffer_size,
  $thread_cache_size                = $percona::params::thread_cache_size,
  $query_cache_size                 = $percona::params::query_cache_size,
  $thread_concurrency               = $percona::params::thread_concurrency,
  $skip_networking                  = $percona::params::skip_networking,
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
  $log_slave_updates                = $percona::params::log_slave_updates,
  $default_storage_engine           = $percona::params::default_storage_engine,
  $innodb_data_home_dir             = $percona::params::innodb_data_home_dir,
  $innodb_log_group_home_dir        = $percona::params::innodb_log_group_home_dir,
  $innodb_buffer_pool_size          = $percona::params::innodb_buffer_pool_size,
  $innodb_additional_mem_pool_size  = $percona::params::innodb_additional_mem_pool_size,
  $innodb_log_buffer_size           = $percona::params::innodb_log_buffer_size,
  $innodb_flush_log_at_trx_commit   = $percona::params::innodb_flush_log_at_trx_commit,
  $innodb_lock_wait_timeout         = $percona::params::innodb_lock_wait_timeout,
  $innodb_autoinc_lock_mode         = $percona::params::innodb_autoinc_lock_mode,
  $innodb_locks_unsafe_for_binlog   = $percona::params::innodb_locks_unsafe_for_binlog,
  $mysql_no_auto_rehash             = $percona::params::mysql_no_auto_rehash,
  $mysql_safe_updates               = $percona::params::mysql_safe_updates,
  $mysqldump_quick                  = $percona::params::mysqldump_quick,
  $mysqldump_max_allowed_packet     = $percona::params::mysqldump_max_allowed_packet,
  $myisamchk_key_buffer_size        = $percona::params::myisamchk_key_buffer_size,
  $myisamchk_sort_buffer_size       = $percona::params::myisamchk_sort_buffer_size,
  $myisamchk_read_buffer            = $percona::params::myisamchk_read_buffer,
  $myisamchk_write_buffer           = $percona::params::myisamchk_write_buffer,
  $mysqlhotcopy_interactive_timeout = $percona::params::mysqlhotcopy_interactive_timeout,

) inherits percona::params {

  #-----------------------------------------------------------------------------
  # Installation

  class { 'percona::preinstall':
    apt_key               => $apt_key,
    sources_list_template => $sources_list_template,
  }

  #---

  package { 'percona_client':
    name    => $client_package,
    ensure  => $client_ensure,
    require => Class['percona::preinstall'],
  }

  if $server {
    package { 'percona_server':
      name    => $server_package,
      ensure  => $server_ensure,
      require => Package['percona_client'],
    }
  }

  package { 'percona_common':
    name    => $common_packages,
    ensure  => $common_ensure,
    require => Package['percona_client'],
  }

  #-----------------------------------------------------------------------------
  # Configuration

  if $server and $configure_firewall == 'true' {
    if $port {
      firewall { "400 INPUT Allow new MySQL connections":
        action => 'accept',
        chain  => 'INPUT',
        state  => 'NEW',
        proto  => 'tcp',
        dport  => $port,
      }
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

  #---

  File {
    owner   => $user,
    group   => $group,
    require => Package['percona_server'],
    notify  => Service['mysql'],
  }

  file { 'percona_conf_dir':
    path   => $conf_dir,
    ensure => directory,
  }

  file { 'percona_data_dir':
    path   => $data_dir,
    ensure => directory,
    mode   => '0700';
  }

  file { 'percona_config':
    path    => $config,
    content => template($config_template),
    require => File['percona_conf_dir'],
  }

  #---

  if $server and defined(Class['xinetd']) {
    percona::user { $cluster_check_user:
      password    => $cluster_check_password,
      ensure      => 'present',
      host        => 'localhost',
      port        => $port,
      database    => '*',
      permissions => 'PROCESS',
      grant       => false,
    }

    xinetd::service { 'mysqlchk':
      server         => $mysqlchk_daemon,
      port           => $mysqlchk_port,
      disable        => 'no',
      flags          => 'REUSE',
      socket_type    => 'stream',
      wait           => 'no',
      user           => 'nobody',
      log_on_failure => 'USERID',
      per_source     => 'UNLIMITED',
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
