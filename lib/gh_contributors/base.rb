module GhContributors
  class Base
    @logger = $stdout
    attr_accessor :logger, :options

    def initialize(options: {})
      @options = options
    end

  private

    def filter_options(type)
      @options.select do |key, value|
        plugins.class_exist?(type, key)
      end
    end

    def plugins
      @plugins ||= Pluginator.find("gh_contributors", extends: %i{first_class, class_exist})
    end

    def log(text, logger = self.class.logger)
      logger.respond_to?(:info) ? logger.info(text) : logger.puts(text)
    end
  end
end

# array of contributors =>
# array of intermediate format (sorted) =>
# string of outut =>
# updating file
