require 'simplecov'
require 'rubygems'
require 'spork'

Spork.prefork do
  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'

  # Checks for pending migrations before tests are run.
  # If you are not using ActiveRecord, you can remove this line.
  ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)
  ActiveRecord::Migration.maintain_test_schema!

  Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

  RSpec.configure do |config|
    # If you're not using ActiveRecord, or you'd prefer not to run each of your
    # examples within a transaction, remove the following line or assign false
    # instead of true.
    config.use_transactional_fixtures = true

    # If true, the base class of anonymous controllers will be inferred
    # automatically. This will be the default behavior in future versions of
    # rspec-rails.
    config.infer_base_class_for_anonymous_controllers = false
    config.infer_spec_type_from_file_location!

    # Run specs in random order to surface order dependencies. If you find an
    # order dependency and want to debug it, you can fix the order by providing
    # the seed, which is printed after each run.
    #     --seed 1234
    # config.order = "random" # turned off due to occasional issues with locales

    config.include FactoryGirl::Syntax::Methods
    config.include CustomMatchers

    config.expect_with :rspec do |c|
      c.syntax = :expect
    end

    config.before :suite do
      DatabaseCleaner.strategy = :transaction
      DatabaseCleaner.clean_with(:truncation)
    end

    config.before do
      DatabaseCleaner.start
    end

    config.after do
      DatabaseCleaner.clean
    end
  end
end

Spork.each_run do
  # Requires supporting ruby files with custom matchers and macros, etc,
  # in spec/support/ and its subdirectories.
  Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }
  # Allow the following changes to be reflected without restarting Spork:
  # i18n strings
  I18n.backend.reload!
  # Factories
  FactoryGirl.reload
end