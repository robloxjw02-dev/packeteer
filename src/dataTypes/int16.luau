local bufferWriter = require("../writer")
local types = require("../types")

local i16 = bufferWriter.i16

local int16 = {
	write = i16,

	read = function(b: buffer, cursor: number)
		return buffer.readi16(b, cursor), 2
	end,
}

return function(): types.DataType<number>
	return int16
end