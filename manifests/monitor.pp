#
# = Class: redis::monitor
#
# This class monitors redis
#
# POC
#
class redis::monitor {

  $enable   = $redis::monitor_options_hash['enable'],
  $tool     = $redis::monitor_options_hash['tool'],
  $host     = $redis::monitor_options_hash['host'],
  $protocol = $redis::monitor_options_hash['protocol'],
  $port     = $redis::monitor_options_hash['port'],
  $service  = $redis::monitor_options_hash['service'],
  $process  = $redis::monitor_options_hash['process'],

  if $port and $protocol == 'tcp' {
    monitor::port { "redis_port_${protocol}_${port}":
      enable   => $enable,
      tool     => $tool,
      ip       => $host,
      protocol => $protocol,
      port     => $port,
    }
  }
  if $service {
    monitor::service { "redis_service_${service}":
      enable   => $enable,
      tool     => $tool,
      service  => $service,
    }
  }


}
