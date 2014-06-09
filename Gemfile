source 'https://rubygems.org'

ruby "2.1.2"

# Configuration
group :development, :test do
  gem 'dotenv-rails'
end

# Task Engines
gem 'standard_tasks',         path: 'engines/standard_tasks'
gem 'supporting_information', path: 'engines/supporting_information'
gem 'declaration',            path: 'engines/declaration'
gem 'upload_manuscript',      path: 'engines/upload_manuscript'

# Gems
gem 'rails', '4.1.1'
gem 'unicorn'
gem 'pg'
gem 'bower-rails'
gem 'ember-rails'
gem 'ember-source', '1.5.0'
gem "ember-data-source", "~> 1.0.0.beta.7"
gem 'sass-rails', '~> 4.0.3'
gem 'haml-rails'
gem 'uglifier', '~> 2.5.0'
gem 'coffee-rails', '~> 4.0.1'
gem 'acts_as_list'
gem 'devise'
gem 'bourbon'
gem "nokogiri"
gem "jquery-fileupload-rails", github: 'neo-tahi/jquery-fileupload-rails'
gem "carrierwave"
gem "fog"
gem "unf"
gem 'rails_admin'
gem "chosen-rails", "~> 1.1.0"
gem 'newrelic_rpm'
gem "rest_client", "~> 1.7.3"
gem 'gepub'
gem 'rubyzip', require: 'zip'
gem "active_model_serializers"
gem 'pry-rails'
gem 'pdfkit'
gem 'mini_magick'
gem 'timeliness'
gem 'american_date'
gem 'omniauth-oauth2'
gem 'faraday_middleware'
gem 'ordinalize'
gem 'migration_data'
gem 'bugsnag'
gem 'omniauth-cas', github: "dandorman/omniauth-cas", ref: "83210ff52667c2c4574666dcfc9b577542fb595f"
# NOTE: Using this fork because it uses a compatible omniauth version
# https://github.com/dlindahl/omniauth-cas/pull/28

group :production, :staging do
  gem 'heroku-deflater'
  gem 'rails_12factor'
end

group :doc do
  gem 'sdoc', require: false
end

group :development do
  # gem 'rack-mini-profiler' # NOTE: this clashes with Teaspoon specs. Please add it in temporarily if you need to check for speed
  gem 'bullet'
  gem 'license_finder'
  gem 'railroady'
  gem 'spring'
end

group :development, :test do
  gem 'rspec-rails', "~> 3.0.0.beta2"
  gem "rspec-its", "~> 1.0.0.pre"
  gem 'capybara', "~> 2.3.0"
  gem 'selenium-webdriver'
  gem 'launchy'
  gem 'database_cleaner'
  gem "teaspoon"
  gem "phantomjs"
  gem 'pry-byebug'
  gem 'pry-stack_explorer'
  gem 'pry-rescue'
end

group :test do
  gem 'factory_girl_rails'
  gem "codeclimate-test-reporter", require: nil
  gem 'vcr'
  gem 'webmock'

  # For testing event streaming.
  gem 'sinatra'
  gem 'thin'
end
