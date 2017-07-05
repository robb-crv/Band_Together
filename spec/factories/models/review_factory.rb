FactoryGirl.define do
	factory :review do
		reviewer_id 	Faker::Number.number(2)
		reviewable_id		Faker::Number.number(2)
		reviewable_type "User"
		rating          4
		description    "description"
	end

end
