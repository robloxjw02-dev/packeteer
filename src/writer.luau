--!native
--!optimize 2

--[[
    Collects all write operations into a queue.
    When the buffer is written, it will be written in the order of the queue.
    
    All operations take in 2 parameters: the cursor and the value.
    Knowing this we can easily attach everything in a nice table, where
    {
        [1] = writer,
        [2] = cursor,
        [3] = value
    }
    
    A lot of these functions just exist as shorthand optimizations.
]]
local types = require("./types")

local current: types.WriterData

local size: number
local cursor: number
local buff: buffer
local references: { [number]: unknown }

local function alloc(bytes: number)
    if not (cursor + bytes >= size) then
        return
    end

    size = math.floor(size * 1.5)

    local newBuffer = buffer.create(size)
    buffer.copy(newBuffer, 0, buff)

    buff = newBuffer
end

local function dyn_alloc(bytes: number)
    while cursor + bytes >= size do
        size = math.floor(size * 1.5)
    end

    local newBuffer = buffer.create(size)
    buffer.copy(newBuffer, 0, buff)

    buff = newBuffer
end

local Writer = {}

Writer.alloc = alloc
Writer.dyn_alloc = dyn_alloc

function Writer.u8(value: number)
    alloc(1)
    buffer.writeu8(buff, cursor, value)
    cursor += 1
end

function Writer.i8(value: number)
    alloc(1)
    buffer.writei8(buff, cursor, value)
    cursor += 1
end

-- this exists solely for the unknown and instance data type. Will likely be obselete soon enough
function Writer.reference(value: any)
    table.insert(references, value)
    local index = #references

    buffer.writeu8(buff, cursor, index)
    cursor += 1
    print(references)
end

function Writer.u16(value: number)
    alloc(2)
    buffer.writeu16(buff, cursor, value)
    cursor += 2
end

function Writer.i16(value: number)
    alloc(2)
    buffer.writeu16(buff, cursor, value)
    cursor += 2
end

function Writer.u32(value: number)
    alloc(4)
    buffer.writeu32(buff, cursor, value)
    cursor += 4
end

function Writer.writestring(value: string)
    buffer.writestring(buff, cursor, value)
    cursor += string.len(value)
end

function Writer.i32(value: number)
    alloc(4)
    buffer.writei32(buff, cursor, value)
    cursor += 4
end

function Writer.f32NoAlloc(value: number)
    buffer.writef32(buff, cursor, value)
    cursor += 4
end

function Writer.f64NoAlloc(value: number)
    buffer.writef64(buff, cursor, value)
    cursor += 4
end

function Writer.f32(value: number)
    alloc(4)
    buffer.writef32(buff, cursor, value)
    cursor += 4
end

function Writer.f64(value: number)
    alloc(8)
    buffer.writef64(buff, cursor, value)
    cursor += 8
end

function Writer.copy(value)
    buffer.copy(buff, cursor, value)
    cursor += buffer.len(value)
end

function Writer.bool(val: boolean)
    alloc(1)
    buffer.writeu8(buff, cursor, if val then 1 else 0)
    cursor += 1
end

function Writer.load(data: types.WriterData)
    if current == data then
            return
        end
    
    current = data
    size = data.size
    cursor = data.cursor
    references = data.references
end

function Writer.export()
    current.size = size
    current.cursor = cursor
    current.references = references
    current.buff = buff

    return current
end

return Writer