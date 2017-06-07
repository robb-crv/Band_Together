FactoryGirl.define do
	factory :band do
		name             "Band's Name"
		description      "Band's description"
		musical_genre_id    "2"
		nation   			"Italy"
		region              "Veneto"
		city 					"Venice"
	end

	factory :invalid_band, parent: :band do
		name               nil
		description        nil
		band_manager_id    nil
		nation   			nil
		region        nil
		city 					nil
	end
end
