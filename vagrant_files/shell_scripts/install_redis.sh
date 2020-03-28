if [ ! -d "redis" ]; then
  mkdir redis
  cd redis
  wget http://download.redis.io/releases/redis-5.0.5.tar.gz
  tar xzf redis-5.0.5.tar.gz
  cd redis-5.0.5
  make
  make install
fi
