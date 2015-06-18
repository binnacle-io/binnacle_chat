source 'https://rubygems.org'

# Declare your gem's dependencies in binnacle_chat.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

# client-side assets
source 'https://rails-assets.org' do
  gem 'rails-assets-binnacle', '~> 0.0.9'
  gem 'rails-assets-jquery-ui', '~> 1.11.3'
  gem 'rails-assets-jquery', '~> 2.1.3'
  gem 'rails-assets-jspanel', '~> 2.5.2'
  gem 'rails-assets-bootstrap-sass', '~> 3.3.4', group: :development
  gem 'rails-assets-components-font-awesome', '~> 4.3.0', group: :development
  gem 'rails-assets-rails-behaviors', '~> 0.8.2', group: :development
end

group :development do
  gem 'coffee-rails', '~> 4.1.0'
  gem 'dotenv-rails', '~> 1.0.2'
  gem 'devise'
end
