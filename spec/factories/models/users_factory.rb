FactoryGirl.define do
	factory :user do
		username			{Faker::Internet.unique.user_name}
		email				{Faker::Internet.unique.email}
		password            {Faker::Internet.password(6,20)}
		first_name			{Faker::Name.first_name}
		last_name			{Faker::Name.last_name}
		birth				"06/06/1990"
		type_of_musician_id 1
		musical_genre_id 	1
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
