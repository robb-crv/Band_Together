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


	private 

	def self_sender_receiver

		errors.add(:sender_id, "sender couldn't be equals to receiver") unless sender_id != receiver_id 
	end
end
