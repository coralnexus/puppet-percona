
class percona::params {

  $percona_version    = '5.5'

  $server_id          = 1
  $server_ip          = $::ipaddress
  $origin_ip          = ''

  $allow_remote       = true

  $port               = 3306
  $mysqlchk_port      = 9200

  $cluster_check_user = 'clustercheckuser'
  $cluster_check_pw   = 'clustercheckpassword!'

  $service            = 'mysql'
  $user               = 'mysql'
  $group              = 'mysql'

  case $::operatingsystem {
    'debian', 'ubuntu': {
      $confdir           = '/etc/mysql'
      $config            = '/etc/mysql/my.cnf'

      $pkg_client        = "percona-xtradb-cluster-client-${percona_version}"
      $pkg_client_ensure = 'present'

      $pkg_server        = "percona-xtradb-cluster-server-${percona_version}"
      $pkg_server_ensure = 'present'

      $pkg_common        = [
        'percona-xtrabackup',
        'percona-toolkit',
      ]
      $pkg_common_ensure = 'present'

      $logdir            = '/var/log/percona'
      $errorlog          = '/var/log/mysqld.log'

      $socket            = '/var/lib/mysql/mysql.sock'
      $datadir           = '/var/lib/mysql'

      $pidfile           = '/var/run/mysqld/mysqld.pid'

      $mysqlchk_daemon   = '/usr/bin/clustercheck'
    }

    default: {
      fail 'Operating system not supported yet.'
    }
  }
}
