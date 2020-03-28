if [ ! -d "/home/vagrant/.rbenv" ]; then
  git clone https://github.com/rbenv/rbenv.git ~/.rbenv
  echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
  echo 'eval "$(rbenv init -)"' >> ~/.bashrc
  git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
fi
/home/vagrant/.rbenv/bin/rbenv install -s 2.5.5
/home/vagrant/.rbenv/bin/rbenv global 2.5.5
/home/vagrant/.rbenv/shims/gem install bundler -v 2.0.2
/home/vagrant/.rbenv/shims/gem install rails -v 5.2.3
/home/vagrant/.rbenv/bin/rbenv rehash
