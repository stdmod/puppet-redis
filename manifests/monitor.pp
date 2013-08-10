#
# = Class: redis::monitor
#
# This class monitors redis
#
class redis::monitor (
  $enable   = $redis::monitor,
  $tool     = $redis::monitor_tool,
  $host     = $redis::monitor_host,
  $protocol = $redis::monitor_protocol,
  $port     = $redis::monitor_port,
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
