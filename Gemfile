# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }
ruby '2.7.2'

# Server/Rack/Engine
gem 'puma'
gem 'rails', '~> 6.0.3'

# DB
gem 'mysql2'
gem 'ridgepole'

# HTML/CSS/JS
gem 'bootsnap', require: false
gem 'turbolinks'

# Authentication
gem 'devise'

# Webpack for rails
gem 'webpacker', '~> 5.2', '>= 5.2.1'

group :development, :test do
  gem 'binding_of_caller'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'pry-byebug'
  gem 'pry-doc'
  gem 'pry-rails'
  gem 'rubocop'
  gem 'rubocop-performance'
  gem 'rubocop-rails'
  gem 'rubocop-rspec'
end

group :development do
  gem 'annotate'
  gem 'better_errors'
  gem 'bullet'
  gem 'web-console'
  gem 'listen'
  gem 'spring'
  gem 'spring-watcher-listen'
end

group :test do
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'rspec'
  gem 'rspec-rails'
  gem 'rspec_junit_formatter'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers'
  gem 'simplecov', '~> 0.17.0', require: false # TODO: https://github.com/codeclimate/test-reporter/issues/418
end
