class MusicalGenre < ActiveHash::Base
	self.data = [
		{id: 0, name: "Undefined"},
		{id: 1, name: "Rock"},
		{id: 2, name: "Metal"},
		{id: 3, name: "Jazz"},
		{id: 4, name: "Blues"},
		{id: 5, name: "Pop"},
		{id: 6, name: "Classic"},
		{id: 7, name: "Latin"}
	]
end