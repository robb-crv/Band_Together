class Activity < ApplicationRecord
  belongs_to :band_manager, class_name: "User"
	belongs_to :band, dependent: :destroy





  def end_date
    start_date + (duration).hours
  end


  def url
    "/activities/#{id}"
  end




end
