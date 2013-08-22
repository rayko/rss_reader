require 'simplecov'
SimpleCov.start

# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)

require 'rspec/rails'
# require 'capybara/rails'
# require 'capybara/dsl'
# require 'steak'
require 'factory_girl_rails'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/helpers/ and its subdirectories.
Dir[Rails.root.join("spec/helpers/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  config.mock_with :rspec

  config.use_instantiated_fixtures = false

  config.use_transactional_fixtures = true

  config.include FactoryGirl::Syntax::Methods
  # config.include(Capybara, :type => :integration)

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  config.use_transactional_examples = false
end
