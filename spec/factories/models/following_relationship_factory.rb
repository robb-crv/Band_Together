FactoryGirl.define do
	factory :following_relationship do
		follower_id 	1
		followed_id		2
	end

	factory :invalid_following_relationship, parent: :following_relationship do
		follower_id 	nil
		followed_id		nil
	end

	factory :invalid_self_following_relationship, parent: :following_relationship do
		follower_id 	1
		followed_id		1
	end
end