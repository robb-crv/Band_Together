FactoryGirl.define do

	factory :join_request do
		
		sender_id     1
		receiver_id   2
		band_id       1
		req_type	  "request"
		pending       true
	end
end