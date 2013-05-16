# Ruby on Rails Tutorial: sample application

This is the Rails 4 version of sample application for the 
[*Ruby on Rails Tutorial: Learn Rails by Example*](http://railstutorial.org/)
by [Michael Hartl](http://michaelhartl.com) (plus some [modifications](#modifications)).  You can find my Rails 3 version [here](https://github.com/paulfioravanti/sample_app)

### Cloning Locally

    $ cd /tmp
    $ git clone git@github.com:paulfioravanti/sample_app.git
    $ cd sample_app
    $ bundle install

### Environment Configuration

    $ cp config/application.example.yml config/application.yml

**Inside Rails App**

Generate a secret token:

    $ rake secret

Copy the resulting string into the `SECRET_TOKEN` entry in **config/application.yml**, along with your database information:

    # App keys
    SECRET_TOKEN: # your rake secret generated token

    development:
      DB_NAME: # your dev db name here
      DB_USER: # your dev db username here
      DB_PASSWORD: # your dev db password here

    test:
      DB_NAME: # your test db name here
      DB_USER: # your test db username here
      DB_PASSWORD: # your test db password here

    production:
      DB_NAME: # your prod db name here
      DB_USER: # your prod db username here
      DB_PASSWORD: # your prod db password here

- - -

### Issues

The following functionality that worked in Rails 3 currently does not work in Rails 4 due to issues with Turbolinks/jQuery:

- Micropost character countdown based on Twitter's
- The endless scroll to pages with paginated lists of users or microposts, as shown in [Railscast #114 Endless Page (revised)](http://railscasts.com/episodes/114-endless-page-revised)
- It seems [rails-timeago](https://github.com/jgraichen/rails-timeago) currently is not compatible with Rails 4, so time calculation for microposts have reverted back to the default `time_ago_in_words`)


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
- Used [SimpleCov](https://github.com/colszowka/simplecov) to ensure as much test coverage as possible.  Currently at 100%.
- Used [Bullet](https://github.com/flyerhzm/bullet) to optimize queries

## Social

<a href="http://stackoverflow.com/users/567863/paul-fioravanti">
  <img src="http://stackoverflow.com/users/flair/567863.png" width="208" height="58" alt="profile for Paul Fioravanti at Stack Overflow, Q&amp;A for professional and enthusiast programmers" title="profile for Paul Fioravanti at Stack Overflow, Q&amp;A for professional and enthusiast programmers">
</a>

[![endorse](http://api.coderwall.com/pfioravanti/endorsecount.png)](http://coderwall.com/pfioravanti)