class Activity < ApplicationRecord
  belongs_to :band_manager, class_name: "User"
	belongs_to :band, dependent: :destroy

  
end
