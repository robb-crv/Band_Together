require 'rails_helper'

RSpec.describe Band, type: :model do
  	
  	it "has a valid factory" do 
  		expect(FactoryGirl.build(:band)).to be_valid
  	end

  	context 'validations' do 

  		context 'for name' do

  			it { should validate_presence_of :name}
  			it { should validate_length_of :name}

  			context 'when format is invalid' do 

  				invalid_band_names.each do |name|
  					it { should_not allow_value(name).for(:name) }
  				end
  			end

  			context 'when format is valid' do

  				valid_band_names.each do |name|
  					it { should allow_value(name).for(:name) }
  				end
  			end
  		end
  	end

  	context 'for description' do 

  		it { should validate_presence_of :description}
  	end

  	context 'for musical genre' do

  		it {should validate_presence_of :musical_genre}

  		context 'when format is valid' do 
  			valid_genre.each do |genre|
  				it { should allow_value(genre).for(:musical_genre)}
  			end
  		end

  		context 'when format is invalid' do 
  			invalid_genres.each do |genre|
  				it {should_not allow_value(genre).for(:musical_genre)}
  			end
  		end
  	end
end
