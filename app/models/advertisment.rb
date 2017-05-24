class Advertisment < ApplicationRecord
	
	belongs_to :users
	validates :title, presence: true
	validates :description, presence: true, length: {maximum: 300}
	validates_date :start_date, presence: true 
	validates_date :term_date, presence: true
end
