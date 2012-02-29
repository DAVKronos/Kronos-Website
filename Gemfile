source 'http://rubygems.org'

gem 'rails', '3.2.1'
gem 'haml', '3.1.4'
gem 'authlogic'
gem 'acl9'
gem 'pg'
gem 'will_paginate', '3.0.0'
gem "paperclip", "~> 2.7.0"
gem 'gdata'
gem 'delayed_job'
gem 'delayed_job_active_record'
gem 'jquery-rails'
gem "nested_form", "~> 0.2.0"

# For development under Linux you also need to install
# an javascript runtime
platform :ruby do
    gem 'execjs'
    gem 'therubyracer'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', "  ~> 3.2.3"
  gem 'coffee-rails', "~> 3.2.1"
  gem 'uglifier', ">= 1.0.3"
end

group :test do
  gem 'rspec-rails', '2.8.1'
  gem 'webrat', '0.7.3'
  gem 'spork', '0.9.0'
  gem 'factory_girl_rails', '1.2.0'
  gem 'ZenTest', '4.6.2'
  if RUBY_PLATFORM =~ /darwin/
    gem 'autotest-growl', '~> 0.2.16'
    gem 'autotest-fsevent', '~> 0.2.8'
  end
end

group :development do
  gem 'annotate', '2.4.0'
  gem 'populator'
  gem 'faker'
end
