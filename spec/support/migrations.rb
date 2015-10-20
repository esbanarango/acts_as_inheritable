require 'support/database_helper'

initialize_database do

  create_table :people do |t|
    t.string :first_name
    t.string :age
    t.string :favorite_color
    t.string :last_name
    t.string :soccer_team
  end

  add_reference :people, :parent, index: true

end