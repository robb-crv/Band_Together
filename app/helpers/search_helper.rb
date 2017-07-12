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
