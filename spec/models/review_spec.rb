require 'rails_helper'

RSpec.describe Review, type: :model do
    
    before(:each) do 

      @user1 = FactoryGirl.create(:user)
      @user2 = FactoryGirl.create(:user)

      @band = FactoryGirl.create(:band, band_manager_id: @user1.id)

    end
  	

  	context 'validations' do

      it { should validate_presence_of :reviewer_id}
      it { should validate_presence_of :reviewable_id}
      it { should validate_presence_of :reviewable_type}
      it {should validate_presence_of :description}
      it {should validate_presence_of :rating}

      context 'for reviewer' do 

        it 'have reviewer_id invalid' do 
          expect(FactoryGirl.build(:review, reviewer_id: 0, reviewable_id: 1, reviewable_type: "User", rating: 5, description: "descr") ).not_to be_valid
          expect(FactoryGirl.build(:review, reviewer_id: 3, reviewable_id: 1, reviewable_type: "User", rating: 5, description: "descr") ).not_to be_valid

        end

        it 'have reviewer_id valid' do 
          expect(FactoryGirl.build(:review, reviewer_id: 1, reviewable_id: 2, reviewable_type: "User", rating: 5, description: "descr") ).to be_valid
          expect(FactoryGirl.build(:review, reviewer_id: 2, reviewable_id: 1, reviewable_type: "User", rating: 5, description: "descr") ).to be_valid
        end

        it {should_not allow_value(nil).for(:reviewer_id)}

      end

      context 'for reviewable' do

        it 'have reviewable_id invalid' do 
          expect(FactoryGirl.build(:review, reviewer_id: 1, reviewable_id: 3, reviewable_type: "User", rating: 5, description: "descr") ).not_to be_valid
          expect(FactoryGirl.build(:review, reviewer_id: 1, reviewable_id: 2, reviewable_type: "Band", rating: 5, description: "descr") ).not_to be_valid
        end

        it 'have reviewable_id valid' do 
          expect(FactoryGirl.build(:review, reviewer_id: 1, reviewable_id: 2, reviewable_type: "User", rating: 5, description: "descr") ).to be_valid
          expect(FactoryGirl.build(:review, reviewer_id: 1, reviewable_id: 1, reviewable_type: "Band", rating: 5, description: "descr") ).to be_valid
        end

        it {should_not allow_value(nil).for(:reviewable_id)}
      end

      context 'for reviewable_type' do 

        it "have reviewable type different from User or Band" do 
          expect(FactoryGirl.build(:review, reviewer_id: 1, reviewable_id: 2, reviewable_type: "TEST") ).not_to be_valid
        end
        

        it "have reviewable type equal to User or Band" do 
          expect(FactoryGirl.build(:review, reviewer_id: 1, reviewable_id: 2, reviewable_type: "User") ).to be_valid
          expect(FactoryGirl.build(:review, reviewer_id: 1, reviewable_id: 1, reviewable_type: "Band") ).to be_valid
        end

        it {should_not allow_value(nil).for(:reviewable_type)}
        it {should_not allow_value("").for(:reviewable_type)}

      end

      context 'description' do
        
        it {should_not allow_value(nil).for(:description)}
        it {should_not allow_value("").for(:description)}
        it {should validate_length_of :description}

      end      
       
      context 'rating' do
        
        
        (1..5).each do |i|
          it {should allow_value(i).for(:description)}
        end
        
        it {should allow_value(0).for(:description)}
        it {should allow_value(6).for(:description)}

      end

      context 'self reviewing' do 
        
        it "have reviewer_id equal to reviewable_id (case type=User)" do
          expect(FactoryGirl.build(:review, reviewer_id: 1, reviewable_id: 1, reviewable_type: "User") ).not_to be_valid
        end

        it "have reviewer_id equal to reviewable_id (case type=Band)" do
          expect(FactoryGirl.build(:review, reviewer_id: 1, reviewable_id: 1, reviewable_type: "Band") ).to be_valid
        end
      
      end

	end
end
