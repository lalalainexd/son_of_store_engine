# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
StoreEngine::Application.initialize!

ActionMailer::Base.smtp_settings = {
  address: "smtp.gmail.com",
  port: 587,
  domain: "oregonsale.herokuapp.com",
  authentication: "plain",
  enable_starttls_auto: true,
  user_name: "oregontrailsale@gmail.com",
  password: "dysent4ry"
}
