# Puppet Percona XtraDB Cluster (with Xtrabackup)

This module was originally forked from https://github.com/arioch/puppet-percona.

While some things remain the same, the majority of this module has been 
significantly refactored to include Hiera support.  We utilize smart defaults
and the hiera function to allow for fine grained configurability without extra
Puppet code.

## Requirements

* Camptocamp [apt module]

## Basic usage

### Client only
    class { 'apt': }
    class { 'percona': }

    Class['apt'] ->
    Class['percona']

### Client and server
    class { 'apt': }
    class { 'percona': server => true; }

    Class['apt'] ->
    Class['percona']

### Configuration
    percona::conf {
      'innodb_file_per_table': content => "[mysqld]\ninnodb_file_per_table";
      
      'foo':
        ensure  => present,
        content => template ("percona/custom1.cnf.erb");
      'bar':
        ensure  => absent,
        content => template ("percona/custom2.cnf.erb");
    }

    percona::database { 'dbfoo':
      ensure => present;
    }

    percona::user { 'userfoo':
      ensure   => present,
      password => 'default',
      database => 'dbfoo';
    }

    percona::user { 'userbar':
      ensure   => present,
      password => 'default',
      database => 'dbfoo';
    }

### Unit testing

Unit testing is done using [rspec-puppet]
To test the module run the following:

    # Installation
    gem install rspec-puppet --no-ri --no-rdoc

    # Run tests
    cd /etc/puppet/modules/percona
    rake

[apt module]: https://github.com/camptocamp/puppet-apt
[rspec-puppet]: https://github.com/rodjek/rspec-puppet

