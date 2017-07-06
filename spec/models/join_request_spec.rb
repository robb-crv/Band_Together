require 'rails_helper'

RSpec.describe JoinRequest, type: :model do
  
  	before(:each) do 

      @user1 = FactoryGirl.create(:user)
      @user2 = FactoryGirl.create(:user)

      @band = FactoryGirl.create(:band, band_manager_id: @user1.id)

  	end

  context 'validations' do

    	it { should validate_presence_of :sender_id }
      	it { should validate_presence_of :receiver_id }
      	it { should validate_presence_of :band_id }
      	it { should validate_presence_of :pending }

      	context 'for sender_id and receiver_id' do 

      		[0,3,nil].each do |i|

				it {should_not allow_value(i).for(:sender_id)}
				it {should_not allow_value(i).for(:receiver_id)}
			end

			[1,2].each do |i| 
				it {should allow_value(i).for(:sender_id)}
				it {should allow_value(i).for(:receiver_id)}
			end
      	end

      	context "sender_id equals to receiver_id" do 
      		
      		it "doesn't create Join Request" do
      			expect(FactoryGirl.build(:join_request, sender_id: 1, receiver_id: 1, band_id: 1)).not_to be_valid
     		end
     	end 

      
      	context 'for band_id' do
      		
      		[0,2,3,nil].each do |i|

				it {should_not allow_value(i).for(:band_id)}
				it {should_not allow_value(i).for(:band_id)}
			end

			it {should allow_value(1).for(:band_id)} 
      	end

    end
end
