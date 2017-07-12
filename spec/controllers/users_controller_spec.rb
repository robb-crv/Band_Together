require 'rails_helper'

RSpec.describe UsersController, type: :controller do

	login_user

  describe "GET #show" do
    it "returns http success" do
      get :show
      		expect(response).to have_http_status(302)	
    end
    
    it 'should render the show page of the user with that id' do
        band1 = FactoryGirl.create(:band, band_manager_id: subject.current_user.id)
        params = {:id=> subject.current_user.id}
		get :show, params
		assigns(:createdBands).should eq(band1)
	end
  end

  describe "GET #index" do

  end

  describe "GET #events" do
  end

  describe "GET #home" do
  end

  describe "GET #edit_profile_informations" do

  end

  describe "GET #update_profile_informations" do
  end

end
