<!--
![Gem Version](http://img.shields.io/gem/v/guard-sass-lint.svg)
-->

[![Dependency Status](http://img.shields.io/gemnasium/hansondr/guard-sass-lint.svg)](https://gemnasium.com/hansondr/guard-sass-lint)
[![Build Status](https://travis-ci.org/hansondr/guard-sass-lint.svg?branch=master)](https://travis-ci.org/hansondr/guard-sass-lint)

# Guard::Sass::Lint

**guard-sass-lint** automatically checks your SCSS code style with [sass-lint](https://github.com/sasstools/sass-lint) when files are modified.

## Installation

Add this line to your application's Gemfile:

```ruby
group :development do
  gem 'guard-sass-lint'
end
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install guard-sass-lint

## Usage

Please read the [Guard usage documentation](https://github.com/guard/guard#readme).

## Options

You can pass some options in `Guardfile` like the following example:

```ruby
guard :sasslint, run_at_start: true do
  watch(%r{.+\.scss$})
end
```

### Available Options

```ruby
run_at_start: true    # Check all files at Guard startup.
                      #   default: false
config: 'filepath'    # Filepath to your sass-lint.yml config
                      #   default: sass-lint/docs/sass-lint.yml
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## MIT License

See the [LICENSE.txt](LISCENSE.txt) for details.

