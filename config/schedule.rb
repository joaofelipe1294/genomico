# ENV['RAILS_ENV'] = "development"

every 30.minute do
# every :day, at: '1:00 am' do
  rake "backup:do"
end
