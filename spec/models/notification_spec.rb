require 'rails_helper'

RSpec.describe Notification, type: :model do


  before(:each) do
    @recipient = FactoryGirl.create(:user)
    @actor =  FactoryGirl.create(:user)
  end

  it "has a valid factory" do
    valid_notification = FactoryGirl.build(:notification)
    valid_notification.recipient_id = @recipient.id
    valid_notification.actor_id = @actor.id
    valid_notification.notifiable = @actor
    expect(valid_notification).to be_valid
  end

  context 'validations' do

    context 'for recipient_id' do
      it { should validate_presence_of :recipient_id}

      it {should_not allow_value(invalid_ids[0]).for(:recipient_id)}  #should not be a valid recipient because user doesn't exist with this ID

      it {should allow_value(@recipient.id).for(:recipient_id)} #should be a valid recipient because user does exist with this ID
    end

    context 'for actor_id' do
      it { should validate_presence_of :actor_id}
      it {should_not allow_value(invalid_ids[0]).for(:actor_id)}  #should not be a valid actor because user doesn't exist with this ID
      it {should allow_value(@actor.id).for(:actor_id)} #should be a valid actor because user does exist with this ID
    end

    context 'for action' do
      it { should validate_presence_of :action}
    end


    context 'for read_at' do
      it {should allow_value(nil).for(:read_at)}
      it {should_not allow_value("").for(:read_at)}
      it {should allow_value(valid_read_at_date).for(:read_at)}
      it {should_not allow_value(invalid_read_at_date).for(:read_at)}
    end


    context 'for notifiable' do
      it { should validate_presence_of :notifiable_id}
      it { should validate_presence_of :notifiable_type}

      context 'when type is invalid' do
        invalid_notifiable_types.each do |invalid_notifiable_type|
					it { should_not allow_value(invalid_notifiable_type).for(:notifiable_type) }
				end
      end

      context 'when type is valid' do
        valid_notifiable_types.each do |valid_notifiable_type|
          it { should allow_value(valid_notifiable_type).for(:notifiable_type) }
        end
      end

      context 'when type is valid but notifiable object do not exist' do
        valid_notifiable_types.each do |valid_notifiable_type|
          subject { FactoryGirl.build(:notification, notifiable_type: valid_notifiable_type)}
					invalid_ids.each do |invalid_id|
						it { should_not allow_value(invalid_id).for(:notifiable_id)}
					end
        end
      end

    end






    end




end
