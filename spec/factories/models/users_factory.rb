FactoryGirl.define do
	factory :user do
		username			{Faker::Internet.user_name}
		email				{Faker::Internet.unique.email}
		password            {Faker::Internet.password(6,20)}
		first_name			{Faker::Name.first_name}
		last_name			{Faker::Name.last_name}
		birth				{Faker::Date.backward(1000)}
		type_of_musician_id "2"
		musical_genre_id 	"2"
		nation   			"Italy"
		region              "Veneto"
		city 					"Venice"
		gender   			"M"
	end

	factory :invalid_user, parent: :user do
		email 				nil
		banned 				true
	end

	factory :admin, parent: :user do
		username			"Admin"
		email				"admin@email.com"
		password			"admin1"
		admin_role			true
	end

	factory :band_manager, parent: :user do
		band_manager_role true
	end

	factory :band_member, parent: :user do
		band_member_role true
	end
end
