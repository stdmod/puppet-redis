# Class: redis::params
#
# Defines all the variables used in the module.
#
class redis::params {

  $package = $::osfamily ? {
    Debian  => 'redis-server',
    default => 'redis',
  }

  $service = $::osfamily ? {
    Debian  => 'redis-server',
    default => 'redis',
  }

  $file = $::osfamily ? {
    RedHat  => '/etc/redis.conf',
    default => '/etc/redis/redis.conf',
  }

  $file_mode = $::osfamily ? {
    default => '0644',
  }

  $file_owner = $::osfamily ? {
    default => 'root',
  }

  $file_group = $::osfamily ? {
    default => 'root',
  }

  $dir = $::osfamily ? {
    default => '/etc/redis',
  }

}
