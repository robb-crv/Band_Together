require 'rails_helper'

RSpec.describe BandController, type: :controller do

	describe 'bands#index' do 

		login_user

		it "I should have a current_user" do
    		expect(subject.current_user).to_not eq(nil)
  		end


		it 'GET band#index should shows only the current user bands' do
			user2 = FactoryGirl.create(:user)
			band1 = FactoryGirl.create(:band, band_manager_id: subject.current_user.id)
			band2 = FactoryGirl.create(:band, band_manager_id: subject.current_user.id)
	      	band3 = FactoryGirl.create(:band, band_manager_id: user2.id)			 
      		get :index
      		assigns(:bands).should eq([band1,band2])		
		end
		
	end

	describe 'band#create' do 

		band1= FactoryGirl.create(:band)

		it 'GET band#show should show the band with the specified id' do
			get :show

			assigns(:band).should eq(nil)
		end
	end
end
