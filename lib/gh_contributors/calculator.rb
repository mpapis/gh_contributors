require 'gh_contributors/reader'
require 'gh_contributors/formatter'

module GhContributors
  class Calculator < Reader
    attr_reader   :data
    attr_accessor :user_data_type
    @user_data_type = :simple

    def initialize(options: {})
      super(options: options)
      @user_data_type = options[:user_data] if options[:user_data]
    end

    def format(type = :html, options = {})
      GhContributors::Formatter.new(calculated_data, type, options)
    end

    def reset_data!
      @data = nil
    end

  private

    # group data, calculate contributions, sort by contributions
    def calculated_data
      @data ||= @raw_data.group_by { |contributor|
        contributor['login']
      }.map {|login, data|
        log "user: #{login}"
        [login, user_data(login, data)]
      }.sort_by{|login, data|
        [1000000/data['contributions'], login]
      }
    end

    def contributions(data)
      data.map{|repo| repo['contributions'].to_i}.inject(&:+)
    end

    def user_data(login, data)
      @user_data_plugin ||= plugins.first_class!("user_data", user_data_type)
      @user_data_plugin.load(login, data, contributions(data))
    end
  end
end
