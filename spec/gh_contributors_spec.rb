require 'helper'
require 'shared_examples_for_for_org'

describe GhContributors do

  describe ".for_org" do
    it_behaves_like 'for_org', GhContributors
  end

  describe "#for_org" do
    it_behaves_like 'for_org', GhContributors.new
  end

end
