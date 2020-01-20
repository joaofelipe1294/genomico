namespace :maintenance do
  desc "TODO"
  task start: :environment do
    ActionController::Base.cache_store.write("maintenance", true)
  end

  desc "TODO"
  task stop: :environment do
    ActionController::Base.cache_store.write("maintenance", false)
  end

end
