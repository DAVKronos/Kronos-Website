source 'http://rubygems.org'

gem 'rails', '~> 3.2.8'
gem 'haml', '~> 3.1'
gem 'devise'
gem 'cancan'
gem 'will_paginate', '~> 3.0.3'
gem 'paperclip', '~> 3.2'
gem 'gdata_19'
gem 'delayed_job'
gem 'delayed_job_active_record'
gem 'jquery-rails'
gem 'nested_form'
gem "settingslogic", '~> 2.0.8'
gem "bootstrap-will_paginate", '~> 0.0.6'
gem "chronic_duration", '~> 0.9.6'
gem 'math_engine', '~> 0.3.0', :git => 'git://github.com/dmarczal/math_engine.git'
gem 'client_side_validations', '~> 3.2.0.beta.6'
gem 'localeapp'
gem 'redcarpet'
gem 'rakismet'
gem 'wicked_pdf'
gem 'auto_html'
gem 'memcache-client'
gem 'calendar_helper'
gem 'el_finder'
gem 'google-api-client'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', '~> 3.2.5'
  gem 'coffee-rails', '~> 3.2.2'
  gem 'uglifier', '>= 1.2.7'
	
	# For development under Linux you also need to install
	# an javascript runtime
	platform :ruby do
		gem 'execjs'
		gem 'therubyracer'
	end
end

group :production do
  gem 'daemons'
  gem 'pg'
	platform :ruby do
		gem 'unicorn'
	end
end

group :test do
  gem "capybara", "~> 1.1"
  gem 'factory_girl_rails', '~> 4.0.0'
	gem 'rake'
  gem 'pg'
end

group :development do
  gem 'annotate', '~> 2.5.0'
  gem 'populator'
  gem 'faker'
	gem 'guard'
	gem 'spork', '~> 1.0.0.rc3'
	gem 'rb-fsevent', '~> 0.9.1'
	gem 'guard-rspec'
	gem 'guard-spork'
  gem 'sqlite3'
	if RUBY_PLATFORM =~ /darwin/
		gem 'terminal-notifier-guard'
	end
end

group :test, :development do
  gem "rspec-rails", "~> 2.11.0"
end
