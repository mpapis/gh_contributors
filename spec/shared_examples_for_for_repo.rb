shared_examples_for 'for_repo' do |object|

  before do
    stub_gh_get("/repos/railsinstaller/railsinstaller-nix/contributors").
      to_return(:body => fixture("contributors.json"))
  end

  it "requests the correct GitHub API resources" do
    object.for_repo('railsinstaller/railsinstaller-nix')
    expect(a_gh_get("/repos/railsinstaller/railsinstaller-nix/contributors")).to have_been_made
  end

  it "returns a GhContributors object" do
    contributors = object.for_repo('railsinstaller/railsinstaller-nix')
    expect(contributors).to be_kind_of GhContributors
  end

  context ".data" do

    it "is an array" do
      data = object.for_repo('railsinstaller/railsinstaller-nix').data
      expect(data).to be_kind_of Array
    end

    context ".first" do

      it "is a contributor" do
        contributor = object.for_repo('railsinstaller/railsinstaller-nix').data.first
        expect(contributor).to be_kind_of Array
      end

      context "zeroth element" do

        it "is contributor's name" do
          contributor_name = object.for_repo('railsinstaller/railsinstaller-nix').data.first[0]
          expect(contributor_name).to be_kind_of String
          expect(contributor_name).to eq "mpapis"
        end

      end

      context "first element" do

        it "is contributor's data" do
          contributor_hash = object.for_repo('railsinstaller/railsinstaller-nix').data.first[1]
          expect(contributor_hash).to be_kind_of Hash
          expect(contributor_hash["avatar_url"]).to be_kind_of String
          expect(contributor_hash["avatar_url"]).to eq "https://secure.gravatar.com/avatar/3ec52ed58eb92026d86e62c39bdb7589?d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-user-420.png"
          expect(contributor_hash["name"]).to be_kind_of String
          expect(contributor_hash["name"]).to eq "mpapis"
          expect(contributor_hash["url"]).to be_kind_of String
          expect(contributor_hash["url"]).to eq "https://api.github.com/users/mpapis"
          expect(contributor_hash["html_url"]).to be_kind_of String
          expect(contributor_hash["html_url"]).to eq "https://github.com/mpapis"
          expect(contributor_hash["contributions"]).to be_kind_of Integer
          expect(contributor_hash["contributions"]).to eq 157
        end

      end

    end

  end

end
