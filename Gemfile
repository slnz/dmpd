source 'https://rubygems.org'

ruby '2.1.2'

gem 'airbrake'
gem 'bourbon', '~> 3.2.1'
gem 'coffee-rails'
gem 'delayed_job_active_record'
gem 'email_validator'
gem 'flutie'
gem 'high_voltage'
gem 'i18n-tasks'
gem 'jquery-rails'
gem 'neat', '~> 1.5.1'
gem 'normalize-rails', '~> 3.0.0'
gem 'pg'
gem 'rack-timeout'
gem 'rails', '4.1.6'
gem 'recipient_interceptor'
gem 'sass-rails', '~> 4.0.3'
gem 'simple_form'
gem 'title'
gem 'uglifier'
gem 'puma'
gem 'bootstrap-sass'
gem 'font-awesome-sass'
gem 'autoprefixer-rails'
gem 'draper'

group :development do
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'guard'
  gem 'guard-rspec', require: false
  gem 'guard-rubocop'
  gem 'guard-rails'
  gem 'guard-bundler'
  gem 'guard-puma'
  gem 'rb-fsevent', require: false
  gem 'better_errors'
  gem 'binding_of_caller'
end

group :development, :test do
  gem 'awesome_print'
  gem 'byebug'
  gem 'pry-byebug'
  gem 'dotenv-rails'
  gem 'factory_girl_rails'
  gem 'pry-rails'
  gem 'rspec-rails', '~> 3.0.0'
  gem 'assert_difference'
  gem 'fuubar'
  gem 'rubocop'
end

group :test do
  gem 'capybara-webkit', '>= 1.2.0'
  gem 'database_cleaner'
  gem 'formulaic'
  gem 'launchy'
  gem 'shoulda-matchers', require: false
  gem 'codeclimate-test-reporter', require: nil
  gem 'simplecov'
  gem 'timecop'
  gem 'webmock'
  gem 'vcr'
end

group :staging, :production do
  gem 'rails_12factor'
  gem 'newrelic_rpm', '>= 3.7.3'
end
