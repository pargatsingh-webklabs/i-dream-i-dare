SMTP_SETTINGS = {

  # PREVIOUS SETTINGS:

  # address: ENV.fetch("SMTP_ADDRESS"), # example: "smtp.sendgrid.net"
  # authentication: :plain,
  # domain: ENV.fetch("SMTP_DOMAIN"), # example: "heroku.com"
  # enable_starttls_auto: true,
  # password: ENV.fetch("SMTP_PASSWORD"),
  # port: "587",
  # user_name: ENV.fetch("SMTP_USERNAME")

  # ////////////////////////////////

  
  address: "smtp.sendgrid.net",
  # example: "smtp.sendgrid.net"
  authentication: :plain,
  domain: "heroku.com", 
  # example: "heroku.com"
  enable_starttls_auto: true,
  password: "password",
  port: "587",
  user_name: "username"
  
}
