require 'setup_minitest'
require 'fixture_helper'
require 'webmock/minitest'
require 'gh_contributors'

class ForOrgTest < Test::Unit::TestCase
  def setup
    stub_request(:get, "https://api.github.com/orgs/railsinstaller/repos").
      to_return(:body => fixture("repos.json"))
    stub_request(:get, "https://api.github.com/repos/railsinstaller/railsinstaller-windows/contributors").
      to_return(:body => fixture("contributors.json"))
    stub_request(:get, "https://api.github.com/repos/railsinstaller/website/contributors").
      to_return(:body => fixture("contributors.json"))
    stub_request(:get, "https://api.github.com/repos/railsinstaller/railsinstaller-nix/contributors").
      to_return(:body => fixture("contributors.json"))
  end

  def test_class_for_org
    contributors = GhContributors.for_org('railsinstaller')
    assert_requested :get, "https://api.github.com/orgs/railsinstaller/repos"
    assert_requested :get, "https://api.github.com/repos/railsinstaller/railsinstaller-windows/contributors"
    assert_requested :get, "https://api.github.com/repos/railsinstaller/website/contributors"
    assert_requested :get, "https://api.github.com/repos/railsinstaller/railsinstaller-nix/contributors"
    assert_kind_of GhContributors, contributors
    data = contributors.data
    assert_kind_of Array, data
    contributor = data.first
    assert_kind_of Array, contributor
    contributor_name = contributor[0]
    assert_kind_of String, contributor_name
    assert_equal "mpapis", contributor_name
    contributor_hash = contributor[1]
    assert_kind_of Hash, contributor_hash
    assert_kind_of String, contributor_hash["avatar_url"]
    assert_equal "https://secure.gravatar.com/avatar/3ec52ed58eb92026d86e62c39bdb7589?d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-user-420.png", contributor_hash["avatar_url"]
    assert_kind_of String, contributor_hash["name"]
    assert_equal "mpapis", contributor_hash["name"]
    assert_kind_of String, contributor_hash["url"]
    assert_equal "https://api.github.com/users/mpapis", contributor_hash["url"]
    assert_kind_of String, contributor_hash["html_url"]
    assert_equal "https://github.com/mpapis", contributor_hash["html_url"]
    assert_kind_of Integer, contributor_hash["contributions"]
    assert_equal 471, contributor_hash["contributions"]
  end

end
