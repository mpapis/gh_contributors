require 'helper'
require 'shared_examples_for_load'
require 'shared_examples_for_for_repo'

describe GhContributors do
  describe "#load" do
    it_behaves_like "load", GhContributors.start
  end
end
