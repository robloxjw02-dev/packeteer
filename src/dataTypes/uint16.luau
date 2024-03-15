local bufferWriter = require("../writer")
local types = require("../types")

local u16 = bufferWriter.u16

local uint16 = {
	write = u16,

	read = function(b: buffer, cursor: number)
		return buffer.readu16(b, cursor), 2
	end,
}

return function(): types.DataType<number>
	return uint16
end