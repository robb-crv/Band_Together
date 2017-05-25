class Band < ApplicationRecord

	include ActiveModel::Validations

   	class  GenreValidator < ActiveModel::EachValidator

    	def validate_each(record, attribute, value)
      		record.errors.add attribute, "Non è un genere musicale supportato" unless ["Rock", "Metal", "Jazz", "Blues", "Pop", "Classic", "Latin", ""].include? value
    	end
  	end


  	belongs_to :band_manager, class_name: "User"
		
	validates :name, presence: true, allow_blank: false
	validates :description, presence: true
	validates :musical_genre, presence: true, genre: true
	

end
