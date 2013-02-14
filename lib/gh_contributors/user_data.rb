require 'pluginator/plugin_handler'

class GhContributors
  class UserData < Pluginator::PluginHandler
    extend_abstract do
      def self.calculate_contributions(data)
        data.map{|repo| repo['contributions'].to_i}.inject(&:+)
      end
    end

    def self.load(handler, login, data)
      first!(handler).load(login, data)
    end
  end
end
