class GhContributors
  class UserData
    class Simple < Abstract
      def self.load(login, data)
        {
          'avatar_url'    => data.first['avatar_url'],
          'name'          => login,
          'url'           => data.first['url'],
          'html_url'      => profile_url(login),
          'contributions' => calculate_contributions(data)
        }
      end
      def self.profile_url(username)
        "https://github.com/#{username}"
      end
    end
  end
end
