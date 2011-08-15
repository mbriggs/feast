source 'http://rubygems.org'

gem 'rails', '3.1.0.rc5'
gem 'sqlite3'
gem 'chronic'
gem 'jquery-rails'
gem 'haml'
gem 'heroku'
gem 'devise'
gem 'oa-openid', :require => 'omniauth/openid'
gem 'mongoid'
gem 'bson_ext'

group  :development do
  gem 'unicorn'
  gem 'annotate'
end

group :test do
  gem 'rspec-rails'
  gem 'timecop'
  gem 'spork'
  gem 'machinist', '>= 2.0.0.beta2'
  gem 'machinist_mongo', 
    git: 'https://github.com/nmerouze/machinist_mongo.git',
    branch: 'machinist2',
    require: 'machinist/mongoid'
  gem 'database_cleaner'
end

group :assets do
  gem 'sass-rails', "~> 3.1.0.rc"
  gem 'bourbon'
  gem 'coffee-rails', "~> 3.1.0.rc"
  gem 'uglifier'
end
