class GhContributors::Fomratter::Html
  DEFAULT_TEMPLATE = %q{%Q{<a href="#{data['html_url']}" title="#{login} - #{data['contributions']}"><img src="#{data['avatar_url']}" alt="#{login} - #{data['contributions']}"/></a>}}

  attr_accessor :template

  def initialize(options)
    @template = options[:template] || DEFAULT_TEMPLATE
  end

  def format(login, data)
    eval(template)
  end

end
