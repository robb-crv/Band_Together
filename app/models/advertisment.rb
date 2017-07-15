class Advertisment < ApplicationRecord
	serialize :musicians, Hash
	#association
	belongs_to :user, foreign_key: "user_id"
	belongs_to :band, dependent: :destroy, foreign_key: "band_id"

	class MusiciansValidator < ActiveModel::EachValidator
		def validate_each(record, attribute, value)
			ret = false
			value.each do |e|
				if e[1] != '' and e[1] != '0'
					ret = true
				end
			end
			record.errors.add attribute, "choose at least one musicians type" unless ret
		end
	end

	class BandValidator < ActiveModel::EachValidator
		def validate_each(record, attribute, value)
			record.errors.add attribute, "It's not a valid band" unless !Band.find_by_id(value).nil?
		end
	end

	class UserValidator < ActiveModel::EachValidator
		def validate_each(record, attribute, value)
			record.errors.add attribute, "It's not a valid user" unless !User.find_by_id(value).nil?
		end
	end

#SEARCH ENGINE PARAMETER DEFINITIONS
#Da aggiornare quando sarà finita la form per l'advertisment

	# Include integration with searchkick
	searchkick word_start: [:title, :band_name, :band_manager, :ad_genre_name], text_middle: [:description]

	def search_data
		{
			title: title,
			description: description,
			start_date: start_date,
			term_date: term_date,
			band_name: self.band.name,
			band_id: band_id,
			ad_genre_id:self.band.musical_genre_id,
			ad_genre_name: MusicalGenre.find_by_id(self.band.musical_genre_id).name, 
			band_manager: self.user.username,
			band_manager_id: self.user_id
		}
	end
	
	#validation
	VALID_TITLE_REGEX = /\A[^ ].*\z/ #il titolo non può iniziare con uno spazio
	validates :title, presence: true, length: {maximum: 200}, format: {with: VALID_TITLE_REGEX}, allow_blank: false
	validates :description, presence: true, length: {maximum: 1000}, allow_blank: false
	validates_date :start_date, presence: true
	validates_date :term_date, presence: true,:after => :start_date
	validates :musicians, presence: true, musicians: true
	validates :band_id, presence: true, allow_nil: false, band: true
	validates :user_id, presence: true, allow_nil: false, user: true
end
