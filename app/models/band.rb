class Band < ApplicationRecord

	include ActiveModel::Validations

	#association
	belongs_to :band_manager, class_name: "User"
	has_many :advertisment, dependent: :destroy, foreign_key: 'band_id'

	#andrea association for band member
	has_many :member_associations, :dependent => :delete_all, foreign_key: :joined_band_id, inverse_of: :joined_band
	has_many :users,  through: :member_associations

	#SEARCH ENGINE PARAMETER DEFINITIONS

	# Include integration with searchkick
	searchkick word_middle: [:name, :description]

	def search_data
		{
			name: name,
			nation: nation,
			region: region,
			city: city,
			description: description,
			band_manager: band_manager,
			musical_genre_id: MusicalGenre.find_by_id(musical_genre_id).name
		}  	
	end

=begin

	class  GenreValidator < ActiveModel::EachValidator

    	def validate_each(record, attribute, value)
      		record.errors.add attribute, "Not a supported musical genre" unless ["Rock", "Metal", "Jazz", "Blues", "Pop", "Classic", "Latin", ""].include? value
    	end
  	end	
=end

   	

	#Nation validation

	class  NationValidator < ActiveModel::EachValidator

		def validate_each(record, attribute, value)
			 record.errors.add attribute, "Not a valid Nation" unless CS.countries.has_value? value
		end
	end


	#Region validation

	class  RegionValidator < ActiveModel::EachValidator

		def validate_each(record, attribute, value)
		 record.errors.add attribute, "Not a valid Region" unless CS.states(CS.countries.key(record.nation)).has_value? value
		end
	end

	class  CityValidator < ActiveModel::EachValidator

		def validate_each(record, attribute, value)
		 record.errors.add attribute, "Not a valid City" unless CS.cities(CS.states(CS.countries.key(record.nation)).key(record.region),CS.countries.key(record.nation)).include? value
		end
	end



	#Validations
	VALID_NAME_REGEX = /\A[^ ].*\z/ #il nome non può iniziare con uno spazio
	validates :name, presence: true, length: {maximum: 100}, format: {with: VALID_NAME_REGEX}
	validates :description, presence: true, length: {maximum: 1000}, allow_blank: false
	#validates :musical_genre, length: {maximum: 50}, presence: true, genre: true
	validates :nation, allow_blank: false, length: {maximum: 50}, nation: true, allow_nil: true
	validates :region, allow_blank: false, length: {maximum: 50}, allow_nil: true, region: true
  	validates :city, allow_blank: false, length: {maximum: 50}, allow_nil: true, city: true


end
