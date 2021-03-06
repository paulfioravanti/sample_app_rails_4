# Ruby on Rails Tutorial: sample application
[![Build Status](https://secure.travis-ci.org/paulfioravanti/sample_app_rails_4.png)](http://travis-ci.org/paulfioravanti/sample_app_rails_4) [![Dependency Status](https://gemnasium.com/paulfioravanti/sample_app_rails_4.png)](https://gemnasium.com/paulfioravanti/sample_app_rails_4) [![Code Climate](https://codeclimate.com/github/paulfioravanti/sample_app_rails_4.png)](https://codeclimate.com/github/paulfioravanti/sample_app_rails_4) [![Coverage Status](https://coveralls.io/repos/paulfioravanti/sample_app_rails_4/badge.png?branch=master)](https://coveralls.io/r/paulfioravanti/sample_app_rails_4?branch=master) [![Security Status](http://rails-brakeman.com/paulfioravanti/sample_app_rails_4.png)](http://rails-brakeman.com/paulfioravanti/sample_app_rails_4)

This is the Rails 4 version of sample application for the 
[*Ruby on Rails Tutorial: Learn Rails by Example*](http://railstutorial.org/)
by [Michael Hartl](http://michaelhartl.com) (plus some [modifications](#modifications)).

([Rails 3.2 version here](https://github.com/paulfioravanti/sample_app))

- This code is currently deployed [here](https://pf-sampleapp-rails4.herokuapp.com) using [Heroku](http://www.heroku.com/)

### Cloning Locally

    $ cd /tmp
    $ git clone git@github.com:paulfioravanti/sample_app_rails_4.git
    $ cd sample_app_rails_4
    $ bundle install

### Environment Configuration

**Secret information configuration**

    $ cp config/application.example.yml config/application.yml

Generate a secret key:

    $ rake secret

Copy the resulting string into the `SK` entry in **config/application.yml**, along with your database information for all environments:

    # App keys
    SK: # your rake secret generated token

    development:
      DB_NAME_DEV: # your dev db name here
      DB_USER_DEV: # your dev db username here
      DB_PASSWORD_DEV: # your dev db password here

    test:
      DB_NAME_TEST: # your test db name here
      DB_USER_TEST: # your test db username here
      DB_PASSWORD_TEST: # your test db password here

    production:
      DB_NAME_PROD: # your prod db name here
      DB_USER_PROD: # your prod db username here
      DB_PASSWORD_PROD: # your prod db password here

    HEROKU_API_KEY: # your Heroku api key here
    HEROKU_APP_NAME: # your Heroku app name here
    ROLLBAR_ACCESS_TOKEN: # your Rollbar access token here

Note: `rake secret` generates a key of 128 characters.  Use 114 of those characters if you want to use the `secret_key_base` as a secure config variable in your Travis build.

**Deploying with Heroku**

After creating the Heroku repo, generate production environment variables automatically using [Figaro](https://github.com/laserlemon/figaro):

    $ rake figaro:heroku RAILS_ENV=production

Or, do it manually:

    $ heroku config:set SK={{YOUR_SECRET_KEY_BASE}}
    $ heroku config:set DB_NAME={{YOUR_DB_NAME_UNDER_PRODUCTION}} # eg: my_app_production
    $ heroku config:set DB_USER={{YOUR_DB_USER}}
    $ heroku config:set DB_PASSWORD={{YOUR_DB_PASSWORD}}

Let Heroku compile assets to avoid doing it locally (optional, as [the functionality is experimental](https://devcenter.heroku.com/articles/labs-user-env-compile)):

    $ heroku labs:enable user-env-compile -a {{YOUR_HEROKU_APP_NAME}}
    # May not need this if compiling Heroku slug on Travis...

**Continuous Integration/Deployment with Travis CI**

If you're using Travis for continuous integration testing, do the following (without the `{{ }}`):

Create encrypted travis variables for your Heroku API key and Repo name:

    $ gem install travis
    $ travis encrypt SK={{YOUR_SECRET_KEY_BASE_OF_114_CHARS_OR_LESS}} --add
    $ travis encrypt DB_NAME={{YOUR_DB_NAME_TEST}} --add # eg: my_app_test
    $ travis encrypt DB_USER={{YOUR_DB_USER_TEST}} --add
    $ travis encrypt DB_PASSWORD={{YOUR_DB_PASSWORD_TEST}} --add
    $ travis encrypt DB_NAME={{YOUR_DB_NAME_PROD}} --add # eg: my_app_test
    $ travis encrypt DB_USER={{YOUR_DB_USER_PROD}} --add
    $ travis encrypt DB_PASSWORD={{YOUR_DB_PASSWORD_PROD}} --add
    $ travis encrypt HEROKU_API_KEY={{YOUR_HEROKU_API_KEY}} --add
    $ travis encrypt HEROKU_APP_NAME={{YOUR_HEROKU_APP_NAME}} --add # eg my_app
    $ travis encrypt ROLLBAR_ACCESS_TOKEN={{YOUR_ROLLBAR_ACCESS_TOKEN}} --add

Or, without the `--add` flag, you can add them manually to **.travis.yml**

    env:
      global:
      - secure: {{YOUR_ENCRYPTED_SECRET_KEY_BASE_OF_114_CHARS_OR_LESS}}
      - secure: {{YOUR_ENCRYPTED_DB_NAME_TEST}}
      - secure: {{YOUR_ENCRYPTED_DB_USER_TEST}}
      - secure: {{YOUR_ENCRYPTED_DB_PASSWORD_TEST}}
      - secure: {{YOUR_ENCRYPTED_DB_NAME_PROD}}
      - secure: {{YOUR_ENCRYPTED_DB_USER_PROD}}
      - secure: {{YOUR_ENCRYPTED_DB_PASSWORD_PROD}}
      - secure: {{YOUR_ENCRYPTED_HEROKU_API_KEY}}
      - secure: {{YOUR_ENCRYPTED_HEROKU_APP_NAME}}
      - secure: {{YOUR_ROLLBAR_ACCESS_TOKEN}}


Finally, configure the databases:

    $ bundle exec rake db:migrate
    $ bundle exec rake db:seed
    $ bundle exec rake db:test:prepare RAILS_ENV=test

- - -

## Issues

I haven't yet been able to get the following functionality that worked in Rails 3 to work in Rails 4:

- Micropost character countdown based on Twitter's
- The endless scroll to pages with paginated lists of users or microposts, as shown in [Railscast #114 Endless Page (revised)](http://railscasts.com/episodes/114-endless-page-revised)
- It seems [rails-timeago](https://github.com/jgraichen/rails-timeago) currently is not compatible with Rails 4, so time calculation for microposts have reverted back to the default `time_ago_in_words`

## Modifications:

### User Interface
- Added [Font Awesome](http://fortawesome.github.com/Font-Awesome/) icons to the header

### i18n
- Added locale switcher
- Internationalized app labels with translations for Japanese and Italian
- All static content internationalized in [Markdown](http://daringfireball.net/projects/markdown/) files instead of HTML/ERb files
- Added i18n-specific routing
- Added translations to dynamic data and its relevant sample data (microposts) using [Globalize3](https://github.com/svenfuchs/globalize3)

### Backend
- Moved development database over to [Postgresql](http://www.postgresql.org/) to match deployment database on Heroku.
- Changed all views from HTML/ERb to [Haml](http://haml-lang.com/)
- Refactored [SCSS](http://sass-lang.com/) files to use more mix-ins, as well as additions to add styling to the language selector
- Simplified implementation of most forms with [SimpleForm](https://github.com/plataformatec/simple_form)
- Used [Figaro](https://github.com/laserlemon/figaro) to handle all secret keys in an attempt to remove any app-identifiable information from all environments.  Reasons why at [this StackOverflow thread](http://stackoverflow.com/q/14785257/567863)

### Testing/Debugging
- Completely re-wrote test suite to use `expect` syntax exclusively due to [plans to depreciate `should` syntax](http://myronmars.to/n/dev-blog/2012/06/rspecs-new-expectation-syntax), as well as write feature tests in (hopefully) a more user-friendly way.
- Internationalized [RSpec](http://rspec.info/) tests and further refactored them
- Refactored model specs to use [shoulda-matchers](https://github.com/thoughtbot/shoulda-matchers)
- Changed RSpec output to show a progress bar instead of dots using [Fuubar](https://github.com/jeffkreeftmeijer/fuubar)
- Swapped out the debug block in the footer for [rails-footnotes](https://github.com/josevalim/rails-footnotes)
- Added tests for [Globalize3](https://github.com/svenfuchs/globalize3) translations and expanded factories to include a micropost with its relevant translations

### Reporting/Optimizing
- Used [SimpleCov](https://github.com/colszowka/simplecov) to ensure as much test coverage as possible.
- Used [Bullet](https://github.com/flyerhzm/bullet) to optimize queries

### Other
- Travis can only encrypt a string of total length of 117 characters, including the name of the variable, which is less than the 128 character string that `rake secret` generates.  It's convenient to be able to pass the `secret_key_base` directly to Travis and have Travis use it to compile a Heroku slug to deploy, but I'm uncertain as to realistically how much less secure a 114 character key (SK={KEY}) is versus a 128 character key

## Social

<a href="http://stackoverflow.com/users/567863/paul-fioravanti">
  <img src="http://stackoverflow.com/users/flair/567863.png" width="208" height="58" alt="profile for Paul Fioravanti at Stack Overflow, Q&amp;A for professional and enthusiast programmers" title="profile for Paul Fioravanti at Stack Overflow, Q&amp;A for professional and enthusiast programmers">
</a>

[![endorse](http://api.coderwall.com/pfioravanti/endorsecount.png)](http://coderwall.com/pfioravanti)

[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/paulfioravanti/sample_app_rails_4/trend.png)](https://bitdeli.com/free "Bitdeli Badge")

