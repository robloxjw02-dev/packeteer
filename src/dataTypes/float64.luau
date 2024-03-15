local bufferWriter = require("../writer")
local types = require("../types")

local f64 = bufferWriter.f64

local float64 = {
	write = f64,

	read = function(b: buffer, cursor: number)
		return buffer.readf64(b, cursor), 8
	end,
}

return function(): types.DataType<number>
	return float64
end