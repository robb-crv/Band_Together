class FollowingRelationship < ApplicationRecord

	belongs_to :followable, class_name: "User"
	belongs_to :follower, class_name: "User"

	#validate :does_not_follow_self
	validates :follower_id, presence: true
	validates :followable_id, presence: true
	#validates_uniqueness_of :follower_id, scope: :followed_id	

	
	#def does_not_follow_self
    	#errors.add(:followed_id, "Can't follows itself") unless follower_id != followed_id
  	#end	

end
