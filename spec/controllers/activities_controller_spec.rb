require 'rails_helper'

RSpec.describe ActivitiesController, type: :controller do
  login_user


  describe 'activities#new' do

    context "when user request the 'new' page" do
      it "the request should succeed"  do
        band = FactoryGirl.create(:band, band_manager_id: subject.current_user.id)
        params = {:band_id=> band.id }
        get :new, params
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'activities#index' do

    context 'when the user request the index page' do

      it 'the request should be succeed' do
        band = FactoryGirl.create(:band, band_manager_id: subject.current_user.id)

        activity1 = FactoryGirl.create(:activity, band_manager_id: subject.current_user.id, band: band)

        params = {:id=> band.id, format: 'json'}
        get :index, params
        expect(response).to have_http_status(200)
      end

      it 'and it should shows only the chosen band activities' do
        user2 = FactoryGirl.create(:user)
        band1 = FactoryGirl.create(:band, band_manager_id: subject.current_user.id)
        band2 = FactoryGirl.create(:band, band_manager_id: user2.id)

        activity1 = FactoryGirl.create(:activity, band_manager_id: subject.current_user.id, band_id: band1.id)
        activity2 = FactoryGirl.create(:activity, band_manager_id: subject.current_user.id, band_id: band1.id)
        activity3 = FactoryGirl.create(:activity, band_manager_id: user2.id, band_id: band2.id)

        params = {:id=> band1.id, format: 'json'}
        get :index, params
        assigns(:activities).should eq([activity1,activity2])
      end
    end

  end

  describe 'activities#create' do

  		context 'with valid parameters' do
  			it 'creates a new activity' do

          band= FactoryGirl.create(:band, band_manager_id: subject.current_user.id)

  				expect {
            params = {:band_id=> band.id, :activity => FactoryGirl.attributes_for(:activity, band: band, band_manager: subject.current_user )}
  					post :create , params
  				}.to change(Activity, :count).by(1)

  				expect(band.activities).to_not be_empty
  			end
  		end

  		context 'with invalid parameters' do
  			it "doesn't creates a new activity" do
	  			expect {
            params = {:band_id=> nil, :activity => FactoryGirl.attributes_for(:activity, band: nil, band_manager: nil )}
  					post :create , params
	  			}.to change(Band, :count).by(0)

  			end
  		end

	end

  describe 'activities#show' do

		context 'with valid activity id' do
			it 'should render the show page of the activity with that id' do
        band= FactoryGirl.create(:band, band_manager_id: subject.current_user.id)
        activity= FactoryGirl.create(:activity, band_manager_id: subject.current_user.id, band_id: band.id)
        params = {:id=> band.id}
				get :show, params
				assigns(:activity).should eq(activity)
			end
		end

		context 'with invalid activity id' do
			it 'should render error 404 page not found' do
        band= FactoryGirl.create(:band, band_manager_id: subject.current_user.id)
				activity= FactoryGirl.create(:activity, band_manager_id: subject.current_user.id, band_id: band.id)
        params = {:id=> invalid_ids[0]}
        get :show, params
        expect(response).to redirect_to('/404')
			end
		end
	end

  describe 'advertisments#edit' do

		context "when user request the 'edit' page for specified activity" do

			it "the request should succeed" do
        band =  FactoryGirl.create(:band, :band_manager_id => subject.current_user.id)
        activity = FactoryGirl.create(:activity, :band_id => band.id, :band_manager_id => subject.current_user.id)
				get :edit, :id => activity.id
				expect(response).to have_http_status(200)
			end

			it 'and it should render the edit page of the activity with that id' do
        band =  FactoryGirl.create(:band, :band_manager_id => subject.current_user.id)
  			activity = FactoryGirl.create(:activity, :band_id => band.id, :band_manager_id => subject.current_user.id)
				get :show, :id => activity.id
				assigns(:activity).should eq(activity)
			end

		end
	end

	describe 'activities#update' do

		context 'when user insert valid parameters' do

			it "should update the activity information" do
        band =  FactoryGirl.create(:band, :band_manager_id => subject.current_user.id)
  			activity = FactoryGirl.create(:activity, :band_id => band.id, :band_manager_id => subject.current_user.id)

				post :update, :id => activity.id, :activity => {:title => "TEST_TITLE", :description => "descr"}
				activity.reload
				expect(response).to redirect_to(activity_path(activity))
				expect(activity.title).to eq("TEST_TITLE")
			end
		end

		context 'when user insert invalid parameters' do

			it "shouldn't update the activity information" do

        band =  FactoryGirl.create(:band, :band_manager_id => subject.current_user.id)
        activity = FactoryGirl.create(:activity, :band_id => band.id, :band_manager_id => subject.current_user.id)

				post :update, :id => activity.id, :activity => {:title => ""}
				activity.reload

				expect(activity.title).to_not eq("")
			end
		end
	end

	describe 'activities#delete' do
		before(:each) do
			@band1= FactoryGirl.create(:band, :band_manager_id => subject.current_user.id)
			@activity1= FactoryGirl.create(:activity, :band_id => @band1.id, :band_manager_id => subject.current_user.id)
      @activity2= FactoryGirl.create(:activity, :band_id => @band1.id, :band_manager_id => subject.current_user.id)

			expect{
        		delete :destroy, :id => @activity1.id
      		}.to change(Activity, :count).by(-1)
		end

		it 'should return status 302 (redirection)' do
			expect(response.status).to eq 302
		end

		it 'should delete the advertisment from the band' do

			expect(@band1.activities).not_to include(@activity1)
			expect(@band1.activities).to include(@activity2)

		end
	end

end
