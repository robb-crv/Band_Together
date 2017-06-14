FactoryGirl.define do

	musicians_hash = {:drummer => 1, :bass_guitarist => 1}
	
	factory :advertisment do
		title           "Adv Title"
		description     "Adv descr"
		start_date      {Faker::Date.backward(5)}
		term_date       {Faker::Date.forward(50)}
		musicians       musicians_hash
	end

	factory :invalid_advertisment, parent: :advertisment do
		title            nil
		description      nil
		user_id          nil
		band_id          nil
		musicians		 nil
	end
end
