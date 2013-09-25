#
# = Class: redis::firewall
#
# This class firewalls redis
#
# POC
#
class redis::firewall {

  $enable          = $redis::firewall_options_hash['enable'],
  $tool            = $redis::firewall_options_hash['tool'],
  $host            = $redis::firewall_options_hash['host'],
  $port            = $redis::firewall_options_hash['port'],
  $protocol        = $redis::firewall_options_hash['protocol'],
  $source_ip4      = $redis::firewall_options_hash['source_ip4'],
  $destination_ip4 = $redis::firewall_options_hash['destination_ip4'],
  $source_ip6      = $redis::firewall_options_hash['source_ip6'],
  $destination_ip6 = $redis::firewall_options_hash['destination_ip6'],

  if $port {
    firewall::port { "redis_${protocol}_${port}":
      enable   => $enable,
      ip       => $host,
      protocol => $protocol,
      port     => $port,
      tool     => $tool,
    }
  }
}
