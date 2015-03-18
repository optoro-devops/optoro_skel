
#machine1: master redis, sentinel needs sentinel monitor
#machine2: slave redis, sentinel needs slave of and sentinel monitor
#machine3: sentinel need sentinel monitor

execute 'build-redis' do
  cwd Chef::Config[:file_cache_path]
  command 'tar -xzf redis-2.8.19.tar.gz ; cd redis-2.8.19 ; make && make install'
  action :nothing
end

remote_file "#{Chef::Config[:file_cache_path]}/redis-2.8.19.tar.gz" do
  source 'http://download.redis.io/releases/redis-2.8.19.tar.gz'
  notifies :run, 'execute[build-redis]', :immediately
end

user 'redis' do
  shell '/bin/false'
end

%w{ /var/optoro/redis /var/log/redis /etc/redis }.each do |redisdir|
  directory redisdir do
    recursive true
    owner 'redis'
    group 'redis'
  end
end

%w{ /etc/init.d/redis /etc/init.d/sentinel }.each do |redisinit|
  cookbook_file redisinit do
    mode 0755
  end
end

%w{ redis sentinel }.each do |redisservice|
  service redisservice do
    supports :start => true
    action :nothing
  end
end

# backups?
# Does it maintain data after a restart?
# communicate to devs to talk with a sentinel server and not with redis directly:
# http://redis.io/topics/sentinel-clients


