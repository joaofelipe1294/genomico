if [ ! -d "redis" ]; then
  mkdir redis
  cd redis
  wget http://download.redis.io/releases/redis-5.0.5.tar.gz -e use_proxy=yes -e http_proxy=http://proxy.cdapp.net.br:3128
  tar xzf redis-5.0.5.tar.gz
  cd redis-5.0.5
  make
  make install
fi
