namespace :maintenance do
  desc "Start maintenance mode, redirecting all requests to a maintenance page"
  task start: :environment do
    ActionController::Base.cache_store.write("maintenance", true)
  end

  desc "Stop maintenance mode and restar server case enviroment is production"
  task stop: :environment do
    ActionController::Base.cache_store.write("maintenance", false)
    if Rails.env == "production"
      `kill  $(cat #{Rails.root}/tmp/pids/server.pid)`
      `rails s -b 0.0.0.0 -e production -d`
    end
  end

end
