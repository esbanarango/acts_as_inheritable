# ActsAsInheritable

This is gem mean to be used with the [_Self-Referential Association_](#self-referential-association).

### Self-Referential Association

This is a code example on how to implement _Self-Referential Association_

````ruby
class Person < ActiveRecord::Base
  belongs_to :parent, class: Person
  has_many :children, class: Person, foreign_key: :parent_id
  has_many :grandchildren, class: Person, through: :children, source: :children
end
````

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'acts_as_inheritable'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install acts_as_inheritable

## Usage

TODO: Write usage instructions here

## Contributing

1. Fork it ( https://github.com/[my-github-username]/acts_as_inheritable/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
