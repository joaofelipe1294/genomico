namespace :infra do
  desc "será chamado pelo hook fazendo o deploy de forma automatizada"
  task deploy: :environment do
    puts "clean redis ..."
    `redis-cli flushall`
    puts "clean redis [OK]"
    `export RAILS_ENV=production`
    puts "Kill server ..."
    `kill $(cat tmp/pids/server.pid)`
    puts "Kill server [OK]"
    puts "Migrating tables ..."
    `rails db:migrate RAILS_ENV=production`
    puts "Migrating tables [OK]"
    puts "Starting server"
    `rails s -b 0.0.0.0 -p 3000 -d -e production`
    puts "Starting server [OK]"
  end

end
