class Band < ApplicationRecord

	include ActiveModel::Validations

	#association
	belongs_to :band_manager, class_name: "User"
	has_many :advertisment, dependent: :destroy, foreign_key: 'band_id'

	has_many :band_conversations, :dependent => :delete_all, :foreign_key => "band_id"
	has_many :conversations, class_name: "Mailboxer::Conversation",  through: :band_conversations

	#andrea association for band member
	has_many :member_associations, :dependent => :delete_all, foreign_key: :joined_band_id, inverse_of: :joined_band
	has_many :users,  through: :member_associations

	has_many :rewiews, as: :reviewable

	has_many :passive_relationships, class_name: "FollowingRelationship", foreign_key: "followable_id", dependent: :destroy
	has_many :followers, through: :passive_relationships, source: :follower, dependent: :destroy

	has_many :join_requests, dependent: :destroy, foreign_key: "band_id", source: :band, dependent: :delete_all

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

		def active_users
			@actives = []

			users.each do |usr|
				@actives << usr
			end

			@actives << band_manager

			@actives
		end


		def self.active_bands_for(user)
			@bands = []
			Band.where(band_manager:user).each do |b|
				@bands << b
			end
			user.joined_bands.each do |b|
				@bands << b
			end
			@bands
		end


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
			nationKey = CS.countries.key(record.nation)
			regionKey = CS.states(nationKey).key(record.region)
			record.errors.add attribute, "Not a valid City" unless CS.get( nationKey ,regionKey ).include? value
		end
	end


	class UserValidator < ActiveModel::EachValidator
		def validate_each(record, attribute, value)
			record.errors.add attribute, "It's not a valid user" unless !User.find_by_id(value).nil?
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
	validates :band_manager_id, presence: true, allow_nil: false, user: true
end
