require 'rails_helper'

RSpec.describe Advertisment, type: :model do

  	it "has a valid factory" do
      @band_manager = FactoryGirl.create(:user)
      @band = FactoryGirl.create(:band, band_manager_id: @band_manager.id)
  		expect(FactoryGirl.build(:advertisment, user_id: @band_manager.id, band_id: @band.id )).to be_valid
  	end

  	context 'validations' do

  		context 'for title' do

  			it { should validate_presence_of :title}
  			it { should validate_length_of :title}

  			context 'when format is invalid' do

  				invalid_advertisment_titles.each do |title|
  					it { should_not allow_value(title).for(:title) }
  				end
  			end

  			context 'when format is valid' do

  				valid_advertisment_titles.each do |title|
  					it { should allow_value(title).for(:title) }
  				end
  			end
  		end

      context 'for description' do

        it { should validate_presence_of :description}
      end

  	end



end
