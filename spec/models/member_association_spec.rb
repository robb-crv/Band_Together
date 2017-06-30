require 'rails_helper'

RSpec.describe MemberAssociation, type: :model do


  before(:each) do
    @user1 = FactoryGirl.create(:user)
    @user2  = FactoryGirl.create(:user)
    @band =  FactoryGirl.create(:band, band_manager: @user1)
  end

  it "has a valid factory" do
    expect(FactoryGirl.build(:member_association, user: @user2, joined_band: @band)).to be_valid
  end

  context 'validations' do

    it { should validate_presence_of :user_id}
    it { should validate_presence_of :joined_band_id}

    context 'for user foreign key' do
      invalid_ids.each do |invalid_id|
        it { should_not allow_value(invalid_id).for(:user_id) }
      end
    end

    context 'for joined band foreign key' do
      invalid_ids.each do |invalid_id|
        it { should_not allow_value(invalid_id).for(:joined_band_id)}
      end
    end

    it 'should not allow multiple user-band couples' do
      FactoryGirl.create(:member_association, user: @user2, joined_band: @band)
      expect(FactoryGirl.build(:member_association, user: @user2, joined_band: @band)).not_to be_valid
    end


  end

end
