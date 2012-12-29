
class percona::params inherits percona::default {

  $apt_key                          = module_param('apt_key')
  $sources_list_template            = module_param('sources_list_template')
  $version                          = module_param('version')
  $client_package                   = module_param('client_package')
  $client_ensure                    = module_param('client_ensure')
  $server_package                   = module_param('server_package')
  $server_ensure                    = module_param('server_ensure')
  $common_packages                  = module_array('common_packages')
  $common_ensure                    = module_param('common_ensure')
  $service                          = module_param('service')
  $service_ensure                   = module_param('service_ensure')

  #---

  $defaults_file                    = module_param('defaults_file')
  $config                           = module_param('config')
  $config_template                  = module_param('config_template')
  $conf_dir                         = module_param('conf_dir')
  $log_dir                          = module_param('log_dir')
  $error_log                        = module_param('error_log')
  $lib_dir                          = module_param('lib_dir')
  $data_dir                         = module_param('data_dir')
  $run_dir                          = module_param('run_dir')
  $pid_file                         = module_param('pid_file')
  $socket                           = module_param('socket')

  #---

  $server_id                        = module_param('server_id')
  $server_ip                        = module_param('server_ip')
  $origin_ip                        = module_param('origin_ip')
  $cluster_name                     = module_param('cluster_name')
  $allow_remote                     = module_param('allow_remote')
  $configure_firewall               = module_param('configure_firewall')
  $port                             = module_param('port')
  $mysqlchk_port                    = module_param('mysqlchk_port')
  $user                             = module_param('user')
  $group                            = module_param('group')
  $skip_external_locking            = module_param('skip_external_locking')
  $key_buffer_size                  = module_param('key_buffer_size')
  $max_allowed_packet               = module_param('max_allowed_packet')
  $table_open_cache                 = module_param('table_open_cache')
  $sort_buffer_size                 = module_param('sort_buffer_size')
  $read_buffer_size                 = module_param('read_buffer_size')
  $read_rnd_buffer_size             = module_param('read_rnd_buffer_size')
  $myisam_sort_buffer_size          = module_param('myisam_sort_buffer_size')
  $thread_cache_size                = module_param('thread_cache_size')
  $query_cache_size                 = module_param('query_cache_size')
  $thread_concurrency               = module_param('thread_concurrency')
  $skip_networking                  = module_param('skip_networking')
  $log_bin                          = module_param('log_bin')
  $binlog_format                    = module_param('binlog_format')
  $wsrep_provider                   = module_param('wsrep_provider')
  $wsrep_sst_method                 = module_param('wsrep_sst_method')
  $wsrep_slave_threads              = module_param('wsrep_slave_threads')
  $wsrep_certify_non_pk             = module_param('wsrep_certify_non_pk')
  $wsrep_max_ws_rows                = module_param('wsrep_max_ws_rows')
  $wsrep_max_ws_size                = module_param('wsrep_max_ws_size')
  $wsrep_debug                      = module_param('wsrep_debug')
  $wsrep_convert_lock_to_trx        = module_param('wsrep_convert_lock_to_trx')
  $wsrep_retry_autocommit           = module_param('wsrep_retry_autocommit')
  $wsrep_auto_increment_control     = module_param('wsrep_auto_increment_control')
  $wsrep_causal_reads               = module_param('wsrep_causal_reads')
  $wsrep_notify_cmd                 = module_param('wsrep_notify_cmd')
  $log_slave_updates                = module_param('log_slave_updates')
  $default_storage_engine           = module_param('default_storage_engine')
  $innodb_data_home_dir             = module_param('innodb_data_home_dir')
  $innodb_buffer_pool_size          = module_param('innodb_buffer_pool_size')
  $innodb_additional_mem_pool_size  = module_param('innodb_additional_mem_pool_size')
  $innodb_log_buffer_size           = module_param('innodb_log_buffer_size')
  $innodb_log_group_home_dir        = module_param('innodb_log_group_home_dir')
  $innodb_flush_log_at_trx_commit   = module_param('innodb_flush_log_at_trx_commit')
  $innodb_lock_wait_timeout         = module_param('innodb_lock_wait_timeout')
  $innodb_autoinc_lock_mode         = module_param('innodb_autoinc_lock_mode')
  $innodb_locks_unsafe_for_binlog   = module_param('innodb_locks_unsafe_for_binlog')
  $mysql_no_auto_rehash             = module_param('mysql_no_auto_rehash')
  $mysql_safe_updates               = module_param('mysql_safe_updates')
  $mysqldump_quick                  = module_param('mysqldump_quick')
  $mysqldump_max_allowed_packet     = module_param('mysqldump_max_allowed_packet')
  $myisamchk_key_buffer_size        = module_param('myisamchk_key_buffer_size')
  $myisamchk_sort_buffer_size       = module_param('myisamchk_sort_buffer_size')
  $myisamchk_read_buffer            = module_param('myisamchk_read_buffer')
  $myisamchk_write_buffer           = module_param('myisamchk_write_buffer')
  $mysqlhotcopy_interactive_timeout = module_param('mysqlhotcopy_interactive_timeout')

  #---

  $mysqlchk_daemon                  = module_param('mysqlchk_daemon')
  $cluster_check_user               = module_param('cluster_check_user')
  $cluster_check_password           = module_param('cluster_check_password')

  #---

  $user_name                        = module_param('user_name')
  $user_password                    = module_param('user_password')
  $user_database                    = module_param('user_database')
  $user_host                        = module_param('user_host')
  $user_permissions                 = module_param('user_permissions')
  $user_grant                       = module_param('user_grant')
  $database_sql_dump_file           = module_param('database_sql_dump_file')
}
