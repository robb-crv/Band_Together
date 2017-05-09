FactoryGirl.define do
	factory :user do
		username			{Faker::Internet.user_name}
		email				{Faker::Internet.unique.email}
		password            {Faker::Internet.password(6,20)}
		first_name			{Faker::Name.first_name}
		last_name			{Faker::Name.last_name}
		birth				{Faker::Date.backward(1000)}
		type_of_musician 	"Batterista"
		musical_genre 		"Rock"
		nation   			"Italy" 
		region              "Veneto" 
		gender   			"M"
	end

	factory :invalid_user, parent: :user do
		email 				nil		
	end
end