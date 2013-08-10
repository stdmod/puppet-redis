# Puppet module: redis

This is a Puppet module for redis.
It manages its installation, configuration and service.

The module is based on stdmod naming standars.
Refer to http://github.com/stdmod/

Released under the terms of Apache 2 License.


## USAGE - Basic management

* Install redis with default settings (package installed, service started, default configuration files)

        class { 'redis': }

* Remove redis package and purge all the managed files

        class { 'redis':
          ensure => absent,
        }

* Install a specific version of redis package

        class { 'redis':
          version => '1.0.1',
        }

* Install the latest version of redis package

        class { 'redis':
          version => 'latest',
        }

* Enable redis service. This is default.

        class { 'redis':
          service_ensure => 'running',
        }

* Enable redis service at boot. This is default.

        class { 'redis':
          service_status => 'enabled',
        }


* Do not automatically restart services when configuration files change (Default: Class['redis::config']).

        class { 'redis':
          service_subscribe => false,
        }

* Enable auditing (on all the arguments)  without making changes on existing redis configuration *files*

        class { 'redis':
          audit => 'all',
        }

* Module dry-run: Do not make any change on *all* the resources provided by the module

        class { 'redis':
          noop => true,
        }


## USAGE - Overrides and Customizations
* Use custom source for main configuration file 

        class { 'redis':
          file_source => [ "puppet:///modules/example42/redis/redis.conf-${hostname}" ,
                           "puppet:///modules/example42/redis/redis.conf" ], 
        }


* Use custom source directory for the whole configuration dir.

        class { 'redis':
          dir_source  => 'puppet:///modules/example42/redis/conf/',
        }

* Use custom source directory for the whole configuration dir purging all the local files that are not on the dir.
  Note: This option can be used to be sure that the content of a directory is exactly the same you expect, but it is desctructive and may remove files.

        class { 'redis':
          dir_source => 'puppet:///modules/example42/redis/conf/',
          dir_purge  => true, # Default: false.
        }

* Use custom source directory for the whole configuration dir and define recursing policy.

        class { 'redis':
          dir_source    => 'puppet:///modules/example42/redis/conf/',
          dir_recursion => false, # Default: true.
        }

* Use custom template for main config file. Note that template and source arguments are alternative.

        class { 'redis':
          file_template => 'example42/redis/redis.conf.erb',
        }

* Use a custom template and provide an hash of custom configurations that you can use inside the template

        class { 'redis':
          filetemplate       => 'example42/redis/redis.conf.erb',
          file_options_hash  => {
            opt  => 'value',
            opt2 => 'value2',
          },
        }


* Specify the name of a custom class to include that provides the dependencies required by the module

        class { 'redis':
          dependency_class => 'site::redis_dependency',
        }


* Automatically include a custom class with extra resources related to redis.
  Here is loaded $modulepath/example42/manifests/my_redis.pp.
  Note: Use a subclass name different than redis to avoid order loading issues.

        class { 'redis':
         my_class => 'site::redis_my',
        }

## TESTING
[![Build Status](https://travis-ci.org/stdmod/puppet-redis.png?branch=master)](https://travis-ci.org/stdmod/puppet-redis)
