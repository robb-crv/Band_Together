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
				FactoryGirl.create(:join_request, :req_type => "request", :sender_id => @user2.id, :receiver_id => @user1.id, :band_id => @band.id, :pending => true)
	  		}.to change(JoinRequest, :count).by(1)

	  		expect(@user2.is_waiting_for_join_response(@band))

		end
	
	end



	describe 'JoinRequest#accept' do 
		
		it ' should accept the request' do
			
			@rel = FactoryGirl.create(:join_request, req_type:  "request" , sender_id: @user2.id, receiver_id: @user1.id, band_id: @band.id, pending: true )
			
			expect {
				params = {:sender_id => @user2.id, :receiver_id => @user1.id, :band_id => @band.id}
				post :accept, params
				@rel.reload
			}.to change(MemberAssociation, :count).by(1)
		
			expect(@rel.pending).to eq false
			expect(@user1.is_waiting_for_join_response(@band)).to eq false
		end
	end

	describe 'JoinRequest#decline' do 
		
		it ' should decline the request' do
			
			@rel = FactoryGirl.create(:join_request, req_type:  "request", sender_id: @user2.id, receiver_id: @user1.id, band_id: @band.id, pending: true )
			
			post :decline, sender_id: @user2.id, receiver_id: @user1.id, band_id: @band.id
			@rel.reload
		
			expect(@rel.pending).to eq false
			expect(@user1.is_waiting_for_join_response(@band)).to eq false
		end
		

	end	
	
end
