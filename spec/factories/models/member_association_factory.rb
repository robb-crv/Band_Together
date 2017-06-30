FactoryGirl.define do
	factory :member_association do
		user_id 	1
		joined_band_id		1
	end

	factory :invalid_member_association, parent: :member_association do
		user_id 	nil
		joined_band_id		nil
	end

end
