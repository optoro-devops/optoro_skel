#
# slave needs to be a slaveof master
# slave's sentinel needs to connect to master and figure out the rest of the slaves/sentinels
# Use Chef to create the template, use sentinel to monitor the template

master_ip = '127.0.0.1'
unless Chef::Config['solo']
  hosts = search(:node, 'recipe:optoro_redisha\:\:initial-master')
  master_ip = hosts.first['ipaddress']
end

template '/etc/redis/redis.conf' do
  owner 'redis'
  group 'redis'
  variables(
    :slaveof => "slaveof #{master_ip} 6379"
  )
  not_if { ::File.exist?('/etc/redis/redis.conf') }
end

template '/etc/redis/sentinel.conf' do
  owner 'redis'
  group 'redis'
  variables(
    :sentinel => "sentinel monitor sentinel_sentinel #{master_ip} 6379 2"
  )
  not_if { ::File.exist?('/etc/redis/sentinel.conf') }
end
