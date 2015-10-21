# ActsAsInheritable

[![Build Status](https://travis-ci.org/esbanarango/acts_as_inheritable.svg)](https://travis-ci.org/esbanarango/acts_as_inheritable) [![Test Coverage](https://codeclimate.com/github/esbanarango/acts_as_inheritable/badges/coverage.svg)](https://codeclimate.com/github/esbanarango/acts_as_inheritable/coverage) [![Code Climate](https://codeclimate.com/github/esbanarango/acts_as_inheritable/badges/gpa.svg)](https://codeclimate.com/github/esbanarango/acts_as_inheritable)

This is gem mean to be used with the [_Self-Referential Association_](#self-referential-association), or with a model having a `parent` that share the inheritable attributes. This will let you inheritable any __attribute__ or __relation__ from the _parent_ model.

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

```ruby

class Person < ActiveRecord::Base
  acts_as_inheritable

  # Constants
  INHERITABLE_ATTRIBUTES = %w(favorite_color last_name soccer_team)
  INHERITABLE_ASSOCIATIONS = %w(shoes pictures clan)

  # Associations
  belongs_to  :parent, class_name: 'Person'
  belongs_to  :clan
  has_many    :children, class_name: 'Person', foreign_key: :parent_id
  has_many    :toys
  has_many    :shoes
  has_many    :pictures, as: :imageable

  # Callbacks
  before_validation :inherit_attributes, on: :create
  before_validation :inherit_relations, on: :create
end

````

#### inherit_attributes
##### params
  - `force` | default to true. Set the attribute even if it's _present_.
  - `not_force_for` | array of attributes. When setting `force` to _true_, you can also specify the attributes you don't want to overwrite.

__inherit_attributes__ method by default will only set values that are [blank?](http://api.rubyonrails.org/classes/Object.html#method-i-blank-3F).


## Contributing

1. Fork it ( https://github.com/[my-github-username]/acts_as_inheritable/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
