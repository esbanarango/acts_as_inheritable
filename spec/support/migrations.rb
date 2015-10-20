require 'database_helper'

initialize_database do
  create_table :persons do |t|
    t.string :first_name
    t.string :age
    t.string :favorite_color
    t.string :last_name
    t.string :soccer_team
  end

  add_reference :persons, :parent, index: true

end