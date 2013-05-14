#/usr/bin/env ruby

##
# static content update for speed and avoiding GH limits
# read GitHub contributions, transform to urls and update files
# all public methods return self for easy chaining
#
# Example:
#
#     GhContributors.load(org: 'railsisntaller').format.update('public/contributors.html')
#     contributors = GhContributors.load(repo: 'railsisntaller/website')
#     contributors.format(:html).update('public/index.html', 'public/contributors.html')
#     contributors.format(:markdown).save('public/contriutors.md')
#

require 'pluginator'
require 'gh_contributors/calculator'

module GhContributors
  def self.load(options: {})
    GhContributors::Calculator.new(options)
  end
end
