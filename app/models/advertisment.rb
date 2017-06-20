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
	
#SEARCH ENGINE PARAMETER DEFINITIONS
#Da aggiornare quando sarà finita la form per l'advertisment

	# Include integration with searchkick
	searchkick word_middle: [:title, :description]

	def search_data
		{
			title: title,
			description: description,
			start_date: start_date,
			term_date: term_date,
			band_name: self.band.name
		}	
	end

	#validation
	VALID_TITLE_REGEX = /\A[^ ].*\z/ #il titolo non può iniziare con uno spazio
	validates :title, presence: true, length: {maximum: 200}, format: {with: VALID_TITLE_REGEX}, allow_blank: false
	validates :description, presence: true, length: {maximum: 1000}, allow_blank: false
	validates_date :start_date, presence: true
	validates_date :term_date, presence: true,:after => :start_date
	validates :musicians, presence: true, musicians: true

end
