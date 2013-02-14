class GhContributors
  class Fomratter
    class Html < Abstract
      DEFAULT_URL_FORMAT = %q{%Q{<a href="#{data['html_url']}" title="#{login} - #{data['contributions']}"><img src="#{data['avatar_url']}" alt="#{login} - #{data['contributions']}"/></a>}}
      DEFAULT_SEARCH  = /<span class="contributors">.*?<\/span>/m
      DEFAULT_REPLACE = %q{%Q{<span class="contributors">\n#{data.join("\n")}\n</span>}}

      attr_accessor :url_format, :search, :replace

      def initialize
        @url_format = DEFAULT_URL_FORMAT
        @search     = DEFAULT_SEARCH
        @replace    = DEFAULT_REPLACE
      end

      def format(login, data)
        eval(@url_format)
      end

      def output(data, file)
        eval(@replace)
      end
    end
  end
end
