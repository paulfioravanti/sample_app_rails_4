# Only run Simplecov when not using Spork
# To get coverage, stop spork and run rspec
unless ENV['DRB']
  SimpleCov.start 'rails'
end
if ENV['TRAVIS']
  Coveralls.noisy = false
  require 'coveralls'
  Coveralls.wear! 'rails'
end