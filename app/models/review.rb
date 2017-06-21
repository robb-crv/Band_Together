class Review < ApplicationRecord

	belongs_to :reviewer, class_name: "User"
	belongs_to :reviewed, class_name: "User"

	validates :reviewer_id, presence: true
	validates :reviewed_id, presence: true
	validates :rating, presence: true,  numericality: { only_integer: true, :greather_than_or_equal_to => 1, :less_than_or_equal_to => 5 }
	validates :description, presence: true, allow_blank: false, length: {maximum: 150}
	validates_uniqueness_of :reviewer_id, scope: :reviewed_id

	validate :does_not_review_self

	#verifica che un untente non recensisca se stesso
	def does_not_review_self
		errors.add(:reviewer_id, "Can't review itself") unless reviewer_id != reviewed_id
	end

end
