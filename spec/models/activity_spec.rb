require 'rails_helper'

RSpec.describe Activity, type: :model do


    before(:each) do
      @band_manager = FactoryGirl.create(:user)
      @band =  FactoryGirl.create(:band, band_manager: @band_manager)
    end

    it "has a valid factory" do
      valid_activity = FactoryGirl.build(:activity)
      valid_activity.band = @band
      valid_activity.band_manager = @band_manager
      expect(valid_activity).to be_valid
    end

    context 'validations' do

      context 'for band_id' do
        it { should validate_presence_of :band_id}

        it {should_not allow_value(invalid_ids[0]).for(:band_id)}  #should not be a valid recipient because user doesn't exist with this ID

        it {should allow_value(@band.id).for(:band_id)} #should be a valid recipient because user does exist with this ID
      end

      context 'for band_manager_id' do
        it { should validate_presence_of :band_manager_id}
        it {should_not allow_value(invalid_ids[0]).for(:band_manager_id)}  #should not be a valid actor because user doesn't exist with this ID
        it {should allow_value(@band_manager.id).for(:band_manager_id)} #should be a valid actor because user does exist with this ID
      end

      context 'for title' do
        it { should validate_presence_of :title}
          it { should validate_length_of :title}
            it { should_not allow_value("", nil).for(:title) }
      end


      context 'for description' do
        it { should validate_presence_of :description}
          it { should validate_length_of :description}
          it { should_not allow_value("", nil).for(:description) }
      end

      context 'for location' do
        it { should validate_presence_of :location}
          it { should validate_length_of :location}
          it { should_not allow_value("", nil).for(:location) }
      end

      context 'for accessibility' do
        it { should validate_presence_of :accessibility}
          it { should validate_length_of :accessibility}
          it { should_not allow_value("", nil).for(:accessibility) }

          context 'when accessibility is not valid' do
            invalid_accessibilities.each do |invalid_accessibility|
              it { should_not allow_value(invalid_accessibility).for(:accessibility) }
            end
          end

          context 'when accessibility is valid' do
            valid_accessibilities.each do |valid_accessibility|
              it { should allow_value(valid_accessibility).for(:accessibility) }
            end
          end
      end

      context 'for duration' do
        it { should validate_presence_of :duration}
          it { should_not allow_value( nil).for(:duration) }
            it { should validate_numericality_of :duration }
      end

      context 'for start_date' do
        it { should validate_presence_of :duration}
        it { should_not allow_value( "",nil).for(:duration) }

        context 'when start_date is not valid' do
          invalid_start_dates.each do |invalid_start_date|
            it { should_not allow_value(invalid_start_date).for(:start_date) }
          end
        end

        context 'when start_date is valid' do
          valid_start_dates.each do |valid_start_date|
            it { should allow_value(valid_start_date).for(:start_date) }
          end
        end

      end

    end



end
