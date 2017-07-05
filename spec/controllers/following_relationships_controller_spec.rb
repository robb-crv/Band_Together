require 'rails_helper'

RSpec.describe FollowingRelationshipsController, type: :controller do


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
		end
		it 'followings_users should return corrected collection' do 
			expect(@user1.followings_users.include?(@user2)).to eq true

		end

	end

	describe 'following_relationships#destroy' do
		
		it 'should destroy a record in following relationship' do 
			expect {
	  			
	  			post :destroy
	  			
  			}.to change(FollowingRelationship, :count).by(-1)
		end
		
		it 'should delete the relationship' do 
			expect(@user1.followings_users.include?(@user2)).to eq false
		end
	end 
end
