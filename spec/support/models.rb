require 'acts_as_inheritable'

class Person < ActiveRecord::Base

  acts_as_inheritable attributes: %w(favorite_color last_name soccer_team),
                      associations: %w(shoes pictures clan toys pet)

  # Associations
  belongs_to  :parent, class_name: 'Person'
  belongs_to  :clan
  has_many    :children, class_name: 'Person', foreign_key: :parent_id
  has_many    :toys
  has_many    :shoes
  has_one     :pet
  has_many 		:pictures, as: :imageable

end

class Clan < ActiveRecord::Base
  # Associations
  has_many    :people
end

class Toy < ActiveRecord::Base
  # Associations
  belongs_to  :owner, class_name: 'Person', foreign_key: :person_id
end

class Shoe < ActiveRecord::Base
  # Associations
  belongs_to  :person
end

class Pet < ActiveRecord::Base
  # Associations
  belongs_to  :person
end

class Picture < ActiveRecord::Base
  # Associations
  belongs_to :imageable, polymorphic: true
end