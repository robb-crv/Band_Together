class JoinRequest < ApplicationRecord

	belongs_to :band, foreign_key: "band_id" 
	
	validates :band_id, presence: true, allow_nil: false
	validates :sender_id, presence: true, allow_nil: false
	validates :receiver_id, presence: true, allow_nil: false
end
