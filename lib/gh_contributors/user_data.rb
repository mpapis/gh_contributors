require 'pluginator'

class GhContributors
  class UnknownUserDetail < StandardError
  end

  class UserData
    class Abstract
      def self.calculate_contributions(data)
        data.map{|repo| repo['contributions'].to_i}.inject(&:+)
      end

      def self.type
        self.name.split(/::/).last.downcase.to_sym
      end

      def self.handles?(type)
        type == self.type
      end
    end

    def self.load(type, login, data)
      validate!(type)
      @rvm2plugins["user_data"].detect{ |_,plugin| plugin.handles?(type) }.last.load(login, data)
    end

    def self.validate!(type)
      @rvm2plugins ||= Pluginator.new("gh_contributors")
      unless @rvm2plugins["user_data"].map{|_,klass| klass.type }.include?(type)
        raise UnknownUserDetail.new("Unknown user_details: #{type}")
      end
    end
  end
end


