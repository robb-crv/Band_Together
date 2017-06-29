FactoryGirl.define do
	factory :notification do
		recipient_id		1
		actor_id				2
		notifiable_id		2
		notifiable_type "User"
    read_at         {Faker::Date.backward(1000)}
    action          "Has just sent you a message"
	end


end
