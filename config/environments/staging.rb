require_relative "production"

Mail.register_interceptor(
  RecipientInterceptor.new(ENV.fetch("EMAIL_RECIPIENTS"))
)
ActiveModelSerializers.config.adapter = :json_api
Rails.application.configure do
  # ...
end

