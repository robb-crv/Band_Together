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

    		context "when is a User" do 
    			let(:user){FactoryGirl.create(:user)}

    			context "#create ability" do 

    				it {should be_able_to(:create, Band.new)}
    				it {should_not be_able_to(:create, User.new)}
    				it {should_not be_able_to(:create, Advertisment.new)}    				
    			end

    			context "#read ability" do 

    				it {should be_able_to(:read, User.new)}
    				it {should be_able_to(:read, Advertisment.new)}
    				it {should be_able_to(:read, Band.new)}    				
    			end    			

    			context "#update ability" do 

    				context "on himself" do 

    					it{should be_able_to(:update, user)}   					    					
    				end

    				context "on others" do 

    					it {should_not be_able_to(:update, FactoryGirl.create(:user))}    					
    				end    				
    			end

    			context "#destroy ability" do 

    				context "on himself" do 

    					it{should be_able_to(:destroy, user)}   					    					
    				end

    				context "on others" do 

    					it {should_not be_able_to(:destroy, FactoryGirl.create(:user))}    					
    				end    				
    			end
    		end

    		context "when is a Band Manager" do 

    			let(:user){FactoryGirl.create(:band_manager)}
                let(:user2){FactoryGirl.create(:user)}
                 let(:band){FactoryGirl.create(:band,band_manager: user)}
                  let(:band2){FactoryGirl.create(:band,band_manager: user2)}

    			context "#create ability" do 

    				it {should be_able_to(:create, Band.new)}
    				it {should be_able_to(:create, Advertisment.new)}
    				it {should_not be_able_to(:create, User.new)}    				    				
    			end

    			context "#read ability" do 

    				it {should be_able_to(:read, User.new)}
    				it {should be_able_to(:read, Advertisment.new)}
    				it {should be_able_to(:read, Band.new)}    				
    			end    			

    			context "#update ability" do 

    				context "on Users" do 

    					context "on himself" do 

    						it{should be_able_to(:update, user)}   					    					
    					end

    					context "on others" do 

    						it {should_not be_able_to(:update, FactoryGirl.create(:user))}    					
    					end  					
    				end

    				context "on Bands" do 

    					context "on the ones which he created" do 

    						it{should be_able_to(:update, FactoryGirl.create(:band, band_manager_id: user.id))}    						
    					end

    					context "on the ones created by the others" do 
    						it{should_not be_able_to(:update, FactoryGirl.create(:band, band_manager: user2))}    						
    					end    					
    				end

    				context "on Advertisments" do 

    					context "on the ones which he created" do 

    						it{should be_able_to(:update, FactoryGirl.create(:advertisment,band: band, user_id: user.id))}    						
    					end

    					context "on the ones created by the others" do 

    						it{should_not be_able_to(:update, FactoryGirl.create(:advertisment, band: band2, user: user2))}    						
    					end    					
    				end    				    				
    			end

    			context "#destroy ability" do 

    				context "on Users" do 

    					context "on himself" do 

    						it{should be_able_to(:destroy, user)}   					    					
    					end

    					context "on others" do 

    						it {should_not be_able_to(:destroy, FactoryGirl.create(:user))}    					
    					end  					
    				end

    				context "on Bands" do 

    					context "on the ones which he created" do 

    						it{should be_able_to(:destroy, FactoryGirl.create(:band, band_manager_id: user.id))}    						
    					end

    					context "on the ones created by the others" do 

    						it{should_not be_able_to(:destroy, FactoryGirl.create(:band, band_manager: user2))}    						
    					end    					
    				end

    				context "on Advertisments" do 

    					context "on the ones which he created" do 
    						it{should be_able_to(:destroy, FactoryGirl.create(:advertisment,band: band,  user_id: user.id))}    						
    					end

    					context "on the ones created by the others" do 
    						it{should_not be_able_to(:destroy, FactoryGirl.create(:advertisment,user: user2, band: band2))}    						
    					end    					
    				end    				
    			end
    		end

    		context "when is a Band Member" do 

    			let(:user){FactoryGirl.create(:band_member)}

    			context "#create ability" do 

    				it {should be_able_to(:create, Band.new)}
    				it {should_not be_able_to(:create, Advertisment.new)}
    				it {should_not be_able_to(:create, User.new)}    				    				
    			end

    			context "#read ability" do 

    				it {should be_able_to(:read, User.new)}
    				it {should be_able_to(:read, Advertisment.new)}
    				it {should be_able_to(:read, Band.new)}    				
    			end    			

    			context "#update ability" do 

    				context "on Users" do 

    					context "on himself" do 

    						it{should be_able_to(:update, user)}   					    					
    					end

    					context "on others" do 

    						it {should_not be_able_to(:update, FactoryGirl.create(:user))}    					
    					end  					
    				end

    				context "on Bands" do 

    					it{should_not be_able_to(:update, Band.new)}    						   					
    				end

    				context "on Advertisments" do 

    					it{should_not be_able_to(:update, Advertisment.new)}    					
    				end    				    				
    			end

    			context "#destroy ability" do 

    				context "on Users" do 

    					context "on himself" do 

    						it{should be_able_to(:destroy, user)}   					    					
    					end

    					context "on others" do 

    						it {should_not be_able_to(:destroy, FactoryGirl.create(:user))}    					
    					end  					
    				end

    				context "on Bands" do 

    					it{should_not be_able_to(:destroy, Band.new)}    					
    				end

    				context "on Advertisments" do 

    					it{should_not be_able_to(:destroy, Advertisment.new)}    					
    				end    				
    			end
    		end
    	end		
	end	
end