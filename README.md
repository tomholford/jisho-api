# JishoAPI

An unofficial Ruby gem client for [Jisho](https://jisho.org), a Japanese dictionary. 

For details about the API, check out [this thread](https://jisho.org/forum/54fefc1f6e73340b1f160000-is-there-any-kind-of-search-api) by the [developer](https://github.com/Kimtaro).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'jisho_api'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install jisho_api

## Usage

### Querying

A search `query` is required, and can be set in a few ways:

```ruby
require 'jisho_api'

# Class method
JishoAPI::JishoAPI.search('hamburger')
>> [{ ... }]

# Initializer
api = JishoAPI::JishoAPI.new(query: 'ピザ')

# Accessor
api.query = '#jlpt-n5'

# Instance method
api.search # will use the internally stored query
>> [{ ... }]

api.search(query: 'something else') # will override (but not set) the internally stored query
>> [{ ... }]

```

### Pagination

By default, the gem will fetch the first page of results. There are also a few ways to override this behavior:

```ruby

# Initializer
api = JishoAPI::JishoAPI.new(query: 'ピザ', page: 2)

# Accessor
api.page = 3

# Instance methods
# Fetching a page for a given query
api.search(query: 'something else', page: 2)
>> [{ ... }]

# This increments the internal page counter and executes a request
api.next_page!
>> [{ ... }]

puts api.page
>> 4
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/tomholford/jisho-api.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
