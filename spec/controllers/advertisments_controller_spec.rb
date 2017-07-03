require 'rails_helper'

RSpec.describe AdvertismentsController, type: :controller do

	login_user

	describe 'advertisment#index' do

		context 'when the user request the index page' do

			it 'the request should be succeed' do
				band= FactoryGirl.create(:band)
				adv= FactoryGirl.create(:advertisment, :band_id => band.id)
				get :index, :id => band.id
				expect(response).to have_http_status(200)
			end

		end

	end

	describe 'advertisment#create' do

  		context 'with valid parameters' do
  			it 'creates a new advertisment' do

  				expect {
  					post :create , advertisment: FactoryGirl.attributes_for(:advertisment)
  				}.to change(Advertisment, :count).by(1)

  				#expect(subject.current_user.advertisments).to_not be_empty
  			end
  		end

  		context 'with invalid parameters' do
  			it "doesn't creates a new advertisment" do
	  			expect {
	  				post :create, advertisment: FactoryGirl.attributes_for(:invalid_advertisment)
	  			}.to change(Advertisment, :count).by(0)

  				#expect(subject.current_user.advertisments).to be_empty
  			end
  		end

	end


	describe 'advertisment#show' do

		context 'with valid advertisment id' do
			it 'should render the show page of the advertisment with that id' do
				advertisment= FactoryGirl.create(:advertisment)
				get :show, :id => advertisment.id
				assigns(:advertisment).should eq(advertisment)
			end
		end

		context 'with invalid advertisment id' do
			it 'should render error 404 page not found' do
				advertisment= FactoryGirl.create(:advertisment)

				expect{
					get :show, :id => "10"
				}.to raise_error(ActiveRecord::RecordNotFound)
			end
		end
	end

	describe 'advertisment#new' do

		context "when user request the 'new' page" do

			it "the request should succeed"  do

				band= FactoryGirl.create(:band)
				get :new, :band_id => band.id
				expect(response).to have_http_status(200)
			end
		end
	end

	describe 'advertisment#edit' do

		context "when user request the 'edit' page for specified advertisment" do

			it "the request should succeed" do
				advertisment= FactoryGirl.create(:advertisment)
				get :edit, :id => advertisment.id
				expect(response).to have_http_status(200)
			end

			it 'and it should render the edit page of the advertisment with that id' do
				advertisment= FactoryGirl.create(:advertisment)
				get :show, :id => advertisment.id
				assigns(:advertisment).should eq(advertisment)
			end

		end
	end

	describe 'advertisment#update' do

		context 'when user insert valid parameters' do

			it "should update the advertisment information" do
				advertisment= FactoryGirl.create(:advertisment)

				post :update, :id => advertisment.id, :advertisment => {:title => "TEST_TITLE", :description => "descr"}
				advertisment.reload
				expect(response).to redirect_to(advertisment_show_path(:id => advertisment.id))
				expect(advertisment.title).to eq("TEST_TITLE")
			end
		end

		context 'when user insert invalid parameters' do

			it "shouldn't update the advertisment information" do

				advertisment= FactoryGirl.create(:advertisment)

				post :update, :id => advertisment.id, :advertisment => {:title => ""}
				advertisment.reload

				expect(advertisment.title).to_not eq("")
				expect(advertisment.title).to eq("Adv Title")
			end
		end
	end

	describe 'advertisment#delete' do
		before(:each) do
			@band= FactoryGirl.create(:band)
			@adv1= FactoryGirl.create(:advertisment, :band_id => @band.id)
			@adv2= FactoryGirl.create(:advertisment, :band_id => @band.id)

			expect{
        		delete :destroy, :id => @adv1.id
      		}.to change(Advertisment, :count).by(-1)
		end

		it 'should return status 302 (redirection)' do
			expect(response.status).to eq 302
		end

		it 'should delete the advertisment from the band' do

			expect(@band.advertisment).not_to include(@adv1)
			expect(@band.advertisment).to include(@adv2)

		end
	end
end
