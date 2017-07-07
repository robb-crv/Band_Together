class MemberAssociation < ApplicationRecord
  belongs_to :user
  belongs_to :joined_band, class_name: "Band", foreign_key: "joined_band_id"


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



  validates :user_id, presence: true, allow_nil: false, user: true
	validates :joined_band_id, presence: true, allow_nil:false, band:true
  validates_uniqueness_of :user_id, scope: :joined_band_id	
end
