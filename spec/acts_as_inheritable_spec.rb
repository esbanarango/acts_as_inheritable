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
  	describe '`belongs_to` associations' do
	    let(:person_parent) { create(:person, :with_clan) }
	    let!(:person){ create(:person, parent: person_parent) }

	    it 're-creates the clan from the parent' do
	      expect {
	        person.inherit_relations
	      }.to change(Clan, :count).by(1)
	      expect(person.clan.id).to_not eq person_parent.clan.id
	    end
  	end
  	describe '`has_many` associations' do

	    let(:person_parent) { create(:person, :with_shoes, number_of_shoes: 2) }
	    let!(:person){ create(:person, parent: person_parent) }

	    it 're-creates all the shoes from the parent' do
	      expect {
	        person.inherit_relations
	      }.to change(Shoe, :count).by(person_parent.shoes.count)
	    end

  		context 'when association is polymorphic' do
		    let(:person_parent) { create(:person, :with_pictures, number_of_pictures: 2) }
		    let!(:person){ create(:person, parent: person_parent) }

		    it 're-creates all the pictures from the parent' do
		      expect {
		        person.inherit_relations
		      }.to change(Picture, :count).by(person_parent.pictures.count)
		    end
  		end

			context 'when association is polymorphic' do
		    let(:person_parent) { create(:person, :with_pictures, number_of_pictures: 2) }
		    let!(:person){ create(:person, parent: person_parent) }

		    it 're-creates all the pictures from the parent' do
		      expect {
		        person.inherit_relations
		      }.to change(Picture, :count).by(person_parent.pictures.count)
		    end
  		end
  	end
  end
end