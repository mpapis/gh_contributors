# Github Contributors

[![Build Status](https://travis-ci.org/mpapis/gh_contributors.png?branch=master)][travis]

[travis]: https://travis-ci.org/mpapis/gh_contributors

Update static files with github contributors list.

* Static content update for speed and avoiding GH limits.
* Read GitHub contributions, transform to urls and update files.
* All public methods return self for easy chaining.

## Example

```ruby
GhContributors.for_org('railsisntaller').to_urls.update_files('public/contributors.html')
GhContributors.for_repo('railsisntaller/website').to_urls.update_files('public/index.html')
```

## TODO

1. add tests
2. improve docs

## Supported Ruby Versions
This library aims to support and is [tested against][travis] the following Ruby
implementations:

* Ruby 1.8.7
* Ruby 1.9.3
* Ruby 2.0.0
* [JRuby](http://jruby.org/)
* [Rubinius](http://rubini.us/)

If something doesn't work on one of these interpreters, it's a bug.

This library may inadvertently work (or seem to work) on other Ruby
implementations, however support will only be provided for the versions listed
above.

If you would like this library to support another Ruby version, you may
volunteer to be a maintainer. Being a maintainer entails making sure all tests
run and pass on that implementation. When something breaks on your
implementation, you will be responsible for providing patches in a timely
fashion. If critical issues for a particular implementation exist at the time
of a major release, support for that Ruby version may be dropped.
