module RailsAdmin
	module Config
		module Actions
			class BanUserAccount < RailsAdmin::Config::Actions::Base

				register_instance_option :member do 
					true
				end
				
				register_instance_option :visible? do 
					authorized? && bindings[:object].class == User
				end

				register_instance_option :link_icon do
          			'fa fa-ban'
        		end

        		register_instance_option :controller do
        			proc do
        				if @object.banned == false
        					@object.update(banned: true) 
        					flash[:success] = "#{@object.username} is now banned"
        				else
        					@object.update(banned: false)
        					flash[:success] = "#{@object.username} is not banned anymore"
        				end
        				redirect_to back_or_index     				
        			end
        		end
			end
		end
	end
end