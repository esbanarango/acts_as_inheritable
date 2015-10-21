require 'spec_helper'
require 'support/migrations'
require 'support/factories'
require 'support/models'

RSpec.describe "ActiveRecord::Base model with #acts_as_inheritable" do

  describe '#inherit_attributes' do
    let(:person){ create(:person, :with_parent, favorite_color: nil, last_name: nil, soccer_team: nil) }
    let!(:person_parent) { person.parent }
    it 'inherits values from his parent' do
      expect(person.favorite_color).to eq person_parent.favorite_color
      expect(person.last_name).to eq person_parent.last_name
      expect(person.soccer_team).to eq person_parent.soccer_team
    end
  end

  describe '#inherit_relations' do
    let(:person_parent) { create(:person, :with_shoes, number_of_shoes: 2) }
    let!(:person){ create(:person, parent: person_parent) }

    it 're-creates all the shoes from the parent' do
      expect {
        person.inherit_relations
      }.to change(Shoe, :count).by(person_parent.shoes.count)
    end
  end

end