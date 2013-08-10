#
# Testing configuration file provisioning via template
# Auditing enabled
#
class { 'redis':
  template => 'redis/tests/test.conf',
  audit    => 'all',
}
