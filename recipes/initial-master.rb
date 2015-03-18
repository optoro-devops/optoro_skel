# master needs no 'slaveof' line in its redis.conf
# master needs to monitor itself with sentinel
# Use Chef to create the template, use sentinel to monitor the template

template '/etc/redis/redis.conf' do
  owner 'redis'
  group 'redis'
  variables ({
    :slaveof => ''
  })
  not_if { ::File.exists?('/etc/redis/redis.conf')}
end

template '/etc/redis/sentinel.conf' do
  owner 'redis'
  group 'redis'
  variables ({
    :sentinel => "sentinel monitor sentinel_sentinel #{node['ipaddress']} 6379 2"
  })
  not_if { ::File.exists?('/etc/redis/sentinel.conf')}
end