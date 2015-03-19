
# machine1: master redis, sentinel:  needs "sentinel monitor" config line
# machine2: slave redis, sentinel:   needs "slaveof" and "sentinel monitor" config lines
# machine3: sentinel:                needs "sentinel monitor" config line

# Build Tarball
execute 'build-redis' do
  cwd Chef::Config[:file_cache_path]
  command 'tar -xzf redis-2.8.19.tar.gz ; cd redis-2.8.19 ; make && make install'
  action :nothing
end

# Copy Source
remote_file "#{Chef::Config[:file_cache_path]}/redis-2.8.19.tar.gz" do
  source 'http://download.redis.io/releases/redis-2.8.19.tar.gz'
  notifies :run, 'execute[build-redis]', :immediately
end

# Make redis user
user 'redis' do
  shell '/bin/false'
end

# Make supporting directories
%w( /var/optoro/redis /var/log/redis /etc/redis ).each do |redisdir|
  directory redisdir do
    recursive true
    owner 'redis'
    group 'redis'
  end
end

# Copy Init Scripts
%w( /etc/init.d/redis /etc/init.d/sentinel ).each do |redisinit|
  cookbook_file redisinit do
    mode 0755
  end
end

# Allow services to be started (for subordinate cookbooks)
%w( redis sentinel ).each do |redisservice|
  service redisservice do
    supports :start => true
    action :nothing
  end
end

# Notes
# backups?
# communicate to devs to talk with a sentinel server and not with redis directly:
# http://redis.io/topics/sentinel-clients
