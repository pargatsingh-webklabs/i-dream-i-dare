 source "https://rubygems.org"

ruby "2.5.1"

gem 'rubyzip'
gem 'trix'
gem 'aws-sdk', '~> 3'
gem 'heroku-postgres'
gem 'bootstrap-sass', '~> 3.3.6'
gem 'devise'
gem "autoprefixer-rails"
gem "delayed_job_active_record"
gem "flutie"
gem "high_voltage"
gem "honeybadger"
gem "jquery-rails"
gem "newrelic_rpm", ">= 3.9.8"
gem 'pg', '~> 0.21'
gem "puma"
gem "rack-canonical-host"
gem "rails", "~> 4.2.0"
gem "recipient_interceptor"
gem "sass-rails", "~> 5.0"
gem 'compass-rails'
gem "sprockets", ">= 3.0.0"
gem "sprockets-es6"
gem "title"
gem "uglifier"
gem "twilio-ruby"
gem 'active_model_serializers', '~> 0.10.0'
gem "sendgrid-ruby"
gem "ngrok"
gem 'shrine'
gem 'figaro'
gem 'omniauth'
gem 'omniauth-facebook'

group :development do
  gem "quiet_assets"
  gem "spring"
  gem "spring-commands-rspec"
  gem "web-console"
end

group :development, :test do
  gem "awesome_print"
  gem "bullet"
  gem "bundler-audit", ">= 0.5.0", require: false
  gem "dotenv-rails"
  gem "factory_girl_rails", require: false
  gem "pry-byebug"
  gem "pry-rails"
  gem "rspec-rails", "~> 3.4.0"
  gem 'foreman'
end

group :development, :staging do
  gem "rack-mini-profiler", require: false
end

group :test do
  gem "database_cleaner"
  gem "formulaic"
  gem "launchy"
  gem "shoulda-matchers"
  gem "simplecov", require: false
  gem "timecop"
  gem "webmock"
end

group :staging, :production do
  gem "rails_stdout_logging"
  gem "rack-timeout"
  gem "rails_12factor"
end
