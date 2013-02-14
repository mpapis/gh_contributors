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

require 'multi_json'
require 'open-uri'

class GhContributors
  DEFAULT_URL_FORMAT = %q{%Q{<a href="#{data['html_url']}" title="#{login} - #{data['contributions']}"><img src="#{data['avatar_url']}" alt="#{login} - #{data['contributions']}"/></a>}}
  DEFAULT_SEARCH  = /<span class="contributors">.*?<\/span>/m
  DEFAULT_REPLACE = %q{%Q{<span class="contributors">\n#{@data.join("\n")}\n</span>}}

  class UnknownUserDetail < Exception
  end

  @logger = $stdout
  @user_details = :simple
  class << self
    attr_accessor :logger
    attr_reader   :user_details
    def user_details_validate!
      raise UnknownUserDetail.new("Unknown user_details: #{@user_details}") unless [:simple, :fetch].include?(@user_details)
    end
    def user_details=(user_details)
      @user_details = user_details
      user_details_validate!
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
      log "user: #{login} - #{data['contributions']}"
      if block_given?
        yield login, data
      else
        eval format
      end
    }
    self
  end

  def update_files(*files)
    options = files.last.kind_of?(Hash) ? files.pop : {}
    options[:search]  ||= DEFAULT_SEARCH
    options[:replace] ||= DEFAULT_REPLACE
    files = files.first if files.first.kind_of? Array
    files.each do |file|
      log "file: #{file}"
      update_file(file) do |text|
        if block_given?
          text = yield text, @data, file
        else
          text.sub(options[:search], eval(options[:replace]))
        end
      end
    end
    self
  end

  private

  # group data, calculate contributions, sort by contributions
  def calculate_user_data_simple(login, data)
    {
      'avatar_url'    => data.first['avatar_url'],
      'name'          => login,
      'url'           => data.first['url'],
      'html_url'      => profile_url(login),
      'contributions' => data.map{|repo| repo['contributions'].to_i}.inject(&:+)
    }
  end

  def calculate_user_data_fetch(login, data)
    user_data = load_json(data.first['url'])
    user_data['contributions'] = data.map{|repo| repo['contributions'].to_i}.inject(&:+)
    user_data
  end

  def calculate_user_data(login, data)
    self.class.user_details_validate!
    send("calculate_user_data_#{self.class.user_details}".to_sym, login, data)
  end

  def calculate
    @data = @data.group_by { |contributor|
      contributor['login']
    }.map {|login, data|
      [login, calculate_user_data(login, data)]
    }.sort_by{|login, data|
      [1000000/data['contributions'], login]
    }
  end

  def profile_url(username)
    "https://github.com/#{username}"
  end

  # Build full path to resource to use
  def url_builder(path)
    "https://api.github.com/#{path}"
  end

  # Load json from url
  def load_json(url)
    open(url){ |json| MultiJson.load(json) }
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
