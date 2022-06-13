source 'http://rubygems.org'
ruby "3.1.3"

gem 'rails', '~> 6.1.6'
gem 'haml', '~> 5.2'
gem 'devise', '~> 4.4'
gem 'cancancan', '~> 3.0'
gem 'will_paginate', '~> 3.0'
gem 'alphabetical_paginate', '~> 2.1.0'
gem 'kt-paperclip', '~> 7'
gem 'exifr', '~> 1.1.3'
gem 'mail_form'
gem 'chronic_duration', '~> 0.9.6'
gem 'math_engine', '~> 0.6.4'
gem 'client_side_validations', '~> 20.0'
gem 'redcarpet', '~> 3.5.1'
gem 'rakismet', '~> 1.4.0'
gem 'memcache-client', '~> 1.8.5'
gem 'calendar_helper', '~> 0.2.6'
gem 'google-api-client', '~> 0.53.0'
gem 'selectize-rails', '~> 0.8.5'
gem 'twitter-typeahead-rails', '~> 0.10.2'
gem 'bootstrap-sass'
gem 'execjs', '~> 2.0.2'
gem 'paper_trail', '~> 11.0'
gem 'momentjs-rails', '>= 2.9.0'
gem 'bootstrap3-datetimepicker-rails', '~> 4.7.14'
gem 'cookies_eu'
gem 'prawn-rails'
gem 'pg', '~> 1.2.3'
gem "recaptcha"
gem 'icalendar', '~> 2.0'
gem 'passenger', '~> 6.0'
gem 'rack-cors'
gem 'webpacker'
gem 'react-rails'
gem 'devise_token_auth'
gem 'omniauth'
gem 'mimemagic'
# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false
# High-level image processing helpers using libvips (faster than ImageMagick).
gem "image_processing", "~> 1.0"

# Gems used only for assets

gem 'sqlite3', '~> 1.3.6'


group :production do
  gem 'daemons', '~> 1.1.9'
  gem 'newrelic_rpm'
end

group :development do
  gem 'annotate'
  gem 'populator'
  gem 'faker'
  gem 'guard'
  gem 'rb-fsevent'
  gem 'guard-rspec'
  gem 'rubocop' , require: false
end

group :test, :development do
  gem "rspec-rails"
  gem 'test-unit'
  gem "capybara"
  gem 'factory_bot_rails', '~> 4.0'
  gem 'rake'
end

gem "codeclimate-test-reporter", group: :test, require: nil
