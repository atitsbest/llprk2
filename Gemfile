source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2'
gem 'pg'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc

# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
gem 'spring',        group: :development

gem 'therubyracer'  # If using Ruby
# gem 'jquery-rails'  # If using Bootstrap's JS plugins.

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use debugger
# gem 'debugger', group: [:development, :test]

gem "puma"

gem "paypal-express"
gem "paperclip", "~> 4.2"
gem "less-rails-bootstrap"
gem "exception_notification", "~> 4.0.1"

group :development do
    gem 'tiny_tds'
    gem 'capistrano', require: false
    gem 'capistrano-rbenv', require: false
    gem 'capistrano-rails', require: false
    gem 'capistrano-bundler', require: false
    gem 'capistrano3-puma', require: false
end

group :test do
    gem 'fakeweb', '~> 1.3.0'
end

group :test, :development do
    gem 'byebug', '> 2.7.0'
end
