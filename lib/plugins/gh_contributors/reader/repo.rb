class GhContributors::Reader::Repo
  def self.load(name)
    data = load_json("repos/#{name}/contributors")
    yield(data, name) if block_given?
    data
  end
end
