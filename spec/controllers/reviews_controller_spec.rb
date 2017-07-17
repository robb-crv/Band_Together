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
				expect(response).to have_http_status(200)	
			end
		end
	end

	describe 'reviews#create' do

		it 'should create a record in following relationship' do 
				
			expect {
				Review.create(:reviewer_id => @user1.id, :reviewable_id => @user2.id, :reviewable_type => "User", :rating => 5, :description => "test")
	   		}.to change(Review, :count).by(1)

	  		expect(@user1.reviewed? @user2).to eq true
		end	 

	end


end
