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
	
	validates :band_id, presence: true, allow_nil: false, band: true
	validates :sender_id, presence: true, allow_nil: false, user: true
	validates :receiver_id, presence: true, allow_nil: false, user: true
	validates :pending, presence: true, allow_nil: false
end
