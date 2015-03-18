# Install redis and sentinals

# Use chef search to find an existing redis master
master_ip = '5.6.7.8'

# If not found we are the redis master

# Install Redis
redisio_install 'redis-installation' do
  version '2.8.14'
  download_url 'http://download.redis.io/releases/redis-2.8.14.tar.gz'
  safe_install false
  install_dir '/usr/local/'
end

# Confgiure Redis
redisio_configure 'redis-servers' do
  version '2.8.14'
  default_settings node['redisio']['default_settings']
  servers node['redisio']['servers']
  base_piddir node['redisio']['base_piddir']
end

# Install Sentinal - we are all sentinals
redisio_sentinel 'redis-sentinels' do
  sentinel_defaults node['redisio']['sentinel_defaults']
  sentinels [{"sentinel_port"=>"26379", "name"=>"sentinel", "master_ip"=>master_ip, "master_port"=>6379}]
end

service 'redis6379' do
  action [:enable, :start]
end

service 'redis_sentinel_sentinel' do
  action [:enable, :start]
end
