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
    		assigns(:createdBands).should match_array(band1)
  	end
  end

  describe "GET #index" do
     it 'should render all Users' do
        get :index
        assigns(:users).should match_array(subject.current_user)
    end
  end

  describe "GET #events" do
    it 'should get the interesting activities' do
        band1 = FactoryGirl.create(:band, band_manager_id: subject.current_user.id)
        activity = FactoryGirl.create(:activity,band: band1, band_manager: subject.current_user)
        get :events, format: :json
        assigns(:activities).should match_array(activity)
    end
  end

  describe "GET #home" do
     it 'should get the interesting advertisment' do
       band1 = FactoryGirl.create(:band, band_manager_id: subject.current_user.id)
       adv = FactoryGirl.create(:advertisment,band: band1, user: subject.current_user)
       FollowingRelationship.create(follower_id: subject.current_user.id, followable_id: band1.id, followable_type: "Band")
       get :home
       assigns(:interesting_advertisments).should match_array(adv)
     end
    
  end

  describe "GET #edit_profile_informations" do
     it 'should get the current user' do
       get :edit_profile_informations
      assigns(:user).should eq(subject.current_user)
     end
     
  end

  describe "POST #update_profile_informations" do
    it "should update the user information" do

        post :update_profile_informations, :user => {:first_name => "Andrea", :last_name => "Rossi"}
        subject.current_user.reload
        expect(response).to redirect_to(users_show_path(:id => subject.current_user.id))
        expect(subject.current_user.first_name).to eq("Andrea")
        expect(subject.current_user.last_name).to eq("Rossi")
      end
  end

end
