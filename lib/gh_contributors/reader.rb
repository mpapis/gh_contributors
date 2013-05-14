require 'gh_contributors/base'
require 'gh_contributors/json_helper'

module GhContributors
  class Reader < Base
    include GhContributors::JsonHelper

    attr_reader :raw_data

    def initialize(options: {})
      super(options: options)
      @raw_data = []
      parse_readers(filter_options("readers"))
    end

    def load(type, name)
      reader_plugin = plugins.first_class!("user_data", type)
      reader_plugin.load(login, data, contributions(data)) do |data, name|
        log "repository: #{name}"
        @raw_data += data
      end
    end

  private

    def parse_readers(options)
      options.each do |type, name|
        if name == Array
          name.each{|n| load(type,n)}
        else
          load(type, name)
        end
      end
    end
  end
end
