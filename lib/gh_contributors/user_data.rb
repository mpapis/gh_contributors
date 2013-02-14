require 'pluginator'

class GhContributors
  class UnknownUserDetail < StandardError
  end

  class UserData
    class Abstract
      def self.calculate_contributions(data)
        data.map{|repo| repo['contributions'].to_i}.inject(&:+)
      end

      def self.handles
        self.name.split(/::/).last.downcase.to_sym
      end
    end

    def self.find(type)
      @rvm2plugins ||= Pluginator.new("gh_contributors")
      @rvm2plugins["user_data"].detect{ |_,plugin| plugin.handles == type }
    end

    def self.load(type, login, data)
      validate!(type)
      find(type).last.load(login, data)
    end

    def self.validate!(type)
      if find(type).nil?
        raise UnknownUserDetail.new("Unknown user_details: #{type}")
      end
    end

    def self.register_class(klass)
      @rvm2plugins ||= Pluginator.new("gh_contributors")
      @rvm2plugins.register_plugin_class("user_data", klass)
    end
  end
end
