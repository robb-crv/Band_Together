require 'rails_helper'

RSpec.describe Review, type: :model do
  
  	it "has a valid factory" do
  		expect(FactoryGirl.build(:review)).to be_valid
    end

  	context 'validations' do

      it "can't have reviewer_id equal to reviewed_id" do 
        expect(FactoryGirl.build(:invalid_self_review)).not_to be_valid
      end

      it "can't have rating value out of boundary" do 
      	expect(FactoryGirl.build(:invalid_rating_review)).not_to be_valid
      end

      it {should validate_presence_of :reviewer_id}
      it {should validate_presence_of :reviewed_id}
      it {should validate_presence_of :description}
      it {should validate_presence_of :rating}
      it {should validate_uniqueness_of(:reviewer_id).scoped_to(:reviewed_id)}
      
	end
end
