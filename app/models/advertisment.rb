class Advertisment < ApplicationRecord
	
	belongs_to :users
	validates :title, presence: true
	validates :description, presence: true, length: {maximum: 300}
	validates :start_date, presence: true 
	validates :term_date, presence: true
end
