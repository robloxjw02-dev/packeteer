local types = require("./types")
export type WriterData = types.WriterData
export type DataType<T> = types.DataType<T>
export type StructDefinition = types.StructDefinition
export type Packet<T> = types.Packet<T>

local array = require("./dataTypes/array")
local bool = require("./dataTypes/bool")
local buff = require("./dataTypes/buff")
local cframe = require("./dataTypes/cframe")
local float32 = require("./dataTypes/float32")
local float64 = require("./dataTypes/float64")
local int16 = require("./dataTypes/int16")
local int32 = require("./dataTypes/int32")
local int8 = require("./dataTypes/int8")
local map = require("./dataTypes/map")
local nothing = require("./dataTypes/nothing")
local optional = require("./dataTypes/optional")
local string = require("./dataTypes/string")
local struct = require("./dataTypes/struct")
local uint16 = require("./dataTypes/uint16")
local uint32 = require("./dataTypes/uint32")
local uint8 = require("./dataTypes/uint8")
local vec2 = require("./dataTypes/vec2")
local vec3 = require("./dataTypes/vec3")

local packet = require("./packet")

return (
    table.freeze({
        define = packet,

        array = array,
        bool = bool(),
        optional = optional,
        uint8 = uint8(),
        uint16 = uint16(),
        uint32 = uint32(),
        int8 = int8(),
        int16 = int16(),
        int32 = int32(),
        float32 = float32(),
        float64 = float64(),
        cframe = cframe(),
        string = string(),
        vec2 = vec2(),
        vec3 = vec3(),
        buff = buff(),
        struct = struct,
        map = map,
        nothing = nothing(),
    }) :: any
) :: types.Packeteer