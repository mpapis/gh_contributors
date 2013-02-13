# Github Contributors

Update static files with github contributors list.

- Static content update for speed and avoiding GH limits.
- Read GitHub contributions, transform to urls and update files.
- All public methods return self for easy chaining.

# Example

```ruby
GhContributors.for_org('railsisntaller').to_urls.update_files('public/contributors.html')
GhContributors.for_repo('railsisntaller/website').to_urls.update_files('public/index.html')
```

# TODO

1. add tests
2. improve docs
