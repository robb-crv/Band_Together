require 'rails_helper'

RSpec.describe ReviewsController, type: :controller do

	login_user

	before(:each) do 

      @user1 = FactoryGirl.create(:user)
      @user2 = FactoryGirl.create(:user)

      @band1 = FactoryGirl.create(:band, band_manager_id: @user1.id)
      @band2 = FactoryGirl.create(:band, band_manager_id: @user1.id)

    end

	describe 'reviews#new' do
		
		context 'when user request "new" page' do
			
			it 'the request should be succeed' do 
				get :new
				expect(response).to have_http_status(302)	
			end
		end
	end

	describe 'reviews#create' do

		
		it 'should create a record in following relationship' do 
				
			expect {
				params = {:reviewable_id => @user2, :reviewable_type => "User", :rating => 5, :description => "test"}
	  			post :create , params 
	  		}.to change(Review, :count).by(1)

	  		expect(subject.current_user.reviewings_users).to include(@user2)
		end	 

	end

	describe 'reviews#destroy' do

		it 'should destroy a record in following relationship' do 

			rel = Review.create(reviewer_id: @user2, reviewable_id: @user2.id, freviewable_type: "User")
			expect {
				params = {:reviewable_id => @user2, :reviewable_type => "User", :rating => 5, :description => "test"}
	  			post :destory , params 
	  		}.to change(Review, :count).by(-1)

	  		expect(subject.current_user.reviewings_users).not_to include(@user2)
		end	 

	end

end
