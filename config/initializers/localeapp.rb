require 'localeapp/rails'

Localeapp.configure do |config|
  config.api_key = Settings.localeapp_api_key
end

