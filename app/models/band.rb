class Band < ApplicationRecord

	belongs_to :users

	validates :name, presence: true
	validates :description, presence: true
end
