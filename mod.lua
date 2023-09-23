local dirname = "geodata"

function data()
	return {
		info = {
			minorVersion = 0,
			severityAdd = "NONE",
			severityRemove = "NONE",
			name = ("Real Roads"),
			authors = {
				{
					name = "Redi",
					role = "CREATOR",
					text = "Developer of the mod.",
					steamProfile = "https://steamcommunity.com/id/RediDev/",
					tfnetId = 63204,
				}
			},
			description = "Trying to create a street generator by using OSM Data.",
			tags = {
				"tool",
				"street",
			}
		},
		runFn = function()

		end,
	}
end