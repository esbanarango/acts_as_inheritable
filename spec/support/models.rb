require 'acts_as_inheritable'

class Person < ActiveRecord::Base
  acts_as_inheritable

  # Constants
  INHERITABLE_ATTRIBUTES = %w(favorite_color last_name soccer_team)
  INHERITABLE_ASSOCIATIONS = %w(shoes pictures)

  # Associations
  belongs_to  :parent, class_name: 'Person'
  has_many    :children, class_name: 'Person', foreign_key: :parent_id
  has_many    :toys
  has_many    :shoes
  has_many 		:pictures, as: :imageable

  # Callbacks
  before_validation :inherit_attributes, on: :create
end

class Toy < ActiveRecord::Base
  # Associations
  belongs_to  :owner, class_name: 'Person', foreign_key: :person_id
end

class Shoe < ActiveRecord::Base
  # Associations
  belongs_to  :person
end

class Picture < ActiveRecord::Base
  # Associations
  belongs_to :imageable, polymorphic: true
end

