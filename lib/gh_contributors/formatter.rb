require 'pluginator/plugin_handler'

class GhContributors
  class Formatter < Pluginator::PluginHandler
    def self.format(handler, *args)
      first!(handler).format(*args)
    end
  end
end
