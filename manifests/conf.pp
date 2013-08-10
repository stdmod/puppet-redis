#
# = Define: redis::conf
#
# With this define you can manage any redis configuration file
# providing a template and, eventually, and options hash where you
# can place any redis specific setting.
#
# == Parameters
#
# [*template*]
#   String. Required. Default: Provided by the module.
#   Sets the module path of a custom template to use as content of
#   the config file
#   When defined, config file has: content => content("$template")
#   Example: template => 'site/redis/my.conf.erb',
#
# [*ensure*]
#   String. Default: present
#   Manages config file presence. Possible values:
#   * 'present' - Create and manages the file.
#   * 'absent' - Remove the file.
#
# [*path*]
#   String. Optional. Default: $config_dir/$title
#   The path of the created config file. If not defined a file
#   name like the  the name of the title a custom template to use as content of configfile
#   If defined, configfile file has: content => content("$template")
#   Example: path => '/usr/local/etc/redis/my.conf',
#
# [*options_hash*]
#   Hash. Default undef. Needs: 'template'.
#   An hash of custom options to be used in templates to manage any key pairs of
#   arbitrary settings.
#
define redis::conf (
  $template,
  $path         = undef,
  $template     = undef,
  $options_hash = undef,
  $ensure       = present ) {

  include redis

  $managed_path = $path ? {
    undef   => "${redis::dir_path}/${name}",
    default => $path,
  }

  file { "redis_conf_${name}":
    ensure  => $ensure,
    path    => $managed_path,
    mode    => $redis::file_mode,
    owner   => $redis::file_owner,
    group   => $redis::file_group,
    require => Package[$redis::package],
    notify  => $redis::file_notify,
    content => template($template),
    replace => $redis::file_replace,
    audit   => $redis::file_audit,
  }

}
