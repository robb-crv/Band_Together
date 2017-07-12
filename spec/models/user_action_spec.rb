require 'rails_helper'

RSpec.describe UserAction, type: :model do
 
  before(:each) do
    @user_sender = FactoryGirl.create(:user)
    @band_sender =  FactoryGirl.create(:band, band_manager: @user_sender)
    @user_receiver =  FactoryGirl.create(:user)
    @band_receiver = FactoryGirl.create(:band, band_manager: @user_receiver)
  end


  context 'validations' do

    context 'for sender_id' do
      it { should validate_presence_of :sender_id}

      it {should allow_value(@user_sender.id).for(:sender_id)} #should be a valid recipient because user does exist with this ID
    end

    context 'for receiver_id' do
      it {should allow_value(@user_receiver.id).for(:receiver_id)} #should be a valid actor because user does exist with this ID
    end

    context 'for action' do
      it { should validate_presence_of :action}
    end


end

end
