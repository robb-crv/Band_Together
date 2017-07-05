require 'rails_helper'

RSpec.describe FollowingRelationshipsController, type: :controller do

	login_user

    before(:each) do 

      @user1 = FactoryGirl.create(:user)
      @user2 = FactoryGirl.create(:user)

      @band1 = FactoryGirl.create(:band, band_manager_id: @user1.id)
      @band2 = FactoryGirl.create(:band, band_manager_id: @user1.id)

    end

	describe 'following_relationships#create' do
		
		it 'create new Following relationship' do
			expect {

				params = {:followable_id => @user2.id, :followable_type => "User"}	
				post :create, params
			}.to change(FollowingRelationship, :count).by(1)

			expect(subject.current_user.followings_users).to include(@user2)

		end

	end

	describe 'following_relationships#unfollow' do
		
		it 'should destroy a record in following relationship' do 
			rel = FollowingRelationship.create(follower_id: subject.current_user.id, followable_id: @user2.id, followable_type: "User")
			expect {
	  			params = {:followable_id => @user2.id, :followable_type => "User"}	
	  			post :unfollow, params
	  			
  			}.to change(FollowingRelationship, :count).by(-1)
  			expect(subject.current_user.followings_users).not_to include(@user2)
		end
	end 
end
