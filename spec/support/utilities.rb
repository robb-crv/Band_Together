#Invalid cases

#USER

def invalid_usernames
	["$%&/", "dotto93&", "Al&ss4ndro", "+G1g10.%_+", "---/---", "^w^v^", "2^4", "&Beast", "\__A__/", " G0/\/G0l0", "Gigio Gigi", "BiagioigaiB ", "  2  "]
end

def invalid_emails
	["@gmail.com", "Arubagmail.com", "magn@magna", "xael93@g_mail.com", "xael93@gmail.c_om", "$BigMoney$@cash.com", "xxxemail@p@xxerell@.smack", "360_No_scope@biatch.£0£"]
end

def invalid_names
	["O'o'Donnell", "-De-Martino", " Bimbi", "Al_Pacino", "Martin-O'hara", "Bell&"]
end

def invalid_genders
	%w[aba foo m f &]
end

def invalid_types
	%w[batterista Flauto afgfag FIATI]
end

def invalid_genres
	%w[rock Samba afgfag poP]
end

def invalid_dates
	["1897-1-1", "2138-1-1"]
end

def invalid_nations
	%w[Bimbo Pippo 2345 azkabahn &ert4]
end

def invalid_regions
	%w[Alsace Aragon Brandeburg]
end

def invalid_cities
	%w[Latina Bongo Ciccio]
end


#BAND

def invalid_band_names
	["", " ", " Band", "  "]
end

#ADVERTISMENT

def invalid_advertisment_titles
	["", " ", " Cercasi", "  "]
end

#Notification

def invalid_ids
	[50000,1200000,6525]
end



def invalid_read_at_date
	Faker::Date.forward(1000)
end


def invalid_notifiable_types
	["Dog","Cat"]
end


#Activity

def invalid_accessibilities
	["Home","School","Quarter"]
end

def invalid_start_dates
	["dssdfsdf",Faker::Date.backward(1000),Date.current]
end



#Valid cases

def valid_usernames
	["Aligi", "SuPeRcIcCiO", "aaaaaaaaa", "AAAAAAAA", "gigiettO", "1993", "19Ale93", "1stupido", "Beas7", "++++++", "+XaeL+", "Super+", "------", "......", "________", "T____T",
		"M__M__M", ".Berta", "Berta.", "tapu.LELE", "-Dash", "Smash-Bros", "ces-", "_Alfa", "Rovine_"]
end

def valid_emails
	["xael93@gmail.com", "Super_Ciccio93.Champion-zio+@gmail.46-48.com.33"]
end

def valid_names
	["O'Donnel", "Amarelli", "De Cecco", "Martin-Pescatore"]
end

def valid_dates
	["1900-1-1", Date.current, "1945-4-21"]
end

def valid_nations
	%w[Italy Andorra Armenia]
end

def valid_regions
	%w[Canillo Encamp Ordino]
end

def valid_cities
	%w[Rome Latina Frosinone]
end

def valid_genders
	%w[M F]
end

#BAND

def valid_band_names
	["Band01", "BBBB", "Band 01", "@rock'n_rool", "BaNd01", "BbBb"]
end

def valid_genre
	["Rock", "Metal", "Jazz", "Blues", "Pop", "Classic", "Latin"]
end

def valid_types
	["Singer", "Drummer", "Lead guitarist"]
end



#ADVERTISMENT

def valid_advertisment_titles
	["Cercasi", "Cercasi Batterista", "CercasiBatterista", "cErCaSi BatTeRiStA"]
end



#Notification

def valid_read_at_date
	Faker::Date.backward(1000)
end

def valid_notifiable_types
	["User","Mailboxer::Conversation"]
end


#Activity

def valid_accessibilities
	["Private","Public"]
end

def valid_start_dates
	[Faker::Date.forward(1000),Faker::Date.forward(1000),Faker::Date.forward(1000)]
end
