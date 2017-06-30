require 'rails_helper'

RSpec.describe BandConversation, type: :model do
  before(:each) do
    @user1 = FactoryGirl.create(:user)
    @user2  = FactoryGirl.create(:user)
    @band =  FactoryGirl.create(:band, band_manager: @user1)
    @conversation = @user1.send_message(@user2, "Ciao","Tutto apposto").conversation
  end

  context 'validations' do

    it { should validate_presence_of :conversation_id}
    it { should validate_presence_of :band_id}

    context 'for conversation foreign key' do
      invalid_ids.each do |invalid_id|
        it { should_not allow_value(invalid_id).for(:conversation_id) }
      end
    end

    context 'for joined band foreign key' do
      invalid_ids.each do |invalid_id|
        it { should_not allow_value(invalid_id).for(:band_id)}
      end
    end

    it 'should not allow multiple conversation-band couples' do
      BandConversation.create(conversation: @conversation, band: @band)
      expect(BandConversation.new(conversation: @conversation, band: @band)).not_to be_valid
    end


  end
end
