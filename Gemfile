source 'https://rubygems.org'

# Declare your gem's dependencies in binnacle_chat.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

# client-side assets
source 'https://rails-assets.org' do
  gem 'rails-assets-binnacle', '>= 0.1.5'
  gem 'rails-assets-jquery-ui', '~> 1', '>= 1.11.3'
  gem 'rails-assets-jquery', '~> 2.1', '>= 2.1.4'
  gem 'rails-assets-jspanel', '~> 2.6', '>= 2.6.1'
  gem 'rails-assets-gravatarjs', '~> 1.0', '>= 1.0.0'
  gem 'rails-assets-bootstrap-sass', '~> 3.3', '>= 3.3.5'
  gem 'rails-assets-rails-behaviors', '~> 0.8', '>= 0.8.4', group: :development
end

group :development do
  gem 'coffee-rails', '~> 4.1'
  gem 'dotenv-rails', '~> 2.0.2'
  gem 'devise'
end
