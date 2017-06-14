module AdvertismentHelper

	def musicians_sym
		m= []
		TypeOfMusician.all.each do |elem|
			if elem[:id] != 0
				m << elem[:name].parameterize.underscore.to_sym
			end
		end
		return m
	end
	
end
