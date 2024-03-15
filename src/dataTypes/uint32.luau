local bufferWriter = require("../writer")
local types = require("../types")

local u32 = bufferWriter.u32

local uint32 = {
	write = u32,

	read = function(b: buffer, cursor: number)
		return buffer.readu32(b, cursor), 4
	end,
}

return function(): types.DataType<number>
	return uint32
end
