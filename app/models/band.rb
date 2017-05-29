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

	#validation

	validates :name, :presence => true, length: {maximum: 100}, :allow_blank => false
	validates :description, presence: true
	validates :musical_genre, presence: true, genre: true
	

end
