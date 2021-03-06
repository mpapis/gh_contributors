require 'json'
require 'open-uri'

module GhContributors
  module JsonHelper
    # Build full path to resource to use
    def url_builder(path)
      "https://api.github.com/#{path}"
    end

    # Load json from url
    def load_json(url)
      open(url){ |json| Json.load(json) }
    end
  end
end
