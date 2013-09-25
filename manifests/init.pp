#
# = Class: redis
#
# This class installs and manages redis
#
#
# == Parameters
#
# Refer to the official documentation for standard parameters usage.
# Look at the code for the list of supported parametes and their defaults.
#
class redis (

  $ensure              = 'present',
  $version             = undef,

  $package             = $redis::params::package,

  $service             = $redis::params::service,
  $service_ensure      = 'running',
  $service_enable      = true,

  $file                = $redis::params::file,
  $file_owner          = $redis::params::file_owner,
  $file_group          = $redis::params::file_group,
  $file_mode           = $redis::params::file_mode,
  $file_replace        = $redis::params::file_replace,
  $file_require        = "Package['redis']",
  $file_notify         = "Service['redis']",
  $file_source         = undef,
  $file_template       = undef,
  $file_content        = undef,
  $file_options_hash   = undef,

  $dir                 = $redis::params::dir,
  $dir_source          = undef,
  $dir_purge           = false,
  $dir_recurse         = true,

  $dependency_class    = undef,
  $my_class            = undef,

  $monitor_class       = 'redis::monitor',
  $monitor_options_hash = { } ,

  $firewall_class      = 'redis::firewall',
  $firewall_options_hash = { } ,

  ) inherits redis::params {


  # Input parameters validation
  validate_re($ensure, ['present','absent'], 'Valid values are: present, absent. WARNING: If set to absent all the resources managed by the module are removed.')
  validate_bool($service_enable)
  validate_bool($dir_recurse)
  validate_bool($dir_purge)
  if $file_options_hash { validate_hash($file_options_hash) }

  # Calculation of variables used in the module
  if $file_content {
    $managed_file_content = $file_content
  } else {
    if $file_template {
      $managed_file_content = template($file_template)
    } else {
      $managed_file_content = undef
    }
  }

  if $version {
    $managed_package_ensure = $version
  } else {
    $managed_package_ensure = $ensure
  }

  if $ensure == 'absent' {
    $managed_service_enable = undef
    $managed_service_ensure = stopped
    $dir_ensure = absent
    $file_ensure = absent
  } else {
    $managed_service_enable = $service_enable
    $managed_service_ensure = $service_ensure
    $dir_ensure = directory
    $file_ensure = present
  }


  # Resources Managed

  if $redis::package {
    package { $redis::package:
      ensure   => $redis::managed_package_ensure,
    }
  }

  if $redis::service {
    service { $redis::service:
      ensure     => $redis::managed_service_ensure,
      enable     => $redis::managed_service_enable,
    }
  }

  if $redis::file {
    file { 'redis.conf':
      ensure  => $redis::file_ensure,
      path    => $redis::file,
      mode    => $redis::file_mode,
      owner   => $redis::file_owner,
      group   => $redis::file_group,
      source  => $redis::file_source,
      content => $redis::managed_file_content,
      notify  => $redis::file_notify,
      require => $redis::file_require,
    }
  }

  if $redis::dir_source {
    file { 'redis.dir':
      ensure  => $redis::dir_ensure,
      path    => $redis::dir,
      source  => $redis::dir_source,
      recurse => $redis::dir_recurse,
      purge   => $redis::dir_purge,
      force   => $redis::dir_purge,
      notify  => $redis::file_notify,
      require => $redis::file_require,
    }
  }

  # Extra classes
  if $redis::dependency_class {
    include $redis::dependency_class
  }

  if $redis::monitor_class {
    include $redis::monitor_class
  }

  if $redis::firewall_class {
    include $redis::firewall_class
  }

  if $redis::my_class {
    include $redis::my_class
  }

}
