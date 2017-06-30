class FollowingRelationship < ApplicationRecord

	belongs_to :followable, polymorphic: true, foreign_key: 'followable_id'
	belongs_to :follower, class_name: "User", foreign_key: 'follower_id'

	validate :user_does_not_follow_self
	validates :follower_id, presence: true
	validates :followable_id, presence: true
	validates :followable_type, presence: true

	def user_does_not_follow_self

		if (followable_type == 'User') and (follower_id == followable_id)
			errors.add(:followable_id, "Can't follows itself")
		end
  	end	

end
