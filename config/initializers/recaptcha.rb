Recaptcha.configure do |config|
  config.public_key  = Settings.recaptcha_public_key
  config.private_key = Settings.recaptcha_private_key
end