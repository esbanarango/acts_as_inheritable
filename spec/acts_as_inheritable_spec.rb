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

end