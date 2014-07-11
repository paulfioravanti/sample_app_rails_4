source 'https://rubygems.org'
ruby File.read('.ruby-version')

# Edge Rails: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.4'
# Postgres as database for Active Record
gem 'pg', '0.17.1'
# Use SCSS for stylesheets
gem 'sass-rails', '4.0.3'
# Twitter frameworks to make nice UI design elements
gem 'bootstrap-sass', '2.3.2.2'
# will_paginate pagination for Bootstrap
gem 'bootstrap-will_paginate', '0.0.10'
# Font Awesome icons
gem 'font-awesome-sass-rails', '3.0.2.2'
# Simplified forms
gem 'simple_form', '3.0.2'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '2.5.1'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '4.0.1'
# Use jquery as the JavaScript library
gem 'jquery-rails', '3.1.1'
# Speed up application links
gem 'turbolinks', '2.2.2'
# Get javascript that binds on jQuery.ready() working with Turbolinks
# gem 'jquery-turbolinks', '1.0.0'
# Build JSON APIs with ease
gem 'jbuilder', '2.1.2'
# Use ActiveModel has_secure_password
gem 'bcrypt', '3.1.7', require: false
# App secret key configuration
gem 'figaro', '0.7.0'
# Substiture ERb for Haml
gem 'haml-rails', '0.5.3'
# Use of Markdown for static content in views
gem 'rdiscount', '2.1.7.1'
# For JQuery timeago library
## Not currently working with Rails 4, revert to timeago_in_words
# gem 'rails-timeago', '2.3.0'
# For accessing i18n in js files
gem 'i18n-js', '2.1.2'
# i18n strings for default Rails
gem 'rails-i18n', '4.0.2'
# For fake example users with “realistic” names/emails
gem 'faker', '1.4.1'
# i18n for database content
gem 'globalize', '4.0.2'
# Switch away from WEBrick
gem 'unicorn', '4.8.3'
# Use to find missing/unused translations
gem 'i18n-tasks', '0.5.4'
# Error tracking
gem 'rollbar', '0.13.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', '0.4.0', require: false
end

group :development do
  # for annotating model files with their properties
  gem 'annotate', '2.6.5'
  # Security checking
  gem 'brakeman', '2.6.1'
  # Code quality
  gem 'reek', '1.3.8'
  gem 'rails_best_practices', '1.15.4'
  # Query optimization monitoring
  gem 'bullet', '4.11.3'
  # Debugging information
  gem 'rails-footnotes', '4.0.2'
  # Better error pages
  gem 'better_errors', '1.1.0'
  gem 'binding_of_caller', '0.7.2'
  # Gem for RailsPanel Chrome extension
  gem 'meta_request', '0.3.3'
  # Find unused routes and unreachable methods
  gem 'traceroute', '0.4.0'
end

group :development, :test do
  gem 'rspec-rails', '3.0.1'
  # for autotesting with rspec
  gem 'guard-rspec', '4.2.10'
  # Prettier RSpec output
  gem 'fuubar', '1.3.3'
  gem 'rspec-legacy_formatters' # until Foobar updates
end

group :test do
  # Helps in testing by simulating how a real user would use app
  gem 'capybara', '2.4.1'
  # Use factories instead of ActiveRecord objects
  gem 'factory_girl_rails', '4.4.1'
  # English-like matchers for unit-testing
  gem 'shoulda-matchers', '2.6.1'
  gem 'database_cleaner', '1.3.0'
  # Speed up test server
  gem 'spork-rails', '4.0.0'
  # guard/spork integration
  gem 'guard-spork', '1.5.1'
  # Helps in debugging tests by being able to launch browser
  gem 'launchy', '2.4.2'
  # Mac-dependent gems for Guard notifications
  gem 'rb-fsevent', '0.9.4', require: false
  gem 'growl', '1.0.3'
  # Code coverage reports
  gem 'simplecov', '0.8.2', require: false
  gem 'coveralls', '0.7.0', require: false
end

group :production do
  # Serve assets in production and set logger to standard out on Heroku
  gem 'rails_12factor', '0.0.2'
end