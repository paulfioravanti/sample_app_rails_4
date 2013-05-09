require 'rubygems'
require 'spork'

# Only run Simplecov when not using Spork
# Stop it and run rspec to get coverage
unless ENV['DRB']
  require 'simplecov'
  SimpleCov.start 'rails'
end
if ENV['TRAVIS']
  require 'coveralls'
  Coveralls.wear! 'rails'
end

Spork.prefork do
  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'
  require 'rspec/autorun'
  # require 'capybara/rails'
  # require 'capybara/rspec'

  # Requires supporting ruby files with custom matchers and macros, etc,
  # in spec/support/ and its subdirectories.
  Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

  # Checks for pending migrations before tests are run.
  # If you are not using ActiveRecord, you can remove this line.
  ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

  RSpec.configure do |config|
    # If you're not using ActiveRecord, or you'd prefer not to run each of your
    # examples within a transaction, remove the following line or assign false
    # instead of true.
    config.use_transactional_fixtures = true

    # If true, the base class of anonymous controllers will be inferred
    # automatically. This will be the default behavior in future versions of
    # rspec-rails.
    config.infer_base_class_for_anonymous_controllers = false

    # Run specs in random order to surface order dependencies. If you find an
    # order dependency and want to debug it, you can fix the order by providing
    # the seed, which is printed after each run.
    #     --seed 1234
    # config.order = "random" # turned off due to issues with locales

    # config.include Capybara::DSL

    # config.include FactoryGirl::Syntax::Methods

    # config.expect_with :rspec do |c|
    #   c.syntax = :expect
    # end
  end
end

Spork.each_run do
  # Allow the following changes to be reflected without restarting Spork:
  # i18n strings
  I18n.backend.reload!
  # spec/support files
  Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }
  # Factories
  # FactoryGirl.reload
end