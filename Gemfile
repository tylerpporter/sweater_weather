source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.3'
gem 'rails', '~> 5.2.0'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.12'
gem 'bootsnap', '>= 1.1.0', require: false

gem 'rack-cors'
gem 'fast_jsonapi'
gem 'jbuilder'
gem 'faraday'
gem 'figaro'

group :development, :test do
  gem 'rspec-rails'
  gem 'capybara'
  gem 'launchy'
  gem 'pry'
  gem 'simplecov'
  gem 'shoulda-matchers'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'orderly'
  gem 'database_cleaner-active_record'
end

group :test do
  gem 'webmock'
  gem 'vcr'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
