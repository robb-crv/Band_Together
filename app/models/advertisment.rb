class Advertisment < ApplicationRecord
	
	#association
	belongs_to :users
	belongs_to :bands

	#validation

	validates :title, presence: true
	validates :description, presence: true, length: {maximum: 300}
	validates_date :start_date, presence: true 
	validates_date :term_date, presence: true
end
