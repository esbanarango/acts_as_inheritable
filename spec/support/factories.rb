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

    trait :with_toys do
      transient do
        number_of_toys 4
      end
      after :create do |person, evaluator|
        create_list :toy, evaluator.number_of_toys, owner: person
      end
    end

    trait :with_shoes do
      transient do
        number_of_shoes 4
      end
      after :create do |person, evaluator|
        create_list :shoe, evaluator.number_of_shoes, person: person
      end
    end
  end

  factory :toy do
    friendly    { [true, false].sample}
    material    { Faker::Lorem.word }
    color       { Faker::Commerce.color }
    brand       { Faker::Company.name }
  end

  factory :shoe do
    sneakers    { [true, false].sample}
    size       	{ Faker::Number.number(3) }
    brand       { Faker::Company.name }
  end
end