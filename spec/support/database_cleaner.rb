RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    puts "Truncation"
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, :js => true) do
    puts "Truncation - js"
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    puts "Start clean"
    DatabaseCleaner.start
  end

  config.after(:each) do
    puts "Clean"
    DatabaseCleaner.clean
  end

end
