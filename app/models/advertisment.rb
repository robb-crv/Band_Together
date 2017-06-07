class Advertisment < ApplicationRecord

	#association
	belongs_to :users, foreign_key: "user_id"
	belongs_to :bands, dependent: :destroy, foreign_key: "band_id"

	#validation
	VALID_TITLE_REGEX = /\A[^ ].*\z/ #il titolo non può iniziare con uno spazio
	validates :title, presence: true, length: {maximum: 200}, format: {with: VALID_TITLE_REGEX}, allow_blank: false
	validates :description, presence: true, length: {maximum: 1000}, allow_blank: false
	validates_date :start_date, presence: true
	validates_date :term_date, presence: true,:after => :start_date

end
