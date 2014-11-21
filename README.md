[![Code Climate](https://codeclimate.com/github/jcronk/gettysburg/badges/gpa.svg)](https://codeclimate.com/github/jcronk/gettysburg)
# Gettysburg

Convert street addresses and personal or company names to title case from full caps (or all lowercase).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'gettysburg'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install gettysburg

## Usage

This monkeypatches String with `#titlecase` and `#titlecase!` methods.  These should apply correct titlecasing and leave things like NE, NW, PO (in PO Box), LLC, INC, and so on, alone.  

## Contributing

1. Fork it ( https://github.com/[my-github-username]/gettysburg/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
