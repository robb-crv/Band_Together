class Band < ApplicationRecord

	belongs_to :user

	validates :name, presence: true
	validates :description, presence: true
	validates :musical_genre, presence: true
end
