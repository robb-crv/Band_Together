require 'rails_helper'

RSpec.describe FollowingRelationship, type: :model do

    before(:each) do 

      @user1 = FactoryGirl.create(:user)
      @user2 = FactoryGirl.create(:user)

      @band = FactoryGirl.create(:band, band_manager_id: @user1.id)

    end

  	context 'validations' do

        		
  		it { should validate_presence_of :follower_id}
  		it { should validate_presence_of :followable_id}
      it { should validate_presence_of :followable_type}
  		
      context 'for follower' do 

        it "have follower_id invalid" do
          expect(FactoryGirl.build(:following_relationship, follower_id: 3, followable_id: 1, followable_type: "User") ).not_to be_valid
          expect(FactoryGirl.build(:following_relationship, follower_id: 0, followable_id: 1, followable_type: "User") ).not_to be_valid
        end

  			it {should_not allow_value(nil).for(:follower_id)}
  			it {should_not allow_value("").for(:follower_id)}

        it "have follower_id valid" do 
          expect(FactoryGirl.build(:following_relationship, follower_id: 2, followable_id: 1, followable_type: "User") ).to be_valid
          expect(FactoryGirl.build(:following_relationship, follower_id: 1, followable_id: 2, followable_type: "User") ).to be_valid
        end 
  		end

  		context 'for followable' do 

        it "have followable_id invalid" do
          expect(FactoryGirl.build(:following_relationship, follower_id: 1, followable_id: 0, followable_type: "User") ).not_to be_valid
          expect(FactoryGirl.build(:following_relationship, follower_id: 1, followable_id: 2, followable_type: "Band") ).not_to be_valid
        end
        
  			it {should_not allow_value(nil).for(:followable_id)}
  			it {should_not allow_value("").for(:followable_id)}

        it "have followable_id valid" do 
          expect(FactoryGirl.build(:following_relationship, follower_id: 1, followable_id: 1, followable_type: "Band") ).to be_valid
          expect(FactoryGirl.build(:following_relationship, follower_id: 1, followable_id: 2, followable_type: "User") ).to be_valid
        end

  		end


      context 'for followable_type' do 
        
        it "have followable type different from User or Band" do 
          expect(FactoryGirl.build(:following_relationship, follower_id: 1, followable_id: 2, followable_type: "TEST") ).not_to be_valid
        end
        
        it {should_not allow_value(nil).for(:followable_type)}
        it {should_not allow_value("").for(:followable_type)}

        it "have followable type equal to User or Band" do 
          expect(FactoryGirl.build(:following_relationship, follower_id: 1, followable_id: 2, followable_type: "User") ).to be_valid
          expect(FactoryGirl.build(:following_relationship, follower_id: 1, followable_id: 1, followable_type: "Band") ).to be_valid
        end
      end


      context 'self following' do

        it "have follower_id equal to followable_id (case type=User)" do
          expect(FactoryGirl.build(:following_relationship, follower_id: 1, followable_id: 1, followable_type: "User") ).not_to be_valid
        end

        it "have follower_id equal to followable_id (case type=Band)" do
          expect(FactoryGirl.build(:following_relationship, follower_id: 1, followable_id: 1, followable_type: "Band") ).to be_valid
        end

      end
  	
    end

end
