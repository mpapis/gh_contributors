source "https://rubygems.org"
gemspec

group :development do
  gem "json", :platforms => [:jruby, :ruby_18]
  gem "pry", :require => false
  gem 'pry-debugger', :platforms => :mri_19
end

group :test do
  gem "rake"
  gem "mocha", :require => false
  gem "rspec"
  gem "simplecov", :require => false, :platforms => [:ruby_19]
  gem "webmock", :require => false
end
