local bufferWriter = require("../writer")
local types = require("../types")

local i32 = bufferWriter.i32

local int32 = {
	write = i32,

	read = function(b: buffer, cursor: number)
		return buffer.readi32(b, cursor), 4
	end,
}

return function(): types.DataType<number>
	return int32
end