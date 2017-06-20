require 'rails_helper'

RSpec.describe FollowingRelationship, type: :model do
	    
  	it "has a valid factory" do
  		expect(FactoryGirl.build(:following_relationship)).to be_valid
    end

  	context 'validations' do

      it "can't have follower_id equal to followed_id" do 
        expect(FactoryGirl.build(:invalid_self_following_relationship)).not_to be_valid
      end
  		
  		it { should validate_presence_of :follower_id}
  		it { should validate_presence_of :followed_id}
  		it { should validate_uniqueness_of(:follower_id).scoped_to(:followed_id) }
  		
      context 'for follower' do 
  			it {should_not allow_value(nil).for(:follower_id)}
  			it {should_not allow_value("").for(:follower_id)}
  		end

  		context 'for followed' do 
  			it {should_not allow_value(nil).for(:followed_id)}
  			it {should_not allow_value("").for(:followed_id)}
  		end
  	end

end
