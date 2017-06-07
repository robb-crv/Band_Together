class MemberAssociation < ApplicationRecord
  belongs_to :user
  belongs_to :joined_band, class_name: "Band", foreign_key: "joined_band_id"
  
end
