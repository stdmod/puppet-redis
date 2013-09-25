#
# = Class: redis::monitor
#
# This class monitors redis
#
# POC
#
class redis::monitor (
  $enable   = $redis::monitor_options_hash['enable'],
  $tool     = $redis::monitor_options_hash['tool'],
  $host     = $redis::monitor_options_hash['host'],
  $protocol = $redis::monitor_options_hash['protocol'],
  $port     = $redis::monitor_options_hash['port'],
  $service  = $redis::service,
  ) inherits redis {

  if $port and $protocol == 'tcp' {
    monitor::port { "redis_${redis::protocol}_${redis::port}":
      ip       => $host,
      protocol => $protocol,
      port     => $port,
      tool     => $tool,
      enable   => $enable,
    }
  }
  if $service {
    monitor::service { 'redis_service':
      service  => $service,
      tool     => $tool,
      enable   => $enable,
    }
  }
}
