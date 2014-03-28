source 'http://rubygems.org'

gem 'rails', '~> 3.2.8'
gem 'haml', '~> 3.1'
gem 'devise', '~> 3.1.0'
gem 'cancan', '~> 1.6.10'
gem 'will_paginate', '~> 3.0.3'
gem 'alphabetical_paginate', '~> 2.1.0'
gem 'paperclip', '~> 3.2'
gem 'gdata_19', '~> 1.1.5'
gem 'delayed_job', '~> 4.0.0'
gem 'delayed_job_active_record', '~> 4.0.0'
gem 'jquery-rails', '~> 2.1.0'
gem 'nested_form', '~> 0.3.2'
gem "settingslogic", '~> 2.0.8'
gem "bootstrap-will_paginate", '~> 0.0.6'
gem "chronic_duration", '~> 0.9.6'
gem 'math_engine', '~> 0.3.0', :git => 'git://github.com/dmarczal/math_engine.git'
gem 'client_side_validations', '~> 3.2.0.beta.6'
gem 'localeapp', '~> 0.6.12'
gem 'redcarpet', '~> 2.3.0'
gem 'rakismet', '~> 1.4.0'
gem 'wicked_pdf', '~> 0.9.7'
gem 'auto_html', '~> 1.6.0'
gem 'memcache-client', '~> 1.8.5'
gem 'calendar_helper', '~> 0.2.6'
gem 'el_finder', '~> 1.1.10'
gem 'google-api-client', '~> 0.6.4'
gem 'selectize-rails', '~> 0.8.5' 
gem 'thin'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', '~> 3.2.5'
  gem 'coffee-rails', '~> 3.2.2'
  gem 'uglifier', '>= 1.2.7'
	
	# For development under Linux you also need to install
	# an javascript runtime
	platform :ruby do
		gem 'execjs', '~> 2.0.2'
		gem 'therubyracer', '~> 0.12.0'
	end
end

group :production do
  gem 'daemons', '~> 1.1.9'
  gem 'pg', '~> 0.17.0'
	platform :ruby do
		gem 'unicorn', '~> 4.6.3'
	end
end

group :test do
  gem "capybara", "~> 1.1"
  gem 'factory_girl_rails', '~> 4.0.0'
	gem 'rake', '~> 10.1.0'
  gem 'pg', '~> 0.17.0'
end

group :development do
  gem 'annotate', '~> 2.5.0'
  gem 'populator', '~> 1.0.0'
  gem 'faker', '~> 1.2.0'
	gem 'guard', '~> 1.8.3'
	gem 'spork', '~> 1.0.0.rc3'
	gem 'rb-fsevent', '~> 0.9.1'
	gem 'guard-rspec', '~> 2.5.4'
	gem 'guard-spork', '~> 1.5.1'
  gem 'sqlite3', '~> 1.3.8'
	if RUBY_PLATFORM =~ /darwin/
		gem 'terminal-notifier-guard'
	end
end

group :test, :development do
  gem "rspec-rails", "~> 2.11.0"
end
