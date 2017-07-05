FactoryGirl.define do
	factory :following_relationship do
		follower_id 	1
		followable_id		2
		followable_type     "User"
	end

	factory :invalid_following_relationship, parent: :following_relationship do
		follower_id 	nil
		followable_id		nil
		followable_type    nil
	end

end