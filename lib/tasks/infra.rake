namespace :infra do
  desc "será chamado pelo hook fazendo o deploy de forma automatizada"
  task deploy: :environment do
    `export RAILS_ENV=production`
    `rails backup:do RAILS_ENV=production`
    puts "Kill server"
    `kill kill $(cat tmp/pids/server.pid)`
    puts "Kill server [OK]"
    puts "Installing gems"
    `export export http_proxy=http://proxy.cdapp.net.br:3128 && export HTTP_PROXY=$http_proxy`
    `bundle`
    puts "Installing gems [OK]"
    puts "Migrating tables"
    `rails db:migrate RAILS_ENV=production`
    puts "Migrating tables [OK]"
    puts "Starting server"
    `rails s -b 0.0.0.0 -p 3000 -d -e production`
    puts "Starting server [OK]"
  end

end
