require 'setup_minitest'
require 'gh_contributors'

class UrlLoadTest < Test::Unit::TestCase
  def setup
    @ghc = GhContributors.new
  end

  def test_url_builder
    assert_equal('https://api.github.com/test/me', @ghc.send(:url_builder, 'test/me'))
  end

  def test_load_json_basic
    @ghc.stubs(:open).with('example').returns('works')
    assert_equal('works', @ghc.send(:load_json, 'example'))
  end
end
