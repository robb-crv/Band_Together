FactoryGirl.define do
	factory :notification do
    read_at         {Faker::Date.backward(1000)}
    action          "Has just sent you a message"
	end


end
