RssReader::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Log error messages when you accidentally call methods on nil.
  config.whiny_nils = true

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin

  # Do not compress assets
  # config.assets.compress = false

  # Expands the lines which load the assets
  # config.assets.debug = true

  # Default url options for Devise
  config.action_mailer.default_url_options = { :host => 'localhost:3000' }

  # For Mailcatcher
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = { :address => 'localhost', :port => 1025 }

  # Makes posible to test omniauth locally
  # OmniAuth.config.test_mode = true
  # OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new({:provider => 'twitter',
  #                                                                :uid => '123545',
  #                                                                :info => {:nickname => "rayko",
  #                                                                  :name => "Rayko Diarghi"}})
  # OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({:provider => 'google_oauth2',
  #                                                                      :uid => '123545',
  #                                                                      :info => {:first_name => "Rayko",
  #                                                                        :last_name => "Diarghi",
  #                                                                        :email => 'rayko@example.com',
  #                                                                        :name => 'Rayko Diarghi'}})

end
