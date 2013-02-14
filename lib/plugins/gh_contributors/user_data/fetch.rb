require 'gh_contributors/json_helper'

class GhContributors
  class UserData
    class Fetch < Abstract
      class << self
        include JsonHelper
        def load(login, data)
          user_data = load_json(data.first['url'])
          user_data['contributions'] = calculate_contributions(data)
          user_data
        end
      end
    end
  end
end
