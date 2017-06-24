require 'rails_helper'

RSpec.describe ReviewsController, type: :controller do

	describe 'reviews#new' do
		
		context 'when user request "new" page' do
			
			it 'the request should be succeed' do 
				get :new
				expect(response).to have_http_status(302)	
			end
		end
	end

	describe 'reviews#create' do

		context 'Review is valid' do
			it 'should create a record in following relationship if Review is valid' do 
				
				expect {
	  				post :create , review: FactoryGirl.create(:review) 
	  			}.to change(Review, :count).by(1)
			end	 
		end

		context 'Review is invalid (self review)' do

			it 'should create a record in following relationship if Review is invalid' do 
				begin
				rescue ActiveRecord::RecordInvalid
					expect {
		  				post :create , review: FactoryGirl.create(:invalid_self_review) 
		  			}.to change(Review, :count).by(0)
		  		end
			end	 
		end

		context 'Review is invalid (invalid rating)' do

			it 'should create a record in following relationship if Review is invalid' do 
				begin
					rescue ActiveRecord::RecordInvalid
					expect {
	  					post :create , review: FactoryGirl.create(:invalid_rating_review) 
	  				}.to change(Review, :count).by(0)
	  			end
			end	 
		end		

	end
end
