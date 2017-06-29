require 'rails_helper'

RSpec.describe NotificationsController, type: :controller do

  login_user

  describe 'notification#index' do

		context 'when the user request the index page' do

			it 'the request should be succeed' do
				get :index
				expect(response).to have_http_status(200)
			end

			it 'and it should shows only the current user notifications' do
				user2 = FactoryGirl.create(:user)

				notification1 = FactoryGirl.create(:notification, recipient_id: subject.current_user.id)
				notification2 = FactoryGirl.create(:notification, recipient_id: subject.current_user.id)
        notification3 = FactoryGirl.create(:notification, recipient_id: user2.id)
	      get :index
	      assigns(:notifications).should eq([notification1,notification2])
			end
		end
	end

  describe 'notification#destroy' do

			before(:each) do
        @actor =  FactoryGirl.create(:user)
				@notification= FactoryGirl.create(:notification, recipient_id: subject.current_user.id, actor: @actor, notifiable: @actor)

				expect{
	        		delete :destroy, :id => @notification.id
	      		}.to change(Notification, :count).by(-1)
				end

				it 'should return status 302 (redirection)' do
					expect(response.status).to eq 302
				end

	end

  describe 'notification#mark_as_read' do

    it 'should set read_at to current date' do
      @actor =  FactoryGirl.create(:user)
      @notification= FactoryGirl.create(:notification, read_at: nil, recipient_id: subject.current_user.id, actor: @actor, notifiable: @actor)


      expect{
              post :mark_as_read
              @notification.reload
          }.to change(@notification, :read_at)


      end

    end


end
