
class percona::params {

  $client          = true

  $server          = false
  $port            = 3306
  $allow_remote    = true

  $percona_version = '5.5' # Options: 5.1, 5.5

  $service   = 'mysql'
  $user      = 'mysql'
  $group     = 'mysql'
  $logdir    = '/var/log/percona'
  $socket    = '/var/lib/mysql/mysql.sock'
  $datadir   = '/var/lib/mysql'
  $targetdir = '/data/backups/mysql/'
  $errorlog  = '/var/log/mysqld.log'
  $pidfile   = '/var/run/mysqld/mysqld.pid'

  case $::operatingsystem {
    'debian', 'ubuntu': {
      $confdir    = '/etc/mysql'
      $config     = '/etc/mysql/my.cnf'
      $pkg_client = "percona-server-client-${percona_version}"
      $pkg_server = "percona-server-server-${percona_version}"
      $pkg_common = [
        'percona-toolkit',
        "percona-server-common-${percona_version}",
      ]
    }

    default: {
      fail 'Operating system not supported yet.'
    }
  }
}
