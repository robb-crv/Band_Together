require 'rails_helper'

RSpec.describe AdvertismentsController, type: :controller do

	login_user



	describe 'advertisments#index' do

		context 'when the user request the index page' do

			it 'the request should be succeed' do
				band= FactoryGirl.create(:band, :band_manager_id => subject.current_user.id)
				advertisment= FactoryGirl.create(:advertisment, :band_id => band.id, :user_id => subject.current_user.id)
				get :index, :id => band.id
				expect(response).to have_http_status(200)
			end

		end

	end

	describe 'advertisments#create' do

  		context 'with valid parameters' do
  			it 'creates a new advertisment' do
					band= FactoryGirl.create(:band, :band_manager_id => subject.current_user.id)
  				expect {
  					post :create , advertisment: FactoryGirl.attributes_for(:advertisment), band_id: band.id
  				}.to change(Advertisment, :count).by(1)

  				#expect(subject.current_user.advertisments).to_not be_empty
  			end
  		end

  		context 'with invalid parameters' do
  			it "doesn't creates a new advertisment" do
	  			expect {
	  				post :create, advertisment: FactoryGirl.attributes_for(:invalid_advertisment), band_id: nil
	  			}.to change(Advertisment, :count).by(0)

  				#expect(subject.current_user.advertisments).to be_empty
  			end
  		end

	end


	describe 'advertisments#show' do

		context 'with valid advertisment id' do
			it 'should render the show page of the advertisment with that id' do
				band= FactoryGirl.create(:band, :band_manager_id => subject.current_user.id)
				advertisment= FactoryGirl.create(:advertisment, :band_id => band.id, :user_id => subject.current_user.id)
				get :show, :id => advertisment.id
				assigns(:advertisment).should eq(advertisment)
			end
		end

		context 'with invalid advertisment id' do
			it 'should render error 404 page not found' do
				band= FactoryGirl.create(:band, :band_manager_id => subject.current_user.id)
				advertisment= FactoryGirl.create(:advertisment, :band_id => band.id, :user_id => subject.current_user.id)

					get :show, :id => "10"
				    expect(response).to redirect_to('/404')
			end
		end
	end

	describe 'advertisments#new' do

		context "when user request the 'new' page" do

			it "the request should succeed"  do
				band= FactoryGirl.create(:band, :band_manager_id => subject.current_user.id)
				get :new, :band_id => band.id
				expect(response).to have_http_status(200)
			end
		end
	end

	describe 'advertisments#edit' do

		context "when user request the 'edit' page for specified advertisment" do

			it "the request should succeed" do
				band= FactoryGirl.create(:band, :band_manager_id => subject.current_user.id)
				advertisment= FactoryGirl.create(:advertisment, :band_id => band.id, :user_id => subject.current_user.id)
				get :edit, :id => advertisment.id
				expect(response).to have_http_status(200)
			end

			it 'and it should render the edit page of the advertisment with that id' do
				band= FactoryGirl.create(:band, :band_manager_id => subject.current_user.id)
				advertisment= FactoryGirl.create(:advertisment, :band_id => band.id, :user_id => subject.current_user.id)
				get :show, :id => advertisment.id
				assigns(:advertisment).should eq(advertisment)
			end

		end
	end

	describe 'advertisments#update' do

		context 'when user insert valid parameters' do

			it "should update the advertisment information" do
				band= FactoryGirl.create(:band, :band_manager_id => subject.current_user.id)
				advertisment= FactoryGirl.create(:advertisment, :band_id => band.id, :user_id => subject.current_user.id)

				post :update, :id => advertisment.id, :advertisment => {:title => "TEST_TITLE", :description => "descr"}
				advertisment.reload
				expect(response).to redirect_to(advertisment_path(:id => advertisment.id))
				expect(advertisment.title).to eq("TEST_TITLE")
			end
		end

		context 'when user insert invalid parameters' do

			it "shouldn't update the advertisment information" do

				band= FactoryGirl.create(:band, :band_manager_id => subject.current_user.id)
				advertisment= FactoryGirl.create(:advertisment, :band_id => band.id, :user_id => subject.current_user.id)

				post :update, :id => advertisment.id, :advertisment => {:title => ""}
				advertisment.reload

				expect(advertisment.title).to_not eq("")
				expect(advertisment.title).to eq("Adv Title")
			end
		end
	end

	describe 'advertisments#delete' do
		before(:each) do
			@band1= FactoryGirl.create(:band, :band_manager_id => subject.current_user.id)
			@adv1= FactoryGirl.create(:advertisment, :band_id => @band1.id, :user_id => subject.current_user.id)
			@adv2= FactoryGirl.create(:advertisment, :band_id => @band1.id, :user_id => subject.current_user.id)

			expect{
        		delete :destroy, :id => @adv1.id
      		}.to change(Advertisment, :count).by(-1)
		end

		it 'should return status 302 (redirection)' do
			expect(response.status).to eq 302
		end

		it 'should delete the advertisment from the band' do

			expect(@band1.advertisment).not_to include(@adv1)
			expect(@band1.advertisment).to include(@adv2)

		end
	end
end
