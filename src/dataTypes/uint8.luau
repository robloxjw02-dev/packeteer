local types = require("../types")
local bufferWriter = require("../writer")

local u8 = bufferWriter.u8

local uint8 = {
	write = u8,

	read = function(b: buffer, cursor: number)
		return buffer.readu8(b, cursor), 1
	end,
}

return function(): types.DataType<number>
	return uint8
end