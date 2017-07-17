class JoinRequest < ApplicationRecord

	belongs_to :band, foreign_key: "band_id" 

	belongs_to :sender, class_name: "User", foreign_key: "sender_id"
	belongs_to :receiver, class_name: "User", foreign_key: "receiver_id"


	class UserValidator < ActiveModel::EachValidator
	    def validate_each(record, attribute, value)
	      record.errors.add attribute, "It's not a valid user" unless !User.find_by_id(value).nil?
	    end
  	end

    class BandValidator < ActiveModel::EachValidator
      def validate_each(record, attribute, value)
        record.errors.add attribute, "It's not a valid band" unless !Band.find_by_id(value).nil?
      end
    end

    class TypeValidator < ActiveModel::EachValidator
      def validate_each(record, attribute, value)
        record.errors.add attribute, "It's not a valid type" unless ["request", "invitation"].include? value
      end
    end


	validates :band_id, presence: true, allow_nil: false, band: true
	validates :sender_id, presence: true, allow_nil: false, user: true
	validates :receiver_id, presence: true, allow_nil: false, user: true
	validates :pending, presence: true, allow_nil: false
	validates :req_type, presence: true, allow_nil: false, type: true
	validate :self_sender_receiver
 	validate :exists_member_association
	validate :exists_pending_invitation

	private 

	def exists_pending_invitation
		
		begin 

			@band = Band.find(self.band_id)
			@receiver = User.find(self.receiver_id)
		
		rescue ActiveRecord::RecordNotFound
			return false
		end	
		
		if !@band.pending_invitation(@receiver).empty?
			errors.add(:receiver_id, "user already have a pending request!")
			return false
		else
			return true
		end
	end

	def exists_member_association
		
		if (self.req_type == "request")
			
			@rel = MemberAssociation.where(:user_id => self.sender_id, :joined_band_id => self.band_id) 
			
		elsif (self.req_type == "invitation")

			@rel = MemberAssociation.where(:user_id => self.receiver_id, :joined_band_id => self.band_id)
		end

		if @rel and !@rel.empty?
			errors.add(:receiver_id, "user is already a member!")
			return false
		else 
			return true
		end
	end

	def self_sender_receiver

		errors.add(:sender_id, "sender couldn't be equals to receiver") unless sender_id != receiver_id 
	end
end
