require 'rails_helper'

RSpec.describe BandController, type: :controller do

	login_user

	describe 'band#index' do

		context 'when the user request the index page' do

			it 'the request should be succeed' do
				get :index
				expect(response).to have_http_status(200)
			end

			it 'and it should shows only the current user bands' do
				user2 = FactoryGirl.create(:user)
				band1 = FactoryGirl.create(:band, band_manager_id: subject.current_user.id)
				band2 = FactoryGirl.create(:band, band_manager_id: subject.current_user.id)
		      	band3 = FactoryGirl.create(:band, band_manager_id: user2.id)
	      		get :index
	      		assigns(:bands).should eq([band1,band2])
			end
		end

	end

	describe 'band#create' do

  		context 'with valid parameters' do
  			it 'creates a new band' do

  				expect {
  					post :create , band: FactoryGirl.attributes_for(:band)
  				}.to change(Band, :count).by(1)

  				expect(subject.current_user.bands).to_not be_empty
  			end
  		end

  		context 'with invalid parameters' do
  			it "doesn't creates a new band" do
	  			expect {
	  				post :create, band: FactoryGirl.attributes_for(:invalid_band)
	  			}.to change(Band, :count).by(0)

  				expect(subject.current_user.bands).to be_empty
  			end
  		end

	end


	describe 'band#show' do

		context 'with valid band id' do
			it 'should render the show page of the band with that id' do
				band= FactoryGirl.create(:band)
				get :show, :id => band.id
				assigns(:band).should eq(band)
			end
		end

		context 'with invalid band id' do
			it 'should render error 404 page not found' do
				band= FactoryGirl.create(:band)

				expect{
					get :show, :id => "10"
				}.to raise_error(ActiveRecord::RecordNotFound)
			end
		end
	end

	describe 'band#new' do

		context "when user request the 'new' page" do
			it "the request should succeed"  do
				get :new
				expect(response).to have_http_status(200)
			end
		end
	end

	describe 'band#edit' do

		context "when user request the 'edit' page for specified band" do

			it "the request should succeed" do
				band= FactoryGirl.create(:band)
				get :edit, :id => band.id
				expect(response).to have_http_status(200)
			end

			it 'and it should render the edit page of the band with that id' do
				band= FactoryGirl.create(:band)
				get :show, :id => band.id
				assigns(:band).should eq(band)
			end

		end
	end

	describe 'band#update' do

		context 'when user insert valid parameters' do

			it "should update the band information" do
				band= FactoryGirl.create(:band)

				post :update, :id => band.id, :band => {:name => "ModifiedName", :description => "descr"}
				band.reload
				expect(response).to redirect_to(band_show_path(:id => band.id))
				expect(band.name).to eq("ModifiedName")
			end
		end

		context 'when user insert invalid parameters' do

			it "shouldn't update the band information" do

				band= FactoryGirl.create(:band)

				post :update, :id => band.id, :band => {:name => ""}
				band.reload

				expect(band.name).to_not eq("")
				expect(band.name).to eq("Band's Name")
			end
		end
	end

	describe 'band#delete' do

		describe 'advertisment#delete' do
			before(:each) do
				@user= FactoryGirl.create(:user)
				@band1= FactoryGirl.create(:band, :band_manager_id => @user.id)
				@band2= FactoryGirl.create(:band, :band_manager_id => @user.id)

				expect{
	        		delete :destroy, :id => @band1.id
	      		}.to change(Band, :count).by(-1)
				end

				it 'should return status 302 (redirection)' do
					expect(response.status).to eq 302
				end

				it 'should delete the advertisment from the band' do

					expect(@user.bands).not_to include(@band1)
					expect(@user.bands).to include(@band2)

				end
			end
	end


end
