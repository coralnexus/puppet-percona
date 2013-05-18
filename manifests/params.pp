
class percona::params inherits percona::default {

  $apt_location                     = module_param('apt_location')
  $apt_repos                        = module_param('apt_repos')
  $apt_key                          = module_param('apt_key')
  $apt_key_server                   = module_param('apt_key_server')

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
  $root_user                        = module_param('root_user')
  $root_password                    = module_param('root_password')
  $mysql_user                       = module_param('mysql_user')
  $mysql_password                   = module_param('mysql_password')

  $config                           = module_param('config')
  $config_template                  = module_param('config_template')
  $generic_template                 = module_param('generic_template')
  $user_config                      = module_param('user_config')
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
  $origin_addresses                 = module_param('origin_addresses')
  $cluster_name                     = module_param('cluster_name')
  $allow_remote                     = module_param('allow_remote')
  $configure_firewall               = module_param('configure_firewall')
  $percona_ports                    = module_array('percona_ports')
  $port                             = module_param('port')
  $mysqlchk_port                    = module_param('mysqlchk_port')
  $user_name                        = module_param('user_name')
  $group                            = module_param('group')
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
  $default_storage_engine           = module_param('default_storage_engine')
  $innodb_data_home_dir             = module_param('innodb_data_home_dir')
  $innodb_log_group_home_dir        = module_param('innodb_log_group_home_dir')
  $innodb_flush_log_at_trx_commit   = module_param('innodb_flush_log_at_trx_commit')
  $innodb_autoinc_lock_mode         = module_param('innodb_autoinc_lock_mode')
  $innodb_locks_unsafe_for_binlog   = module_param('innodb_locks_unsafe_for_binlog')

  $configurations                   = module_hash('configurations')

  #---

  $mysqlchk_daemon                  = module_param('mysqlchk_daemon')
  $cluster_check_user               = module_param('cluster_check_user')
  $cluster_check_password           = module_param('cluster_check_password')

  #---

  $user_password                    = module_param('user_password')
  $user_database                    = module_param('user_database')
  $user_host                        = module_param('user_host')
  $user_permissions                 = module_param('user_permissions')
  $user_grant                       = module_param('user_grant')
  $database_sql_dump_file           = module_param('database_sql_dump_file')
}
