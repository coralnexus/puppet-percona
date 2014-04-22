class percona::default {

  $version                          = '5.6'
  $client_ensure                    = 'present'
  $server_ensure                    = 'present'
  $common_ensure                    = 'present'
  $service_ensure                   = 'running'

  $server_id                        = 1
  $server_ip                        = $::ipaddress
  $origin_addresses                 = undef

  $cluster_name                     = 'test'
  $allow_remote                     = true
  $configure_firewall               = true
  $percona_ports                    = [ 4444, 4567, 4568 ]
  $port                             = 3306
  $mysqlchk_port                    = 9200
  $user_name                        = 'mysql'
  $group                            = 'mysql'
  $wsrep_slave_threads              = '2'
  $wsrep_certify_non_pk             = '1'
  $wsrep_max_ws_rows                = '131072'
  $wsrep_max_ws_size                = '1073741824'
  $wsrep_debug                      = '0'
  $wsrep_convert_lock_to_trx        = '0'
  $wsrep_retry_autocommit           = '1'
  $wsrep_auto_increment_control     = '1'
  $wsrep_causal_reads               = '0'
  $wsrep_notify_cmd                 = ''
  $default_storage_engine           = 'innodb'
  $innodb_flush_log_at_trx_commit   = '1'
  $innodb_autoinc_lock_mode         = '2'
  $innodb_locks_unsafe_for_binlog   = '1'

  $user_password                    = 'db_user'
  $user_database                    = '*'
  $user_host                        = 'localhost'
  $user_permissions                 = 'ALL'
  $user_grant                       = true

  $database_sql_dump_file           = ''

  $root_user                        = 'root'
  $root_password                    = '%t3St%'

  $mysql_user                       = 'mysql'
  $mysql_password                   = '%mYSqL%'

  $configurations                   = {
    "mysql" => {
      "no-auto-rehash" => "",
      "safe-updates" => "",
    },
    "mysqld" => {
      "key_buffer_size" => "256M",
      "max_allowed_packet" => "1M",
      "table_open_cache" => "256M",
      "sort_buffer_size" => "1M",
      "read_buffer_size" => "1M",
      "read_rnd_buffer_size" => "4M",
      "myisam_sort_buffer_size" => "64M",
      "thread_cache_size" => "8",
      "thread_concurrency" => "8",
      "innodb_buffer_pool_size" => "256M",
      "innodb_log_buffer_size" => "8M",
      "innodb_lock_wait_timeout" => "50",
      "log-slave-updates" => "",
      "skip-external-locking" => ""
    },
    "mysqldump" => {
      "quick" => true,
      "max_allowed_packet" => "16M",
    },
    "myisamchk" => {
      "key_buffer_size" => "128M",
      "sort_buffer_size" => "128M",
      "read_buffer" => "2M",
      "write_buffer" => "2M",
    },
    "mysqlhotcopy" => {
      "interactive-timeout" => "",
    },
  }

  #---

  case $::operatingsystem {
    debian, ubuntu: {
      $apt_location    = 'http://repo.percona.com/apt'
      $apt_repos       = 'main'
      $apt_key         = 'CD2EFD2A'
      $apt_key_server  = 'keys.gnupg.net'

      $client_package  = "percona-xtradb-cluster-client-${version}"
      $server_package  = "percona-xtradb-cluster-server-${version}"
      $service         = 'mysql'

      $common_packages = [
        'percona-xtrabackup',
        'percona-toolkit',
      ]

      $config                    = '/etc/mysql/my.cnf'
      $user_config               = '/etc/mysql/debian.cnf'
      $conf_dir                  = '/etc/mysql/conf.d'

      $log_dir                   = '/var/log/percona'
      $error_log                 = "${log_dir}/mysqld.log"

      $lib_dir                   = '/var/lib/mysql'
      $data_dir                  = $lib_dir

      $run_dir                   = '/var/run/mysqld'
      $pid_file                  = "${run_dir}/mysqld.pid"
      $socket                    = "${run_dir}/mysqld.sock"

      $mysqlchk_daemon           = '/usr/bin/clustercheck'
      $cluster_check_user        = 'clustercheckuser'
      $cluster_check_password    = 'clustercheckpassword!'

      $config_template           = 'percona/my.cnf.erb'
      $generic_template          = 'percona/generic.cnf.erb'

      $log_bin                   = 'mysql-bin'
      $binlog_format             = 'ROW'

      $wsrep_provider            = '/usr/lib/libgalera_smm.so'
      $wsrep_sst_method          = 'xtrabackup'

      $innodb_data_home_dir      = $lib_dir
      $innodb_log_group_home_dir = $lib_dir
    }
    default: {
      fail("The percona module is not currently supported on ${::operatingsystem}")
    }
  }
}
