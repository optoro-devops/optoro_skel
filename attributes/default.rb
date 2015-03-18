default[:redisio][:servers] = [
  { port: 6379 }
]

default['redisio']['sentinel_defaults'] = {
  'user' => 'redis',
  'configdir' => '/etc/redis',
  'sentinel_port' => 26379,
  'monitor' => nil,
  'down-after-milliseconds' => 30000,
  'can-failover' => 'yes',
  'parallel-syncs' => 1,
  'failover-timeout' => 900000,
  'loglevel' => 'notice',
  'logfile' => nil,
  'syslogenabled' => 'yes',
  'syslogfacility' => 'local0',
  'quorum_count' => 2
}