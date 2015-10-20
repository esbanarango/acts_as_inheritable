require 'faker'

FactoryGirl.define do
  factory :person do
    first_name              { Faker::Name.first_name }
    favorite_color    { Faker::Commerce.color }
    last_name         { Faker::Name.last_name }
    soccer_team       { Faker::App.name }

    trait :with_parent do
      parent { create(:person) }
    end
  end

end