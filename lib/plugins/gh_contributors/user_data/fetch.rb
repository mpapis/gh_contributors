require 'gh_contributors/json_helper'

module GhContributors::UserData
  class Fetch
    extend JsonHelper
    def self.load(login, data, contributions)
      user_data = load_json(data.first['url'])
      user_data['contributions'] = contributions
      user_data
    end
  end
end
