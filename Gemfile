source "https://rubygems.org"
gemspec

gem "rake"
gem "pluginator"

group :development do
  gem "json", :platforms => [:jruby, :ruby_18]
  gem "pry", :require => false
  gem "pry-doc", :require => false
  gem 'pry-debugger', :platforms => :mri_19
end

group :test do
  gem "rspec"
  gem "mocha"
  gem "webmock"
  gem "simplecov", :require => false, :platforms => [:ruby_19]
end
