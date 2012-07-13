source 'http://rubygems.org'

gem 'rails', '3.2.6'
gem 'haml', '3.1.6'
gem 'devise'
gem 'cancan'
gem 'pg'
gem 'will_paginate', '3.0.3'
gem 'paperclip', '~> 3.1.2'
gem 'gdata'
gem 'delayed_job'
gem 'delayed_job_active_record'
gem 'jquery-rails'
gem 'nested_form', :git => 'git://github.com/ryanb/nested_form.git'
gem "settingslogic", "~> 2.0.8"
gem "bootstrap-will_paginate", "~> 0.0.6"
gem "chronic_duration", "~> 0.9.6"
gem 'math_engine', '~> 0.3.0', :git => 'git://github.com/dmarczal/math_engine.git'
gem 'client_side_validations', '3.2.0.beta.4'
gem 'localeapp'
gem 'redcarpet'
gem 'rakismet'
gem 'wicked_pdf'
gem 'auto_html'
gem 'memcache-client'

# For development under Linux you also need to install
# an javascript runtime
platform :ruby do
    gem 'execjs'
    gem 'therubyracer'
    gem 'unicorn'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', '  ~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

group :production do
  gem 'daemons'
end

group :test do
  gem 'rspec-rails', '2.11.0'
  gem 'webrat', '0.7.3'
  gem 'spork', '0.9.2'
  gem 'factory_girl_rails', '3.5.0'
  gem 'ZenTest', '4.8.1'
  if RUBY_PLATFORM =~ /darwin/
    gem 'autotest-growl', '~> 0.2.16'
    gem 'autotest-fsevent', '~> 0.2.8'
  end
end

group :development do
  gem 'annotate', '~> 2.5.0.pre1 '
  gem 'populator'
  gem 'faker'
end
