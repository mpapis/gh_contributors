require 'helper'
require 'shared_examples_for_for_org'
require 'shared_examples_for_for_repo'

describe GhContributors do

  describe ".for_org" do
    it_behaves_like 'for_org', GhContributors
  end

  describe "#for_org" do
    it_behaves_like 'for_org', GhContributors.new
  end

  describe ".for_repo" do
    it_behaves_like 'for_repo', GhContributors
  end

  describe "#for_repo" do
    it_behaves_like 'for_repo', GhContributors.new
  end

end
