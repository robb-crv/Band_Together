class FollowingRelationship < ApplicationRecord

	belongs_to :followable, polymorphic: true, foreign_key: 'followable_id'
	belongs_to :follower, class_name: "User", foreign_key: 'follower_id'


	class  FollowerValidator < ActiveModel::EachValidator

    	def validate_each(record, attribute, value)
        	record.errors.add attribute, "Not a valid follower" unless !User.find_by_id(value).nil?
     	end
   	end

   	class  TypeValidator < ActiveModel::EachValidator

    	def validate_each(record, attribute, value)
        	record.errors.add attribute, "Not a valid follower" unless ["User", "Band"].include? value
     	end
   	end



	validate :user_does_not_follow_self
	validate :followable_exists
	validates :follower_id, presence: true, allow_nil: false, follower: true
	validates :followable_id, presence: true, allow_nil: false
	validates :followable_type, presence: true, allow_nil: false, type: true


   	private 

   	def followable_exists

   		if (followable_type== 'User')
   			errors.add(:followable_id, "Followable user does not exists") if User.find_by_id(followable_id).nil?
   		elsif (followable_type== 'Band')
   			errors.add(:followable_id, "Followable band does not exists") if Band.find_by_id(followable_id).nil?
   		end
   	end

	def user_does_not_follow_self

		if (followable_type == 'User') and (follower_id == followable_id)
			errors.add(:follower_id, "Can't follows itself")
		end
  	end	

end
