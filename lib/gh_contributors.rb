#/usr/bin/env ruby

##
# static content update for speed and avoiding GH limits
# read GitHub contributions, transform to urls and update files
# all public methods return self for easy chaining
#
# Example:
#
#     GhContributors.for_org('railsisntaller').to_urls.update_files('public/contributors.html')
#     GhContributors.for_repo('railsisntaller/website').to_urls.update_files('public/index.html', 'public/contributors.html')
#

require 'gh_contributors/json_helper'
require 'gh_contributors/user_data'

class GhContributors
  DEFAULT_URL_FORMAT = %q{%Q{<a href="#{data['html_url']}" title="#{login} - #{data['contributions']}"><img src="#{data['avatar_url']}" alt="#{login} - #{data['contributions']}"/></a>}}
  DEFAULT_SEARCH  = /<span class="contributors">.*?<\/span>/m
  DEFAULT_REPLACE = %q{%Q{<span class="contributors">\n#{@data.join("\n")}\n</span>}}

  include JsonHelper

  @logger = $stdout
  @user_details = :simple
  class << self
    attr_accessor :logger
    attr_reader   :user_details
    def user_details=(user_details)
      UserData.validate!(user_details)
      @user_details = user_details
    end
  end

  attr_reader :data

  # for_org('railsinstaller')
  def self.for_org(name)
    GhContributors.new.for_org(name)
  end

  def for_org(name)
    @data = load_json(url_builder("orgs/#{name}/repos")).map{ |repo|
      log "repository: #{name}/#{repo['name']}"
      load_json(repo['contributors_url'])
    }.inject(&:+)
    calculate
    self
  end

  # for_repo('railsinstaller/webapp')
  def self.for_repo(name)
    GhContributors.new.for_repo(name)
  end

  def for_repo(name)
    log "repository: #{name}"
    @data = load_json(url_builder("repos/#{name}/contributors"))
    calculate
    self
  end

  def to_urls(format=GhContributors::DEFAULT_URL_FORMAT)
    @data.map! {|login, data|
      if block_given?
        yield login, data
      else
        eval format
      end
    }
    self
  end

  def update_files(files)
    opts = Hash === files.last ? files.pop : {}

    files.flatten.each do |f|
      log "file: #{file}"

      update_file(f) do |t|
        if block_given?
          t = yield t, @data, f
        else
          t.sub(
            opts.fetch(:search, DEFAULT_SEARCH),
            eval(opts.fetch(:replace, DEFAULT_REPLACE))
          )
        end
      end
    end

  self
  end

  private

  def calculate_user_data(login, data)
    UserData.load(self.class.user_details, login, data)
  end

  # group data, calculate contributions, sort by contributions
  def calculate
    @data = @data.group_by { |contributor|
      contributor['login']
    }.map {|login, data|
      log "user: #{login}"
      [login, calculate_user_data(login, data)]
    }.sort_by{|login, data|
      [1000000/data['contributions'], login]
    }
  end

  # Allow editing file text in a block
  # Example: update_file('some.txt'){|text| text.gsub(/bla/,'ble')}
  def update_file(file)
    text = File.read(file)
    text = yield text
    File.open(file, 'w') { |f| f.write(text) }
  end

  def log(text, logger = self.class.logger)
    logger.respond_to?(:info) ? logger.info(text) : logger.puts(text)
  end
end
