Devise.setup do |config|
  config.secret_key = ENV['devise_secret_key']
  config.mailer_sender = 'no_reply@staffportal.org'
  require 'devise/orm/active_record'
  config.case_insensitive_keys = [:email]
  config.strip_whitespace_keys = [:email]
  config.skip_session_storage = [:http_auth]
  config.sign_out_via = :delete
  config.cas_base_url = 'https://thekey.me/cas/'
end
