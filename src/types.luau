export type WriterData = {
    size: number,
    cursor: number,
    references: { unknown },
    buff: buffer,
}

-- Used internally for serializing and deserializing all data types
export type DataType<T> = {
    write: (value: T) -> (),
    read: (b: buffer, cursor: number) -> (T, number),
    length: number?,	
}

export type StructDefinition = { [string]: DataType<any> }

export type Packet<T> = {
    serialize: (data: T) -> buffer,
    deserialize: (buff: buffer) -> T,
}

-- Library type
export type Packeteer = {
    define: <T>(definition: T) -> Packet<T>, 

    struct: <T>(format: T) -> T,
    bool: boolean,
    array: <T>(value: T) -> { [number]: T },
    optional: <T>(value: T) -> T?,
    uint8: number,
    uint16: number,
    uint32: number,
    int8: number,
    int16: number,
    int32: number,
    float32: number,
    float64: number,
    string: string,
    vec3: Vector3,
    vec2: Vector2,
    buff: buffer,
    cframe: CFrame,
    map: <K, V>(key: K, value: V) -> { [K]: V },	
}

return nil