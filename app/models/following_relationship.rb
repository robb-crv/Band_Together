class FollowingRelationship < ApplicationRecord

	belongs_to :followed, class_name: "User"
	belongs_to :follower, class_name: "User"

	validate :does_not_follow_self
	validates :follower_id, presence: true
	validates :followed_id, presence: true
	validates_uniqueness_of :follower_id, scope: :followed_id	

	#un record all'interno della tabella FollowingRelationship non può avere 
	#il follower_id uguale al followed_id (un utente non followa se stesso e 
	#non è followato da se stesso)
	def does_not_follow_self
    	errors.add(:followed_id, "Can't follows itself") unless follower_id != followed_id
  	end	

end
