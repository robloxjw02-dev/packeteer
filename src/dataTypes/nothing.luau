local types = require("../types")

local nothing = {
	write = function() end,

	read = function()
		return nil, 0
	end,
}

return function(): types.DataType<nil>
	return nothing
end