namespace :infra do
  desc "será chamado pelo hook fazendo o deploy de forma automatizada"
  task deploy: :environment do
    # `export RAILS_ENV=production`
    # `rails backup:do`
    puts "Kill server"
    # server_port = `lsof -t -i :3500`
    # `kill #{server_port}`
    # puts "Kill server [OK]"
    # puts "Installing gems"
    # `export http_proxy=http://proxy.cdapp.net.br:3128`
    # `export HTTP_PROXY=$http_proxy`
    # `bundle`
    # puts "Installing gems [OK]"
    # puts "Migrating tables"
    # `rails db:migrate`
    # puts "Migrating tables [OK]"
    # puts "Starting server"
    # `rails s -b 0.0.0.0 -p 3500 -d -e production`
    # puts "Starting server [OK]"
    puts "DEPROI SENDU FEITU"
  end

end
