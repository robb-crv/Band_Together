require 'rails_helper'

RSpec.describe FollowingRelationshipsController, type: :controller do

	describe 'following_relationships#create' do
		
		it 'should create a record in following relationship' do 
			expect {
  				post :create , following_relationships: FactoryGirl.create(:following_relationship) 
  			}.to change(FollowingRelationship, :count).by(1)
		end
	end

	describe 'following_relationships#destroy' do
		
		before(:each) do
			
			@user1= FactoryGirl.create(:user)
			@user2= FactoryGirl.create(:user)

			@rel1 = FactoryGirl.create(:following_relationship, :follower_id => @user1.id, :followed_id => @user2.id)
			
			expect {
  				@user1.unfollow(@user2)
  			}.to change(FollowingRelationship, :count).by(-1)
		end

		it 'should delete the relationship' do 
			expect(@user1.followings).not_to include(@user2)
		end
	end 
end
