class Band < ApplicationRecord

	include ActiveModel::Validations

   	class  GenreValidator < ActiveModel::EachValidator

    	def validate_each(record, attribute, value)
      		record.errors.add attribute, "Non è un genere musicale supportato" unless ["Rock", "Metal", "Jazz", "Blues", "Pop", "Classic", "Latin", ""].include? value
    	end
  	end

  	#association
  	belongs_to :band_manager, class_name: "User"
	has_many :advertisment, dependent: :destroy, foreign_key: 'band_id'

	#Validations
	VALID_NAME_REGEX = /\A[^ ].*\z/ #il nome non può iniziare con uno spazio
	validates :name, presence: true, length: {maximum: 100}, format: {with: VALID_NAME_REGEX}
	validates :description, presence: true, length: {maximum: 1000}, allow_blank: false
	validates :musical_genre, length: {maximum: 50}, presence: true, genre: true
	

end
