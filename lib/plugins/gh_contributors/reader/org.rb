class GhContributors::Reader::Org
  def self.load(name)
    load_json(url_builder("orgs/#{name}/repos")).map{ |repo|
      data = load_json(repo['contributors_url'])
      yield(data, "#{name}/#{repo['name']}") if block_given?
      data
    }.inject(&:+)
  end
end
