require 'rails_helper'

RSpec.describe ConversationsController, type: :controller do

  login_user


  describe 'GET conversations#new' do

		context 'when the user request the new page' do

			it 'the request should be succeed' do
				get :new
				expect(response).to have_http_status(200)
			end

      it 'and it should load only the current user bands' do
				user2 = FactoryGirl.create(:user)
				band1 = FactoryGirl.create(:band, band_manager_id: subject.current_user.id)
				band2 = FactoryGirl.create(:band, band_manager_id: subject.current_user.id)
		    band3 = FactoryGirl.create(:band, band_manager_id: user2.id)
	      get :new
	      assigns(:bands).should eq([band1,band2])
			end


      it 'and it should load only the current user inbox conversations' do
        user2 = FactoryGirl.create(:user)
        user3 = FactoryGirl.create(:user)

        conversation1 = subject.current_user.send_message(user2, "ciao", "come stai?").conversation
        conversation2 = user3.send_message(subject.current_user, "eih", "come stai?").conversation
        conversation3 = user3.send_message(user2, "come va?", "come stai?").conversation

        get :new
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

  describe 'POST conversations#create' do

    context 'with valid parameters' do

      it 'should create a new conversation for user and send notification to the user' do
        user2 = FactoryGirl.create(:user)

        expect {
          post :create ,conversation: { band: nil, recipients: [user2], subject: "Ciao", body: "Come stai?" }
        }.to change(Mailboxer::Conversation, :count).by(1)

        expect(subject.current_user.mailbox.sentbox).to_not be_empty
        expect(Notification.where(recipient: user2)).to_not be_empty
      end

      it 'should create a new conversation for band and send notifications to the members' do
        user2 = FactoryGirl.create(:user)
        user3 = FactoryGirl.create(:user)

        band = FactoryGirl.create(:band, band_manager: subject.current_user)

        FactoryGirl.create(:member_association, user: user2, joined_band: band)
        FactoryGirl.create(:member_association, user: user3, joined_band: band)

        expect {
          post :create ,conversation: { band: band, recipients: [], subject: "Ciao", body: "Come state?" }
        }.to change(Mailboxer::Conversation, :count).by(1)

        expect(subject.current_user.mailbox.sentbox).to_not be_empty
        expect(user2.mailbox.inbox).to_not be_empty
        expect(user3.mailbox.inbox).to_not be_empty
        expect(Notification.where(recipient: user2)).to_not be_empty
        expect(Notification.where(recipient: user3)).to_not be_empty
        expect(band.conversations).to_not be_empty
      end


    end

    context 'with invalid parameters' do
      it "should not create a new conversation" do
        expect {
          post :create, conversation: { band: nil, recipients: nil, subject: nil, body: nil }
        }.to change(Mailboxer::Conversation, :count).by(0)

          expect(subject.current_user.mailbox.sentbox).to be_empty

      end
    end

	end

  describe 'GET conversations#show' do

    context 'when the user request the show page' do

      before(:each) do
        @user2 = FactoryGirl.create(:user)
        @conversation = subject.current_user.send_message(@user2, "ciao", "come stai?").conversation
      end

      it 'the request should be succeed' do
        get :show , :id => @conversation.id , :folder => "inbox"
        expect(response).to have_http_status(200)
      end

      it 'and it should load only the current user bands' do
        user2 = FactoryGirl.create(:user)
        band1 = FactoryGirl.create(:band, band_manager_id: subject.current_user.id)
        band2 = FactoryGirl.create(:band, band_manager_id: subject.current_user.id)
        band3 = FactoryGirl.create(:band, band_manager_id: user2.id)

        get :show , :id => @conversation.id , :folder => "inbox"
        assigns(:bands).should eq([band1,band2])
      end

      it 'and it should mark as read the conversation' do
        get :show , :id => @conversation.id , :folder => "inbox"
        expect(@conversation.is_read?(subject.current_user)).to eq(true)
      end


    end

  end


  describe 'POST conversations#reply' do

    context 'with valid parameters' do

      it 'should reply to conversation and send notification to the user' do
        user2 = FactoryGirl.create(:user)

        conversation = user2.send_message(subject.current_user, "ciao", "come stai?").conversation

        expect {
          post :reply , id: conversation.id, message: { subject: "ciao", body: "Tutto bene" }
        }.to change( Mailboxer::Message.conversation(conversation),:count).by(1)

        expect(Notification.where(recipient: user2)).to_not be_empty
      end

    end

    context 'with invalid parameters' do

      it 'should not reply to conversation' do

        user2 = FactoryGirl.create(:user)
        conversation = user2.send_message(subject.current_user, "ciao", "come stai?").conversation

        expect {
          post :reply , id: conversation.id, message: { subject: nil, body: nil }
        }.to change( Mailboxer::Message.conversation(conversation),:count).by(0)
      end

    end

  end



    describe 'POST conversations#trash' do

      context 'when user request to trash conversation' do

        before(:each) do
          @user2 = FactoryGirl.create(:user)
          @conversation = @user2.send_message(subject.current_user, "ciao", "come stai?").conversation
        end

          it 'should trash the conversation' do
            post :trash , id: @conversation.id
            expect( @conversation.is_trashed?(subject.current_user) ).to eq true
          end

      end

    end

    describe 'POST conversations#untrash' do

      context 'when user request to untrash conversation' do

        before(:each) do
          @user2 = FactoryGirl.create(:user)
          @conversation = @user2.send_message(subject.current_user, "ciao", "come stai?").conversation
          @conversation.move_to_trash(subject.current_user)
        end

          it 'should untrash the conversation' do
              post :untrash , id: @conversation.id
              expect( @conversation.is_trashed?(subject.current_user) ).to eq false
          end

      end

    end





end
