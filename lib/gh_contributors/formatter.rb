module GhContributors
  class Formatter
    attr_reader :content

    def initialize(data, type = :html, options = {})
       format(data, type, options)
    end

    def save(*targets)
      targets.flatten.each do |file|
        File.open(file, 'w') { |f| f.write(content) }
      end
    end

    def update(*targets, options: {})
      targets.flatten.each do |file|
        plugin = plugins.first_ask!("updater", :hanldes?, file)
        update_file(file) do |file_content|
          plugin.update(file_content, content, options)
        end
      end
    end

  private

    def plugins
      @plugins ||= Pluginator.find("gh_contributors", extends: %i{first_ask first_class})
    end

    def format(data, type = :html, options = {})
      formatter_plugin = plugins.first_class!("formatter", type).new(options)
      @content = data.map do |login, user_data|
        formatter_plugin.format(login, user_data)
      end
    end

    # Allow editing file text in a block
    # Example: update_file('some.txt'){|text| text.gsub(/bla/,'ble')}
    def update_file(file)
      log "file: #{file}"
      text = File.read(file)
      text = yield text
      File.open(file, 'w') { |f| f.write(text) }
    end
  end
end
