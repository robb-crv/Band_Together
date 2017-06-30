class Activity < ApplicationRecord

  belongs_to :band_manager, class_name: "User"
	belongs_to :band, dependent: :destroy





  def end_date
    start_date + (duration).hours
  end


  def url
    "/activities/#{id}"
  end



  class BandValidator < ActiveModel::EachValidator
		def validate_each(record, attribute, value)
			record.errors.add attribute, "It's not a valid band" unless !Band.find_by_id(value).nil?
		end
	end

	class UserValidator < ActiveModel::EachValidator
		def validate_each(record, attribute, value)
			record.errors.add attribute, "It's not a valid user" unless !User.find_by_id(value).nil?
		end
	end

  class AccessibilityValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
			record.errors.add attribute, "It's not a valid accessibility" unless ["Private","Public"].include? value
		end
	end


  #Validations
	validates :title, presence: true, length: {maximum: 100}, allow_blank: false, allow_nil: false
	validates :description, presence: true, length: {maximum: 1000}, allow_blank: false, allow_nil: false
  validates :location, presence: true, length: {maximum: 100}, allow_blank: false, allow_nil: false
  validates :accessibility, presence: true, length: {maximum: 100}, accessibility:true, allow_blank: false, allow_nil: false
  validates_date :start_date,presence: true, allow_blank: false, allow_nil: false, :after => lambda{Date.current}
  validates :duration, presence: true,   numericality: { greater_than: 0, less_than_or_equal_to: 24 }, allow_nil: false

  validates :band_id, presence: true, allow_nil:false, band: true
  validates :band_manager_id, presence: true, allow_nil:false, user: true




end
