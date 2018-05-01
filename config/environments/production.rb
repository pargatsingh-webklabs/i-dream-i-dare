Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.
  # FROM Previous Rails version:
  
  # if ENV.fetch("HEROKU_APP_NAME", "").include?("staging-pr-")
  #   ENV["APPLICATION_HOST"] = ENV["HEROKU_APP_NAME"] + ".herokuapp.com" 
  # end
  ActiveModelSerializers.config.adapter = :json_api
  config.middleware.use Rack::CanonicalHost, ENV.fetch("APPLICATION_HOST")
  config.cache_classes = true
  config.eager_load = true
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true
  config.serve_static_files = ENV['RAILS_SERVE_STATIC_FILES'].present?
  config.middleware.use Rack::Deflater
  config.assets.js_compressor = :uglifier
  config.assets.compile = false
  config.assets.digest = true
  config.log_level = :debug
  config.action_mailer.delivery_method = :smtp
  # config.action_mailer.smtp_settings = SMTP_SETTINGS
  config.i18n.fallbacks = true
  config.active_support.deprecation = :notify
  config.log_formatter = ::Logger::Formatter.new
  config.active_record.dump_schema_after_migration = false
  # config.action_mailer.default_url_options = { host: ENV.fetch("APPLICATION_HOST") }

  # -----------
  # config.action_mailer.default_url_options = { :host => 'i-dream-i-dare.herokuapp.com' }
  # Rails.application.routes.default_url_options[:host] = 'i-dream-i-dare.herokuapp.com'
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.perform_deliveries = true
  config.action_mailer.raise_delivery_errors = false
  config.action_mailer.default :charset => "utf-8"

  config.action_mailer.smtp_settings = {
    address: "smtp.gmail.com",
    port: 587,
    domain: ENV["GMAIL_DOMAIN"],
    authentication: "plain",
    enable_starttls_auto: true,
    user_name: ENV["GMAIL_USERNAME"],
    password: ENV["GMAIL_PASSWORD"]
  }
  # ---------------

  Rack::Timeout.timeout = (ENV["RACK_TIMEOUT"] || 10).to_i
end