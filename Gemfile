
source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '5.2.1'
# Use postgresql as the database for Active Record
gem 'pg', '~> 0.20.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc
# Bootstrap 4 rubygem for Rails / Sprockets / Hanami / etc https://rubygems.org/gems/bootstrap
gem 'bootstrap', '~> 4.3.1'
#⚡ A Scope & Engine based, clean, powerful, customizable and sophisticated paginator for Ruby webapps https://github.com/amatsuda/kaminari/…
gem 'kaminari'
#Gem - Bootstrap 4 styling for Kaminari gem
gem 'bootstrap4-kaminari-views'
#Translations for the kaminari gem
gem 'kaminari-i18n'
#Bundler-like DSL + rake tasks for Bower on Rails
gem "bower-rails", "~> 0.11.0"


# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Repository for collecting Locale data for Ruby on Rails I18n as well as other interesting, Rails related I18n stuff http://rails-i18n.org
gem 'rails-i18n', '~> 4.0'

gem "paperclip", "~> 5.0.0"

# Cron jobs in Ruby
gem 'whenever', require: false

gem 'bootsnap', require: false
# Easy full stack backup operations on UNIX-like systems. http://backup.github.io/backup/v4/
# gem 'backup'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  # RSpec for Rails-3+ http://relishapp.com/rspec/rspec-rails
  gem 'rspec-rails', '~> 3.8'
  # This gem implements the rspec command for Spring.
  gem 'spring-commands-rspec'
  # Acceptance test framework for web applications http://teamcapybara.github.io/capybara/k
  gem 'capybara'
  # Factory Bot ♥ Rails https://thoughtbot.com/services/ruby-…
  gem 'factory_bot_rails'
  # A library for generating fake data such as names, addresses, and phone numbers.
  gem 'faker', '~> 2.0.0'
  # Simple one-liner tests for common Rails functionality https://matchers.shoulda.io
  gem 'shoulda-matchers'
end

group :test do
  # Strategies for cleaning databases in Ruby. Can be used to ensure a clean state for testing. http://databasecleaner.github.io
  gem 'database_cleaner'
  gem 'selenium-webdriver'
  gem 'webdrivers', '~> 4.0'
  gem 'puma'
  gem 'chromedriver-helper' #only headless
  gem 'listen'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end
