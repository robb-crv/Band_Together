




	@user1= User.find(1)
	@user2= User.find(2)
	@user3= User.find(3)

	@band = Band.find(1)





@rel = FollowingRelationship.create( follower_id: @user1.id, followable_id: @user2.id, followable_type: "User") 


