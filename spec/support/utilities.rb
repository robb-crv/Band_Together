#Invalid cases

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
