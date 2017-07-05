require 'rails_helper'

RSpec.describe Band, type: :model do

	before(:each) do

		@band_manager = FactoryGirl.create(:user)
  	end

  	it "has a valid factory" do
  		expect(FactoryGirl.build(:band, band_manager_id: @band_manager.id,  musical_genre_id: "2")).to be_valid
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
  	

	  	context 'for description' do

	  		it { should validate_presence_of :description}
	  		it { should validate_length_of :description}	
	  	end

	    context 'for location' do
				it {should_not allow_value("").for(:nation)}
				it { should validate_length_of :nation }


				context "when nation's format is not valid" do
					invalid_nations.each do |invalid_nation|
						it {should_not allow_value(invalid_nation).for(:nation)}
					end
				end

				context "when nation's format is valid" do
					valid_nations.each do |valid_nation|
						it {should allow_value(valid_nation).for(:nation)}
					end
				end

				it {should_not allow_value("").for(:region)}
				it { should validate_length_of :region }

				context "when region's format is not valid" do
					valid_nations.each do |valid_nation|
						subject { FactoryGirl.build(:band, nation: valid_nation)}
						invalid_regions.each do |invalid_region|
							it { should_not allow_value(invalid_region).for(:region)}
						end
					end
				end

				context "when region's format is valid" do
					subject { FactoryGirl.build(:band, nation: "Andorra")}
					valid_regions.each do |valid_region|
						it { should allow_value(valid_region).for(:region)}
					end
				end

				it {should_not allow_value("").for(:city)}
				it { should validate_length_of :city }

				context "when city's format is not valid" do
						valid_regions.each do |valid_region|
							subject { FactoryGirl.build(:band, nation: "Andorra", region: valid_region)}
							invalid_cities.each do |invalid_city|
								it { should_not allow_value(invalid_cities).for(:city)}
							end
						end
				end

				context "when city's format is valid" do
					subject { FactoryGirl.build(:band, nation: "Italy" , region: "Latium")}
					valid_cities.each do |valid_city|
						it { should allow_value(valid_city).for(:city)}
					end
				end
		end

		context 'for band_manager_id' do 

			it { should_not allow_value(2).for(:band_manager_id) }

		end

	  	context 'for musical genre' do

	  		context 'when format is valid' do

	  			valid_genre.each do |genre|
	  				
	  				tmp= MusicalGenre.where(:name => genre.to_s)[0].id
	  				
	  				it { should allow_value(tmp).for(:musical_genre_id) }
	  			end
	  		end

	  		context 'when format is invalid' do
	  			
	  			invalid_genres.each do |genre|
	  				
	  				it {expect(MusicalGenre.where(:name => genre.to_s)).to eq [] }
	  				
	  			end
	  		end
	  	end
  	end

end
