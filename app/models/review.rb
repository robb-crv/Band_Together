class Review < ApplicationRecord

	belongs_to :reviewable, polymorphic: true, foreign_key: 'reviewable_id'
	belongs_to :reviewer, class_name: 'User', foreign_key: 'reviewer_id'

	class  ReviewerValidator < ActiveModel::EachValidator

    	def validate_each(record, attribute, value)
        	record.errors.add attribute, "Not a valid follower" unless !User.find_by_id(value).nil?
     	end
   	end

   	class  TypeValidator < ActiveModel::EachValidator

    	def validate_each(record, attribute, value)
        	record.errors.add attribute, "Not a valid follower" unless ["User", "Band"].include? value
     	end
   	end




   	validate :user_does_not_review_self
   	validate :reviewable_exists
	validates :reviewer_id, presence: true, allow_nil: false, reviewer: true
	validates :reviewable_id, presence: true, allow_nil: false
	validates :reviewable_type, presence: true, allow_nil: false, type: true
	validates_inclusion_of :rating, :in => 1..5
	validates :rating, presence: true, allow_blank: false, allow_nil: false
	validates :description, presence: true, allow_blank: false, allow_nil: false, length: {maximum: 200}
	

	private

	def reviewable_exists
		if (reviewable_type== 'User')
   			errors.add(:reviewable_id, "reviewable user does not exists") if User.find_by_id(reviewable_id).nil?
   		elsif (reviewable_type== 'Band')
   			errors.add(:reviewable_id, "reviewable band does not exists") if Band.find_by_id(reviewable_id).nil?
   		end
	end

	def user_does_not_review_self

		if (reviewable_type == 'User') and (reviewable_id == reviewer_id)
			errors.add(:reviewer_id, "Can't reviews itself")
		end
  	end

end
