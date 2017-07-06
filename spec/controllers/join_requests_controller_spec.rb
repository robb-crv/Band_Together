require 'rails_helper'

RSpec.describe JoinRequestsController, type: :controller do


	before(:each) do 

      @user1 = FactoryGirl.create(:user)
      @user2 = FactoryGirl.create(:user)

      @band = FactoryGirl.create(:band, band_manager_id: @user1.id)

    end

	describe 'JoinRequest#create' do 
		
		it 'should create a record in following relationship' do 
			
			expect {
				params = {:sender_id => @user2, :receiver_id => @user1, :band_id => @band, :pending => true}
	  			post :create , params 
	  		}.to change(JoinRequest, :count).by(1)

	  		expect(@user2.is_waiting_for_join_response(@band))

		end
	
	end



	describe 'JoinRequest#accept' do 
		
		it ' should accept the request' do
			
			@rel = FactoryGirl.create(:join_request, sender_id: @user2.id, receiver_id: @user1.id, band_id: @band.id, pending: true )
			
			post :accept, sender_id: @user2, receiver_id: @user1, band_id: @band
			@rel.reload
		
			expect(@rel.pending).to eq false
			expect(@user1.is_waiting_for_join_response(@band)).to eq false
		end
	end

	describe 'JoinRequest#decline' do 
		
		it ' should decline the request' do
			
			@rel = FactoryGirl.create(:join_request, sender_id: @user2.id, receiver_id: @user1.id, band_id: @band.id, pending: true )
			
			post :decline, sender_id: @user2, receiver_id: @user1, band_id: @band
			@rel.reload
		
			expect(@rel.pending).to eq false
			expect(@user1.is_waiting_for_join_response(@band)).to eq false
		end
		

	end	
	
end
