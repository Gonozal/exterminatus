source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.6'

# Database adapter (PGSQL)
gem 'pg', '~> 0.18.0.pre20141017160319'

##############################################
# Stylesheets, JS, Templating Engines
##############################################
# Use SCSS for stylesheets
gem 'sass-rails'
# Autoprefixer automatically adds broweser prefixes on compiling less
gem 'autoprefixer-rails'
# Twitters Bootstrap powered by SCSS
gem 'bootstrap-sass'

gem 'twitter-typeahead-rails'

# Layout helper for e.g. bootstrap
group :development do
  gem 'rails_layout'
end

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'
# Use jquery as the JavaScript library
gem 'jquery-rails'

gem 'jquery-turbolinks'
gem 'turbolinks'

# Slim Template engine
gem 'slim'
gem 'slim-rails'
##############################################
# end Stylesheets, JS, Templating Engines
##############################################

# Form Builders
gem 'simple_form', '3.1.0.rc2'


# User Management with devise
gem "devise"

# Easy role management with cancan
gem "cancan"

# Javascript Runetimes
gem "execjs"


# Recurring Events
gem 'ice_cube'

# In-Place editing
gem 'bootstrap-editable-rails'
# Sortable tables
gem 'jquery-tablesorter'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc

gem 'pry'
gem 'pry-doc', '>= 0.6.0'
gem 'method_source', '>= 0.8.2'

# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7hjjk'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development
gem 'capistrano', '~>2.15', group: :development
gem 'rvm-capistrano', '~> 1.5', group: :development
# Use debugger
# gem 'debugger', group: [:development, :test]

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin]

# Fully threaded webserver
gem 'puma', platforms: [:ruby]

gem 'rspec-rails',group: [:test, :development]
gem 'ruby-lint', group: [:development]
group :test do
  gem 'factory_girl_rails'
  gem 'capybara'
  gem 'faker'
  gem 'database_cleaner'
end
