unless ENV['CI']
  require 'simplecov'
  SimpleCov.start do
    add_filter 'spec'
  end
end

require 'gh_contributors'
require 'rspec'
require 'webmock/rspec'

RSpec.configure do |c|
  c.expect_with :rspec do |c|
    c.syntax = :expect
  end

  c.before(:each) do
    GhContributors.any_instance.stub(:log).and_return(StringIO.new)
  end
end

def a_gh_get(path)
  a_request(:get, "https://api.github.com" + path)
end

def stub_gh_get(path)
  stub_request(:get, "https://api.github.com" + path)
end

def fixture_path
  File.expand_path("../fixtures", __FILE__)
end

def fixture(file)
  File.new(fixture_path + '/' + file)
end
