--!native
--!optimize 2
local writer = require("./writer")
local struct = require("./dataTypes/struct")

return function(definition)
    local serdes = struct(definition)
    local packet = {}

    function packet.serialize(value): buffer
        writer.load({
            buff = buffer.create(0),
            size = 0,
            cursor = 0,
            references = {}
        })

        serdes.write(value)

        local export = writer.export()
        return export.buff
    end

    function packet.deserialize(buff: buffer)
        return serdes.read(buff, 0)
    end

    return packet
end