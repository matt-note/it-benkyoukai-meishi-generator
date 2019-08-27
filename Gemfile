# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'

gem 'bootsnap', '>= 1.1.0', require: false
gem 'down'
gem 'figaro'
gem 'google-cloud-storage', require: false
gem 'image_processing'
gem 'jbuilder', '~> 2.5'
gem 'jquery-rails'
gem 'meta-tags'
gem 'pg', '>= 0.18', '< 2.0'
gem 'prawn'
gem 'public_uid'
gem 'puma', '~> 3.11'
gem 'rails', '~> 5.2.3'
gem 'sass-rails', '~> 5.0'
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'
gem 'webpacker', require: false

# gem 'mini_magick', '~> 4.8'
# gem 'mini_racer', platforms: :ruby
# gem 'redis', '~> 4.0'
# gem 'bcrypt', '~> 3.1.7'
# gem 'capistrano-rails', group: :development

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem  'database_cleaner'
  gem  'factory_bot_rails'
  gem  'rspec-rails'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'rails_real_favicon'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  gem 'webdrivers'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
