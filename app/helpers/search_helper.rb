module SearchHelper
	#require 'pp'
	def select_options(collection, type)
		value_text = Hash.new
		collection.each do |c|
			case type 
			when 'ads_band_manager'
				value_text[c.user.username] = c.user_id
			when 'ads_band'
				value_text[c.band.name] = c.band_id
			when 'users_nation'
				value_text[c.nation] = c.nation
			when 'users_region'
				value_text[c.region] = c.region
			when 'users_city'
				value_text[c.city] = c.city			
			end	  			  		  		
	  	end
	  	keys = value_text.keys.sort
	  	result = Array.new
	  	keys.each do |k|
	  		result.push [k, value_text[k]]	  		
	  	end
	  	result
  	end
end
