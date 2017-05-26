FactoryGirl.define do 
	factory :band do
		name             "Band's Name"
		description      "Band's description"
		musical_genre    "Rock"
	end

	factory :invalid_band, parent: :band do
		name               nil
		description        nil
		band_manager_id    nil
	end
end