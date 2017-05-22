module Band_Together
	module Admin
		module Actions
			class BanUserAccount < RailsAdmin::Config::Actions::Base

				register_instance_option :member { true }
				
				register_instance_option :visible? { 
					subject = bindings[:object]
					object.is_a? User && !user.banned
				}

				register_instance_option :link_icon {
          			'icon-lock'
        		}

        		register_instance_option :controller {
          			-> { @object.banned = true }
        		}
			end
		end
	end
end