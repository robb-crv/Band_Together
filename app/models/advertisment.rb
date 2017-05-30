class Advertisment < ApplicationRecord

	#association
	belongs_to :users, foreign_key: "user_id"
	belongs_to :bands, dependent: :destroy, foreign_key: "band_id"

	#validation

	validates :title, presence: true
	validates :description, presence: true
	validates_date :start_date, presence: true
	validates_date :term_date, presence: true
	
end
