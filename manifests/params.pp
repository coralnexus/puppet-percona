
class percona::params {

  include percona::default

  #-----------------------------------------------------------------------------
  # General configurations

  if $::hiera_ready {
    $percona_version                  = hiera('percona_version', $percona::default::percona_version)
    $percona_client_ensure            = hiera('percona_client_ensure', $percona::default::percona_client_ensure)
    $percona_server_ensure            = hiera('percona_server_ensure', $percona::default::percona_server_ensure)
    $percona_common_ensure            = hiera('percona_common_ensure', $percona::default::percona_common_ensure)
    $percona_service_ensure           = hiera('percona_service_ensure', $percona::default::percona_service_ensure)
    $server_id                        = hiera('percona_server_id', $percona::default::server_id)
    $server_ip                        = hiera('percona_server_ip', $percona::default::server_ip)
    $origin_ip                        = hiera('percona_origin_ip', $percona::default::origin_ip)
    $allow_remote                     = hiera('percona_allow_remote', $percona::default::allow_remote)
    $configure_firewall               = hiera('percona_configure_firewall', $percona::default::configure_firewall)
    $port                             = hiera('percona_port', $percona::default::port)
    $mysqlchk_port                    = hiera('percona_mysqlchk_port', $percona::default::mysqlchk_port)
    $user                             = hiera('percona_user', $percona::default::user)
    $group                            = hiera('percona_group', $percona::default::group)
    $skip_external_locking            = hiera('percona_skip_external_locking', $percona::default::skip_external_locking)
    $key_buffer_size                  = hiera('percona_key_buffer_size', $percona::default::key_buffer_size)
    $max_allowed_packet               = hiera('percona_max_allowed_packet', $percona::default::max_allowed_packet)
    $table_open_cache                 = hiera('percona_table_open_cache', $percona::default::table_open_cache)
    $sort_buffer_size                 = hiera('percona_sort_buffer_size', $percona::default::sort_buffer_size)
    $read_buffer_size                 = hiera('percona_read_buffer_size', $percona::default::read_buffer_size)
    $read_rnd_buffer_size             = hiera('percona_read_rnd_buffer_size', $percona::default::read_rnd_buffer_size)
    $myisam_sort_buffer_size          = hiera('percona_myisam_sort_buffer_size', $percona::default::myisam_sort_buffer_size)
    $thread_cache_size                = hiera('percona_thread_cache_size', $percona::default::thread_cache_size)
    $query_cache_size                 = hiera('percona_query_cache_size', $percona::default::query_cache_size)
    $thread_concurrency               = hiera('percona_thread_concurrency', $percona::default::thread_concurrency)
    $skip_networking                  = hiera('percona_skip_networking', $percona::default::skip_networking)
    $wsrep_slave_threads              = hiera('percona_wsrep_slave_threads', $percona::default::wsrep_slave_threads)
    $wsrep_certify_non_pk             = hiera('percona_wsrep_certify_non_pk', $percona::default::wsrep_certify_non_pk)
    $wsrep_max_ws_rows                = hiera('percona_wsrep_max_ws_rows', $percona::default::wsrep_max_ws_rows)
    $wsrep_max_ws_size                = hiera('percona_wsrep_max_ws_size', $percona::default::wsrep_max_ws_size)
    $wsrep_debug                      = hiera('percona_wsrep_debug', $percona::default::wsrep_debug)
    $wsrep_convert_lock_to_trx        = hiera('percona_wsrep_convert_lock_to_trx', $percona::default::wsrep_convert_lock_to_trx)
    $wsrep_retry_autocommit           = hiera('percona_wsrep_retry_autocommit', $percona::default::wsrep_retry_autocommit)
    $wsrep_auto_increment_control     = hiera('percona_wsrep_auto_increment_control', $percona::default::wsrep_auto_increment_control)
    $wsrep_causal_reads               = hiera('percona_wsrep_causal_reads', $percona::default::wsrep_causal_reads)
    $wsrep_notify_cmd                 = hiera('percona_wsrep_notify_cmd', $percona::default::wsrep_notify_cmd)
    $log_slave_updates                = hiera('percona_log_slave_updates', $percona::default::log_slave_updates)
    $default_storage_engine           = hiera('percona_default_storage_engine', $percona::default::default_storage_engine)
    $innodb_buffer_pool_size          = hiera('percona_innodb_buffer_pool_size', $percona::default::innodb_buffer_pool_size)
    $innodb_additional_mem_pool_size  = hiera('percona_innodb_additional_mem_pool_size', $percona::default::innodb_additional_mem_pool_size)
    $innodb_log_file_size             = hiera('percona_innodb_log_file_size', $percona::default::innodb_log_file_size)
    $innodb_log_buffer_size           = hiera('percona_innodb_log_buffer_size', $percona::default::innodb_log_buffer_size)
    $innodb_flush_log_at_trx_commit   = hiera('percona_innodb_flush_log_at_trx_commit', $percona::default::innodb_flush_log_at_trx_commit)
    $innodb_lock_wait_timeout         = hiera('percona_innodb_lock_wait_timeout', $percona::default::innodb_lock_wait_timeout)
    $innodb_autoinc_lock_mode         = hiera('percona_innodb_autoinc_lock_mode', $percona::default::innodb_autoinc_lock_mode)
    $innodb_locks_unsafe_for_binlog   = hiera('percona_innodb_locks_unsafe_for_binlog', $percona::default::innodb_locks_unsafe_for_binlog)
    $mysql_no_auto_rehash             = hiera('percona_mysql_no_auto_rehash', $percona::default::mysql_no_auto_rehash)
    $mysql_safe_updates               = hiera('percona_mysql_safe_updates', $percona::default::mysql_safe_updates)
    $mysqldump_quick                  = hiera('percona_mysqldump_quick', $percona::default::mysqldump_quick)
    $mysqldump_max_allowed_packet     = hiera('percona_mysqldump_max_allowed_packet', $percona::default::mysqldump_max_allowed_packet)
    $myisamchk_key_buffer_size        = hiera('percona_myisamchk_key_buffer_size', $percona::default::myisamchk_key_buffer_size)
    $myisamchk_sort_buffer_size       = hiera('percona_myisamchk_sort_buffer_size', $percona::default::myisamchk_sort_buffer_size)
    $myisamchk_read_buffer            = hiera('percona_myisamchk_read_buffer', $percona::default::myisamchk_read_buffer)
    $myisamchk_write_buffer           = hiera('percona_myisamchk_write_buffer', $percona::default::myisamchk_write_buffer)
    $mysqlhotcopy_interactive_timeout = hiera('percona_mysqlhotcopy_interactive_timeout', $percona::default::mysqlhotcopy_interactive_timeout)
    $user_password                    = hiera('percona_user_password', $percona::default::user_password)
    $user_database                    = hiera('percona_user_database', $percona::default::user_database)
    $user_host                        = hiera('percona_user_host', $percona::default::user_host)
    $user_permissions                 = hiera('percona_user_permissions', $percona::default::user_permissions)
    $user_grant                       = hiera('percona_user_grant', $percona::default::user_grant)
    $database_sql_dump_file           = hiera('percona_database_sql_dump_file', $percona::default::database_sql_dump_file)
  }
  else {
    $percona_version                  = $percona::default::percona_version
    $percona_client_ensure            = $percona::default::percona_client_ensure
    $percona_server_ensure            = $percona::default::percona_server_ensure
    $percona_common_ensure            = $percona::default::percona_common_ensure
    $percona_service_ensure           = $percona::default::percona_service_ensure
    $server_id                        = $percona::default::server_id
    $server_ip                        = $percona::default::server_ip
    $origin_ip                        = $percona::default::origin_ip
    $allow_remote                     = $percona::default::allow_remote
    $configure_firewall               = $percona::default::configure_firewall
    $port                             = $percona::default::port
    $mysqlchk_port                    = $percona::default::mysqlchk_port
    $user                             = $percona::default::user
    $group                            = $percona::default::group
    $skip_external_locking            = $percona::default::skip_external_locking
    $key_buffer_size                  = $percona::default::key_buffer_size
    $max_allowed_packet               = $percona::default::max_allowed_packet
    $table_open_cache                 = $percona::default::table_open_cache
    $sort_buffer_size                 = $percona::default::sort_buffer_size
    $read_buffer_size                 = $percona::default::read_buffer_size
    $read_rnd_buffer_size             = $percona::default::read_rnd_buffer_size
    $myisam_sort_buffer_size          = $percona::default::myisam_sort_buffer_size
    $thread_cache_size                = $percona::default::thread_cache_size
    $query_cache_size                 = $percona::default::query_cache_size
    $thread_concurrency               = $percona::default::thread_concurrency
    $skip_networking                  = $percona::default::skip_networking
    $wsrep_slave_threads              = $percona::default::wsrep_slave_threads
    $wsrep_certify_non_pk             = $percona::default::wsrep_certify_non_pk
    $wsrep_max_ws_rows                = $percona::default::wsrep_max_ws_rows
    $wsrep_max_ws_size                = $percona::default::wsrep_max_ws_size
    $wsrep_debug                      = $percona::default::wsrep_debug
    $wsrep_convert_lock_to_trx        = $percona::default::wsrep_convert_lock_to_trx
    $wsrep_retry_autocommit           = $percona::default::wsrep_retry_autocommit
    $wsrep_auto_increment_control     = $percona::default::wsrep_auto_increment_control
    $wsrep_causal_reads               = $percona::default::wsrep_causal_reads
    $wsrep_notify_cmd                 = $percona::default::wsrep_notify_cmd
    $log_slave_updates                = $percona::default::log_slave_updates
    $default_storage_engine           = $percona::default::default_storage_engine
    $innodb_buffer_pool_size          = $percona::default::innodb_buffer_pool_size
    $innodb_additional_mem_pool_size  = $percona::default::innodb_additional_mem_pool_size
    $innodb_log_file_size             = $percona::default::innodb_log_file_size
    $innodb_log_buffer_size           = $percona::default::innodb_log_buffer_size
    $innodb_flush_log_at_trx_commit   = $percona::default::innodb_flush_log_at_trx_commit
    $innodb_lock_wait_timeout         = $percona::default::innodb_lock_wait_timeout
    $innodb_autoinc_lock_mode         = $percona::default::innodb_autoinc_lock_mode
    $innodb_locks_unsafe_for_binlog   = $percona::default::innodb_locks_unsafe_for_binlog
    $mysql_no_auto_rehash             = $percona::default::mysql_no_auto_rehash
    $mysql_safe_updates               = $percona::default::mysql_safe_updates
    $mysqldump_quick                  = $percona::default::mysqldump_quick
    $mysqldump_max_allowed_packet     = $percona::default::mysqldump_max_allowed_packet
    $myisamchk_key_buffer_size        = $percona::default::myisamchk_key_buffer_size
    $myisamchk_sort_buffer_size       = $percona::default::myisamchk_sort_buffer_size
    $myisamchk_read_buffer            = $percona::default::myisamchk_read_buffer
    $myisamchk_write_buffer           = $percona::default::myisamchk_write_buffer
    $mysqlhotcopy_interactive_timeout = $percona::default::mysqlhotcopy_interactive_timeout
    $user_password                    = $percona::default::user_password
    $user_database                    = $percona::default::user_database
    $user_host                        = $percona::default::user_host
    $user_permissions                 = $percona::default::user_permissions
    $user_grant                       = $percona::default::user_grant
    $database_sql_dump_file           = $percona::default::database_sql_dump_file
  }

  #-----------------------------------------------------------------------------
  # Operating system specific configurations

  case $::operatingsystem {
    debian, ubuntu: {
      include apt

      $os_percona_client_package  = "percona-xtradb-cluster-client-${percona_version}"
      $os_percona_server_package  = "percona-xtradb-cluster-server-${percona_version}"
      $os_percona_service         = 'mysql'

      $os_percona_common_packages = [
        'percona-xtrabackup',
        'percona-toolkit',
      ]

      $os_defaults_file             = '/etc/mysql/debian.cnf'

      $os_config                    = '/etc/mysql/my.cnf'
      $os_conf_dir                  = '/etc/mysql/conf.d'

      $os_log_dir                   = '/var/log/percona'
      $os_error_log                 = "${os_log_dir}/mysqld.log"

      $os_lib_dir                   = '/var/lib/mysql'
      $os_data_dir                  = $os_lib_dir

      $os_run_dir                   = '/var/run/mysqld'
      $os_pid_file                  = "${os_run_dir}/mysqld.pid"
      $os_socket                    = "${os_run_dir}/mysql.sock"

      $os_mysqlchk_daemon           = '/usr/bin/clustercheck'
      $os_cluster_check_user        = 'clustercheckuser'
      $os_cluster_check_password    = 'clustercheckpassword!'

      $os_sources_list_template     = 'percona/sources.list.erb'
      $os_config_template           = 'percona/my.cnf.erb'

      $os_log_bin                   = 'mysql-bin'
      $os_binlog_format             = 'ROW'

      $os_wsrep_provider            = '/usr/lib/libgalera_smm.so'
      $os_wsrep_sst_method          = 'xtrabackup'

      $os_innodb_data_home_dir      = $os_lib_dir
      $os_innodb_data_file_path     = 'ibdata1:10M:autoextend'
      $os_innodb_log_group_home_dir = $os_lib_dir

      #---

      apt::key { 'CD2EFD2A':
        ensure => present,
        notify => Exec['percona_apt_get_update'],
      }

      apt::sources_list { 'percona':
        ensure  => present,
        source  => false,
        content => template ($os_sources_list_template),
        notify  => Exec['percona_apt_get_update'];
      }

      exec { 'percona_apt_get_update':
        path        => [ '/bin', '/usr/bin' ],
        command     => 'apt-get update',
        refreshonly => true;
      }
    }
    default: {
      fail("The percona module is not currently supported on ${::operatingsystem}")
    }
  }
}
