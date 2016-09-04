###########################################
# NOTHING GOES IN HERE WITHOUT A COMMENT! #
###########################################

# Specify ruby version that we use. Bundler gives an error when a different ruby is used.
ruby '2.3.0'

# The repository from which we're fetching our rubygems.
source 'https://rubygems.org'

# Rails. Duh.
gem 'rails', '5.0.0.1'

# acts_as_list provides the means to sort and reorder a list of objects
# with respect to a column in the database, e.g. to sort and reorder a list
# of job applications based on the priority set by the applicant.
gem 'acts_as_list'

# Use activerecord as session store
gem 'activerecord-session_store'

# bcrypt() is a sophisticated and secure hash algorithm
# designed by The OpenBSD project for hashing passwords.
# bcrypt-ruby provides a simple wrapper for safely handling passwords.
gem 'bcrypt-ruby', require: 'bcrypt'

# we only use this gem for it's ujs capabilities.
# jquery is the defacto DOM manipulation libraray
gem 'jquery-rails'

# jquery ui for datepicker etc.
gem 'jquery-ui-rails'

# used for sorting tables in the admission
gem "jquery-tablesorter"

# CoffeeScript is a scripting language. It compiles to JavaScript.
gem 'coffee-rails'
# Explicitly request sass version
gem 'sass'
# Sass is a stylesheet language. It compiles to CSS.
gem 'sass-rails'
# Sass mixin library
gem 'bourbon'
# Semantic fluid grid framework
gem 'neat'
# uglifier is a Ruby wrapper for UglifyJS, a JavaScript compressor.
gem 'uglifier'

# declarative_authorization provides a DSL for role-based access control.
# See: config/authorization_rules.rb
#gem 'declarative_authorization'

# ActiveRecord manages referential integrity at the application level,
# not the database level. Therefore, there are no methods for explicitly
# adding foreign keys in ActiveRecord migrations.
# foreigner adds a few such methods.
gem 'foreigner'

# formtastic is a Rails form builder plugin
# with semantically rich and accessible markup.
gem 'formtastic'

# Google Charts is an online service for generating charts.
# We use it for displaying statistics about admissions.
gem 'googlecharts'

# Haml is a templating language. It compiles to HTML.
gem 'haml-rails'

# icalendar is a library for dealing with iCalendar files.
gem 'icalendar'

# rails-translate-routes lets us use localized routes.
# For example, we can replace the path '/groups' with the paths
# '/gjenger' and '/en/groups' which both point to the same page.
# See: config/locales/routes/i18n-routes.yml
gem 'rails-translate-routes'

# RedCarpet renders Markdown, a light-weight markup language, to HTML.
# See: config/initializers/haml_markdown.rb
gem 'redcarpet'

# route_downcaser adds transparent support for case-insensive routes by downcasing requested URLs.
gem 'route_downcaser'

# SamfundetDomain is a gem which provides the application with samfundets domain models.
gem 'samfundet_domain', '~> 0.1.0', git: "https://github.com/Samfundet/SamfundetDomain.git", branch: "rails5"

# SamfundetAuth is a gem which provides the application with methods for authenticating against mdb2.
gem 'samfundet_auth', '~> 0.1.0', git: "https://github.com/Samfundet/SamfundetAuth.git", branch: "rails5"

# will_paginate is an adaptive pagination plugin.
# It makes pagination very simple.
gem 'will_paginate'

# for file uploads, see https://github.com/thoughtbot/paperclip
gem "paperclip"

# automatic compression of images uploaded via paperclip
gem 'paperclip-compression'

# A simple date validator for Rails 3.
gem 'date_validator'

# therubyracer is a Ruby connection to the V8 JavaScript interpreter.
gem 'therubyracer', require: 'v8'

# PostgreSQL adapter. See: config/database.yml
gem 'pg'

# Provides PostgreSQL fulltext search. Contains wrappers for tsvectors
# and enables searching in nested attributes.
gem 'pg_search', git: 'https://github.com/Casecommons/pg_search.git', ref: 'ff1af34'

# Diff library used in history for information pages
gem 'diff-lcs'

# Middleware to send notifications when errors occur
gem 'exception_notification'

# Addon to exception_notification that sends exceptions to slack
gem 'slack-notifier'

# Cocoon makes nested forms for price groups under events a lot easier. Adds some buttons and stuff
gem 'cocoon'




group :development do

  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  # Gem to detect ruby style guide violations
  gem 'rubocop', require: false

  # annotate adds schema information from the database, in the form of
  # Ruby comments, to model files so that we can see which columns
  # are actually in the database.
  gem 'annotate'

  # Easier preview of mail in development
  gem 'letter_opener'

  # better_errors gives us better error pages when something goes wrong.
  # binding_of_caller is an optional dependency of better_errors which
  # allows for features such as local / instance variable expection,
  # REPL debugging etc.
  gem 'better_errors'
  gem 'binding_of_caller'

  # magic_encoding adds an 'encoding: utf-8' comment to all .rb files
  gem 'magic_encoding'

  # rails-footnotes adds information useful for debugging to the bottom
  # of our web pages for easy reference.
  #gem 'rails-footnotes'

  # RSpec is a unit testing framework.
  # rspec-rails integrates RSpec (v2) and Rails (v3).
  gem 'rspec-rails'


  # Simple command execution over SSH. Lightweight deployment tool.
  # Using our own version until https://github.com/mina-deploy/mina/pull/361 is merged.
  gem 'mina', git: "https://github.com/Samfundet/mina.git"

  # A DSL for quickly creating web applications in Ruby with minimal effort.
  #gem 'sinatra'

  # Turns objects into nicely formatted columns for easy reading.
  gem 'table_print'

  # Generate diagrams of models and controllers. Usage: Install graphviz and run 'rake diagram:all'.
  gem 'railroady'
end

group :test, :development do
  # Faker is a library that generates fake data (names, email addresses, etc.)
  gem 'faker', '~> 1.6.6'

  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
end

group :test do
  # Cucumber is a BDD testing framework.
  gem 'cucumber-rails', require: false

  # database_cleaner ensures a clean DB state during tests;
  # we use it with Cucumber.
  gem 'database_cleaner'

  # launchy is an application launcher; it's required for the
  # 'Then show me the page' action in Cucumber
  gem 'launchy'

  # The RSpec testing framework.
  gem 'rspec'

  # webrat provides functions such as 'visit', 'click_link',
  # 'click_button', etc. for use in integration tests.
  gem 'webrat'
end
