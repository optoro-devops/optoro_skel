# Use Chef to create the template, use sentinel to monitor the template

hosts = search(:node, 'recipe:optoro_redisha\:\:initial-master')
master_ip = hosts.first['ipaddress']

template '/etc/redis/redis.conf' do
  owner 'redis'
  group 'redis'
  variables ({
    :slaveof => "slaveof #{master_ip} 6379"
  })
  not_if { ::File.exists?('/etc/redis/redis.conf')}
end

template '/etc/redis/sentinel.conf' do
  owner 'redis'
  group 'redis'
  variables ({
    :sentinel => "sentinel monitor sentinel_sentinel #{master_ip} 6379 2"
  })
  not_if { ::File.exists?('/etc/redis/sentinel.conf')}
end