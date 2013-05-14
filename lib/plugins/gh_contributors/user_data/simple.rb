module GhContributors::UserData
  class Simple
    def self.load(login, data, contributions)
      {
        'avatar_url'    => data.first['avatar_url'],
        'name'          => login,
        'url'           => data.first['url'],
        'html_url'      => profile_url(login),
        'contributions' => contributions
      }
    end
    def self.profile_url(username)
      "https://github.com/#{username}"
    end
  end
end
