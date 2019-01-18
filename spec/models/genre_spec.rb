require 'rails_helper'

RSpec.describe Genre, type: :model do
  describe "validations" do 
    let(:genre){Genre.new(name: 'Programming')}
    it 'is invalid without name' do 
      genre.name =""
      expect(genre).not_to be_valid
    end
  end
end
