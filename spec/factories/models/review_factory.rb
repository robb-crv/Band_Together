FactoryGirl.define do
	factory :review do
		reviewer_id 	Faker::Number.number(2)
		reviewable_id		Faker::Number.number(2)
		rating          4
		description    "description"
	end

	factory :invalid_self_review, parent: :review do
		reviewer_id 	1
		reviewable_id		1
		rating          4
		description    "description"
	end

	factory :invalid_rating_review, parent: :review do 
		reviewer_id 	Faker::Number.number(2)
		reviewable_id		Faker::Number.number(2)
		rating          6
		description    "description"
	end

end