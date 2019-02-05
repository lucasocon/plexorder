source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.3'

gem 'rails', '~> 5.2.2'
gem 'pg', '1.1.3'
gem 'puma', '~> 3.11'

gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'

# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

gem 'jbuilder'
gem 'turbolinks'

#JQuery
gem 'jquery-rails', '4.3.3'

# Authentication
gem 'devise', '4.5.0'

# Adding Autocomplete Search
gem 'select2-rails', '4.0.3'
gem 'underscore-rails', '1.8.3'

# Cron ActiveJobs
gem 'sidekiq-scheduler', '3.0.0'

# Bootstrap
gem 'bootstrap-sass', '3.3.7'

gem 'http'
gem 'parallel'
gem 'bootsnap', '>= 1.1.0', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  gem 'factory_bot_rails'
  gem 'rspec-rails', '~> 3.8'
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'chromedriver-helper'
  gem 'database_cleaner'
  gem 'faker'
  gem 'shoulda-matchers'
  gem 'rails-controller-testing'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'yard'
end
