source 'https://rubygems.org'
ruby '2.0.0'

# Edge Rails: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.0.rc2'
# Postgres as database for Active Record
gem 'pg', '0.15.1'
# Use SCSS for stylesheets
gem 'sass-rails', '4.0.0.rc2'
# Twitter frameworks to make nice UI design elements
gem 'bootstrap-sass', '2.3.2.0'
# will_paginate pagination for Bootstrap
gem 'bootstrap-will_paginate', '0.0.9'
# Font Awesome icons
gem 'font-awesome-sass-rails', '3.0.2.2'
# Simplified forms
# gem 'simple_form', '2.1.0'
gem 'simple_form', github: 'plataformatec/simple_form'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '2.1.1'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '4.0.0'
# Use jquery as the JavaScript library
gem 'jquery-rails', '3.0.1'
# Speed up application links
gem 'turbolinks', '1.2.0'
# Get javascript that binds on jQuery.ready() working with Turbolinks
# gem 'jquery-turbolinks', '1.0.0'
# Build JSON APIs with ease
gem 'jbuilder', '1.4.2'
# Use ActiveModel has_secure_password
gem 'bcrypt-ruby', '3.0.1'
# App secret key configuration
gem 'figaro', '0.6.4'
# Substiture ERb for Haml
gem 'haml-rails', '0.4.0'
# Use of Markdown for static content in views
gem 'rdiscount', '2.1.6'
# For JQuery timeago library
## Not currently working with Rails 4, revert to timeago_in_words
# gem 'rails-timeago', '2.3.0'
# For accessing i18n in js files
gem 'i18n-js', '2.1.2'
# i18n strings for default Rails
gem 'rails-i18n', '0.7.3'
# For fake example users with “realistic” names/emails
gem 'faker', '1.1.2'
# i18n for database content
# gem 'globalize3', '0.3.0'
gem 'globalize3', github: 'svenfuchs/globalize3', branch: 'rails4'
# Override globalize dependency that has a dependency on Rails 3
gem 'paper_trail', github: 'airblade/paper_trail', branch: 'rails4'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', '0.3.20', require: false
end

group :development do
  # for annotating model files with their properties
  gem 'annotate', '2.5.0'
  # Security checking
  gem 'brakeman', '2.0.0'
  # Code quality
  gem 'reek', '1.3.1'
  gem 'rails_best_practices', '1.13.8'
  # Query optimization monitoring
  gem 'bullet', '4.6.0'
  # Debugging information
  gem 'rails-footnotes', '3.7.9'
  # Better error pages
  gem 'better_errors', '0.9.0'
  gem 'binding_of_caller', '0.7.2'
  # Gem for RailsPanel Chrome extension
  gem 'meta_request', '0.2.7'
end

group :development, :test do
  gem 'rspec-rails', '2.13.2'
  # for autotesting with rspec
  gem 'guard-rspec', '3.0.2'
  # Prettier RSpec output
  gem 'fuubar', '1.1.1'
end

group :test do
  # Helps in testing by simulating how a real user would use app
  gem 'capybara', '2.1.0'
  # Use factories instead of ActiveRecord objects
  gem 'factory_girl_rails', '4.2.1'
  # English-like matchers for unit-testing
  gem 'shoulda-matchers', '2.2.0'
  gem 'database_cleaner', github: 'bmabey/database_cleaner'
  # Speed up test server
  gem 'spork-rails', github: 'railstutorial/spork-rails'
  # guard/spork integration
  gem 'guard-spork', '1.5.1'
  # Helps in debugging tests by being able to launch browser
  gem 'launchy', '2.3.0'
  # Mac-dependent gems for Guard notifications
  gem 'rb-fsevent', '0.9.3', require: false
  gem 'growl', '1.0.3'
  # Code coverage reports
  gem 'simplecov', '0.7.1', require: false
  gem 'coveralls', '0.6.7', require: false
end