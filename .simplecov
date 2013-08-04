# Only run Simplecov when not using Spork
# To get coverage, stop spork and run rspec
unless ENV['DRB']
  SimpleCov.start 'rails'
end
if ENV['TRAVIS']
  require 'coveralls'

  # Silence Coverall's chatty output
  module Coveralls
    def puts(string) ; nil ; end
  end

  Coveralls.wear! 'rails'
end