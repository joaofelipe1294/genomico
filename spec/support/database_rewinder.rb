RSpec.configure do |config|

  config.before(:suite) do
    DatabaseRewinder.clean_all
  end

  config.append_after(:each) do
    DatabaseRewinder.clean
  end

end
