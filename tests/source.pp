#
# Testing configuration file provisioning via source
# Auditing enabled
#
class { 'redis':
  source => 'puppet:///modules/redis/tests/test.conf',
  audit  => 'all',
}
