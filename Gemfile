source "https://rubygems.org"

ruby "2.4.0"

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
gem "pg"
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
# --------------------------
  # gem "quiet_assets"
  # gem "spring"
  # gem "spring-commands-rspec"
  # gem "web-console"
  # gem "awesome_print"
  # gem "bullet"
  # gem "bundler-audit", ">= 0.5.0", require: false
  # gem "dotenv-rails"
  # gem "factory_girl_rails", require: false
  # gem "pry-byebug"
  # gem "pry-rails"
  # gem "rspec-rails", "~> 3.4.0"
  # gem "rack-mini-profiler", require: false
  # gem "database_cleaner"
  # gem "formulaic"
  # gem "launchy"
  # gem "shoulda-matchers"
  # gem "simplecov", require: false
  # gem "timecop"
  # gem "webmock"
  # gem "rails_stdout_logging"
  # gem "rack-timeout"
  # gem "rails_12factor"
  #----------------------------------

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
