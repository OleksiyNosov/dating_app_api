source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


gem 'rails'
gem 'pg'
gem 'puma'
gem 'bcrypt'
gem 'draper'
gem 'email_validator'
gem 'paperclip'

group :development, :test do
  gem 'rspec-rails'
  gem 'faker'
end

group :test do
  gem 'rails-controller-testing'
  gem 'rspec-activemodel-mocks'
  gem 'rspec-its'
  gem 'shoulda-matchers'
  gem 'shoulda-callback-matchers'
  gem 'simplecov', require: false
end

group :development do
  gem 'pry-rails'
  gem 'listen'
end