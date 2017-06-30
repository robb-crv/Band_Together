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


  #Validations
	validates :title, presence: true, length: {maximum: 100}
	validates :description, presence: true, length: {maximum: 1000}, allow_blank: false
  validates :location, presence: true, length: {maximum: 100}
  validates :accessibility, presence: true, length: {maximum: 100}
  validates_date :start_date, allow_blank: false, allow_nil: true, :after => lambda{Date.current}
  validates :duration, presence: true,   numericality: { greater_than: 0, less_than_or_equal_to: 24 }

  validates :band, presence: true, allow_nil:false, band: true
  validates :band_manager, presence: true, allow_nil:false, user: true




end
