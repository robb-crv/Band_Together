require 'rails_helper'

RSpec.describe MailboxController, type: :controller do

  login_user

  describe 'mailbox#inbox' do

		context 'when the user request the inbox page' do

			it 'the request should be succeed' do
				get :inbox
				expect(response).to have_http_status(200)
			end

			it 'and it should load only the current user bands' do
				user2 = FactoryGirl.create(:user)
				band1 = FactoryGirl.create(:band, band_manager_id: subject.current_user.id)
				band2 = FactoryGirl.create(:band, band_manager_id: subject.current_user.id)
		    band3 = FactoryGirl.create(:band, band_manager_id: user2.id)
	      get :inbox
	      assigns(:bands).should eq([band1,band2])
			end

      it 'and it should load only the current user inbox conversations' do
        user2 = FactoryGirl.create(:user)
        user3 = FactoryGirl.create(:user)

        conversation1 = subject.current_user.send_message(user2, "ciao", "come stai?").conversation
        conversation2 = user3.send_message(subject.current_user, "eih", "come stai?").conversation
        conversation3 = user3.send_message(user2, "come va?", "come stai?").conversation

        get :inbox
        res = true
        @conversations = [conversation1, conversation2]
        folder  = assigns(:folder)
        folder.each do |c|
          res = @conversations.include? c
        end
	      res.should eq(true)
      end


		end


	end

  describe 'mailbox#trash' do

    context 'when the user request the trash page' do

      it 'the request should be succeed' do
        get :trash
        expect(response).to have_http_status(200)
      end


      it 'and it should load only the current user trash conversations' do
        user2 = FactoryGirl.create(:user)
        user3 = FactoryGirl.create(:user)

        conversation1 = subject.current_user.send_message(user2, "ciao", "come stai?").conversation
        conversation2 = user3.send_message(subject.current_user, "eih", "come stai?").conversation
        conversation3 = user3.send_message(user2, "come va?", "come stai?").conversation

        conversation1.move_to_trash (subject.current_user)
        get :trash
        folder  = assigns(:folder)
        folder.length.should eq(1)
        folder.first.should eq(conversation1)
      end


    end


  end

end
