class TypeOfMusician < ActiveHash::Base
	self.data = [
		{id: 0, name: "Undefined"},
		{id: 1, name: "Drummer"},
		{id: 2, name: "Lead guitarist"},
		{id: 3, name: "Rhythmic guitarist"},
		{id: 4, name: "Bass guitarist"},
		{id: 5, name: "Keyboardist"},
		{id: 6, name: "Singer"},
		{id: 7, name: "Winds"}
	]
end