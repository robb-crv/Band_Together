require 'rails_helper'
require "cancan/matchers"

RSpec.describe Ability, type: :model do 

	describe "User" do 

		describe "abilities" do

    		subject(:ability){ Ability.new(user) }
    		let(:user){ nil }

    		context "when is an Admin" do 
    			let(:user){FactoryGirl.build(:admin)}

    			it {should be_able_to(:manage, User.new)}
    			it {should be_able_to(:manage, Advertisment.new)}
    			it {should be_able_to(:manage, Band.new)}
    			it {should be_able_to(:access, :rails_admin)}    				
    		end

    		#Da modificare quando saranno specificate definitivamente le ability dello user_role

    		context "when is a User" do 
    			let(:user){FactoryGirl.build(:user)}

    			it {should_not be_able_to(:manage, User.new)}
    			it {should_not be_able_to(:manage, Advertisment.new)}
    			it {should_not be_able_to(:manage, Band.new)}
    			it {should_not be_able_to(:access, :rails_admin)}    				
    		end
    	end		
	end	
end