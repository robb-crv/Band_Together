require 'rails_helper'


RSpec.describe User, type: :model do

	it "has a valid factory" do
		expect(FactoryGirl.build(:user)).to be_valid
	end

	context 'validations' do

		context 'for username' do

			it { should validate_presence_of :username }
			it { should validate_length_of :username }

			context 'when format is invalid' do
				invalid_usernames.each do |invalid_username|
					it { should_not allow_value(invalid_username).for(:username) }
				end
			end

			context 'when format is valid' do
				valid_usernames.each do |valid_username|
					it { should allow_value(valid_username).for(:username) }
				end
			end
		end

		context 'for email' do
			it { should validate_presence_of :email }

			context "the uniqueness" do
				subject { FactoryGirl.build(:user) }
				it { should validate_uniqueness_of(:email).case_insensitive }
			end

			context 'when format is invalid' do
				invalid_emails.each do |invalid_email|
					it { should_not allow_value(invalid_email).for(:email) }
				end
			end

			context 'when format is valid' do
				valid_emails.each do |valid_email|
					it { should allow_value(valid_email).for(:email) }
				end
			end
		end

		context 'for password' do
			it { should validate_presence_of :password }
			it { should validate_length_of :password }
		end

		context 'for first_name and last_name' do

			it {should_not allow_value("").for(:first_name)}
			it { should validate_length_of :first_name }

			it {should_not allow_value("").for(:last_name)}
			it { should validate_length_of :last_name }

			context 'when format is invalid' do
				invalid_names.each do |invalid_name|
					it { should_not allow_value(invalid_name).for(:first_name) }
					it { should_not allow_value(invalid_name).for(:last_name) }
				end
			end

			context 'when format is valid' do
				valid_names.each do |valid_name|
					it { should allow_value(valid_name).for(:first_name) }
					it { should allow_value(valid_name).for(:last_name) }
				end
			end
		end

		context 'for birth' do
			it {should_not allow_value("").for(:birth)}

			context 'when the date is not in the accepted range' do
				invalid_dates.each do |invalid_date|
					it { should_not allow_value(invalid_date).for(:birth) }
				end
			end
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
					subject { FactoryGirl.build(:user, nation: valid_nation)}
					invalid_regions.each do |invalid_region|
						it { should_not allow_value(invalid_region).for(:region)}
					end
				end
			end

			context "when region's format is valid" do
				subject { FactoryGirl.build(:user, nation: "Andorra")}
				valid_regions.each do |valid_region|
					it { should allow_value(valid_region).for(:region)}
				end
			end

			it {should_not allow_value("").for(:city)}
			it { should validate_length_of :city }

			context "when city's format is not valid" do
					valid_regions.each do |valid_region|
						subject { FactoryGirl.build(:user, nation: "Andorra", region: valid_region)}
						invalid_cities.each do |invalid_city|
							it { should_not allow_value(invalid_cities).for(:city)}
						end
					end
			end

			context "when city's format is valid" do
				subject { FactoryGirl.build(:user, nation: "Italy" , region: "Latium")}
				valid_cities.each do |valid_city|
					it { should allow_value(valid_city).for(:city)}
				end
			end
		end

		context 'for gender' do
			it {should_not allow_value("").for(:gender)}
			it { should validate_length_of :gender }

			context 'when format is invalid' do
				invalid_genders.each do |invalid_gender|
					it { should_not allow_value(invalid_gender).for(:gender) }
				end
			end

			context 'when format is valid' do
				valid_genders.each do |valid_gender|
					it { should allow_value(valid_gender).for(:gender) }
				end
			end
		end

		

		context 'for type_of_musician' do

	  		context 'when format is valid' do

	  			valid_types.each do |type|
	  				
	  				tmp = (TypeOfMusician.where(:name => type).first).id
	  				
	  				it { should allow_value(tmp).for(:type_of_musician_id) }
	  			end
	  		end

	  		context 'when format is invalid' do
	  			
	  			invalid_types.each do |type|
	  				
	  				it {expect(TypeOfMusician.where(:name => type.to_s)).to eq [] }
	  				
	  			end
	  		end
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
