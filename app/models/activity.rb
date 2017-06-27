class Activity < ApplicationRecord

  belongs_to :band_manager, class_name: "User"
	belongs_to :band, dependent: :destroy





  def end_date
    start_date + (duration).hours
  end


  def url
    "/activities/#{id}"
  end



  #Validations
	validates :title, presence: true, length: {maximum: 100}
	validates :description, presence: true, length: {maximum: 1000}, allow_blank: false
  validates :location, presence: true, length: {maximum: 100}
  validates :accessibility, presence: true, length: {maximum: 100}
  validates_date :start_date, allow_blank: false, allow_nil: true, :after => lambda{Date.current}
  validates :duration, presence: true,   numericality: { greater_than: 0, less_than_or_equal_to: 24 }

  validates :band, presence: true, allow_nil:false
  validates :band_manager, presence: true, allow_nil:false




end
