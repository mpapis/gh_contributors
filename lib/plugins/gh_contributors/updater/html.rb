module GhContributors::Updater
  class Html
    DEFAULT_SEARCH = /<span class="contributors">.*?<\/span>/m
    DEFAULT_REPLACE = %q{%Q{<span class="contributors">\n#{replace_content.join("\n")}\n</span>}}

    attr_accessor :search, :replace
    attr_reader   :replace_content

    def self.handles?(file)
      %w{ .html .html.erb }.any?{|ext| file.end_with?(ext) }
    end

    def self.update(file_content, replace_content, options)
      new(file_content, replace_content, options).to_s
    end

    def initialize(file_content, replace_content, options = {})
      parse_options(options)
      @file_content    = file_content
      @replace_content = replace_content
    end

    def parse_options(options)
      @search  = options[:search]  || DEFAULT_SEARCH
      @replace = options[:replace] || DEFAULT_REPLACE
    end

    def to_s
      file_content.sub( search, eval(replace) )
    end
  end
end
