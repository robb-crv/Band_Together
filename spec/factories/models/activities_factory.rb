FactoryGirl.define do

	factory :activity do
    title           "Prove"
    description     "Sala prove"
    location        Faker::Address.street_address
    accessibility   "Private"
    start_date      {Faker::Date.forward(1000)}
    duration        Faker::Number.between(1, 24)

    band_id         1
    band_manager_id 1
	end


  factory :invalid_activity, parent: :activity do
    title           nil
    description     nil
    location        nil
    accessibility   nil
    start_date      nil
    duration        nil

    band_id         nil
    band_manager_id nil
	end
end
