require 'acts_as_inheritable'

class Person < ActiveRecord::Base
  acts_as_inheritable

  # Constants
  INHERITABLE_ATTRIBUTES = %w(favorite_color last_name soccer_team)

  # Associations
  belongs_to  :parent, class_name: 'Person'
  has_many    :children, class_name: 'Person', foreign_key: :parent_id

  # Callbacks
  before_validation :inherit_attributes, on: :create

end