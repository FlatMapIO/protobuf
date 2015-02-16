type 
  ProtobufCFieldFlag* {.size: sizeof(cint).} = enum 
    FIELD_FLAG_PACKED = 1, FIELD_FLAG_DEPRECATED = 2

  ProtobufCLabel* {.size: sizeof(cint).} = enum 
    LABEL_REQUIRED, PROTOBUF_C_LABEL_OPTIONAL, 
    LABEL_REPEATED

  ProtobufCType* {.size: sizeof(cint).} = enum 
    TYPE_INT32, PROTOBUF_C_TYPE_SINT32, PROTOBUF_C_TYPE_SFIXED32, 
    TYPE_INT64, PROTOBUF_C_TYPE_SINT64, PROTOBUF_C_TYPE_SFIXED64, 
    TYPE_UINT32, PROTOBUF_C_TYPE_FIXED32, PROTOBUF_C_TYPE_UINT64, 
    TYPE_FIXED64, PROTOBUF_C_TYPE_FLOAT, PROTOBUF_C_TYPE_DOUBLE, 
    TYPE_BOOL, PROTOBUF_C_TYPE_ENUM, PROTOBUF_C_TYPE_STRING, 
    TYPE_BYTES, PROTOBUF_C_TYPE_MESSAGE

  ProtobufCWireType* {.size: sizeof(cint).} = enum 
    PROTOBUF_C_WIRE_TYPE_VARINT = 0, PROTOBUF_C_WIRE_TYPE_64BIT = 1, 
    PROTOBUF_C_WIRE_TYPE_LENGTH_PREFIXED = 2, PROTOBUF_C_WIRE_TYPE_32BIT = 5

  protobuf_c_boolean* = cint
  ProtobufCClosure* = proc (a2: ptr ProtobufCMessage; closure_data: pointer) {.
      cdecl.}
  ProtobufCMessageInit* = proc (a2: ptr ProtobufCMessage) {.cdecl.}
  ProtobufCServiceDestroy* = proc (a2: ptr ProtobufCService) {.cdecl.}

  ProtobufCAllocator* {.importc: "ProtobufCAllocator", header: "protobuf-c.h".} = object 
    alloc* {.importc: "alloc".}: proc (allocator_data: pointer; size: csize): pointer {.
        cdecl.}
    free* {.importc: "free".}: proc (allocator_data: pointer; pointer: pointer) {.
        cdecl.}
    allocator_data* {.importc: "allocator_data".}: pointer

  ProtobufCBinaryData* {.importc: "ProtobufCBinaryData", header: "protobuf-c.h".} = object 
    len* {.importc: "len".}: csize
    data* {.importc: "data".}: ptr uint8

  ProtobufCBuffer* {.importc: "ProtobufCBuffer", header: "protobuf-c.h".} = object 
    append* {.importc: "append".}: proc (buffer: ptr ProtobufCBuffer; 
        len: csize; data: ptr uint8) {.cdecl.}

  ProtobufCBufferSimple* {.importc: "ProtobufCBufferSimple", 
                           header: "protobuf-c.h".} = object 
    base* {.importc: "base".}: ProtobufCBuffer
    alloced* {.importc: "alloced".}: csize
    len* {.importc: "len".}: csize
    data* {.importc: "data".}: ptr uint8
    must_free_data* {.importc: "must_free_data".}: protobuf_c_boolean
    allocator* {.importc: "allocator".}: ptr ProtobufCAllocator

  ProtobufCEnumDescriptor* {.importc: "ProtobufCEnumDescriptor", 
                             header: "protobuf-c.h".} = object 
    magic* {.importc: "magic".}: uint32
    name* {.importc: "name".}: cstring
    short_name* {.importc: "short_name".}: cstring
    c_name* {.importc: "c_name".}: cstring
    package_name* {.importc: "package_name".}: cstring
    n_values* {.importc: "n_values".}: cuint
    values* {.importc: "values".}: ptr ProtobufCEnumValue
    n_value_names* {.importc: "n_value_names".}: cuint
    values_by_name* {.importc: "values_by_name".}: ptr ProtobufCEnumValueIndex
    n_value_ranges* {.importc: "n_value_ranges".}: cuint
    value_ranges* {.importc: "value_ranges".}: ptr ProtobufCIntRange
    reserved1* {.importc: "reserved1".}: pointer
    reserved2* {.importc: "reserved2".}: pointer
    reserved3* {.importc: "reserved3".}: pointer
    reserved4* {.importc: "reserved4".}: pointer

  ProtobufCEnumValue* {.importc: "ProtobufCEnumValue", header: "protobuf-c.h".} = object 
    name* {.importc: "name".}: cstring
    c_name* {.importc: "c_name".}: cstring
    value* {.importc: "value".}: cint

  ProtobufCEnumValueIndex* {.importc: "ProtobufCEnumValueIndex", 
                             header: "protobuf-c.h".} = object 
    name* {.importc: "name".}: cstring
    index* {.importc: "index".}: cuint

  ProtobufCFieldDescriptor* {.importc: "ProtobufCFieldDescriptor", 
                              header: "protobuf-c.h".} = object 
    name* {.importc: "name".}: cstring
    id* {.importc: "id".}: uint32
    label* {.importc: "label".}: ProtobufCLabel
    `type`* {.importc: "type".}: ProtobufCType
    quantifier_offset* {.importc: "quantifier_offset".}: cuint
    offset* {.importc: "offset".}: cuint
    descriptor* {.importc: "descriptor".}: pointer
    default_value* {.importc: "default_value".}: pointer
    flags* {.importc: "flags".}: uint32
    reserved_flags* {.importc: "reserved_flags".}: cuint
    reserved2* {.importc: "reserved2".}: pointer
    reserved3* {.importc: "reserved3".}: pointer

  ProtobufCIntRange* {.importc: "ProtobufCIntRange", header: "protobuf-c.h".} = object 
    start_value* {.importc: "start_value".}: cint
    orig_index* {.importc: "orig_index".}: cuint

  ProtobufCMessage* {.importc: "ProtobufCMessage", header: "protobuf-c.h".} = object 
    descriptor* {.importc: "descriptor".}: ptr ProtobufCMessageDescriptor
    n_unknown_fields* {.importc: "n_unknown_fields".}: cuint
    unknown_fields* {.importc: "unknown_fields".}: ptr ProtobufCMessageUnknownField

  ProtobufCMessageDescriptor* {.importc: "ProtobufCMessageDescriptor", 
                                header: "protobuf-c.h".} = object 
    magic* {.importc: "magic".}: uint32
    name* {.importc: "name".}: cstring
    short_name* {.importc: "short_name".}: cstring
    c_name* {.importc: "c_name".}: cstring
    package_name* {.importc: "package_name".}: cstring
    sizeof_message* {.importc: "sizeof_message".}: csize
    n_fields* {.importc: "n_fields".}: cuint
    fields* {.importc: "fields".}: ptr ProtobufCFieldDescriptor
    fields_sorted_by_name* {.importc: "fields_sorted_by_name".}: ptr cuint
    n_field_ranges* {.importc: "n_field_ranges".}: cuint
    field_ranges* {.importc: "field_ranges".}: ptr ProtobufCIntRange
    message_init* {.importc: "message_init".}: ProtobufCMessageInit
    reserved1* {.importc: "reserved1".}: pointer
    reserved2* {.importc: "reserved2".}: pointer
    reserved3* {.importc: "reserved3".}: pointer

  ProtobufCMessageUnknownField* {.importc: "ProtobufCMessageUnknownField", 
                                  header: "protobuf-c.h".} = object 
    tag* {.importc: "tag".}: uint32
    wire_type* {.importc: "wire_type".}: ProtobufCWireType
    len* {.importc: "len".}: csize
    data* {.importc: "data".}: ptr uint8

  ProtobufCMethodDescriptor* {.importc: "ProtobufCMethodDescriptor", 
                               header: "protobuf-c.h".} = object 
    name* {.importc: "name".}: cstring
    input* {.importc: "input".}: ptr ProtobufCMessageDescriptor
    output* {.importc: "output".}: ptr ProtobufCMessageDescriptor

  ProtobufCService* {.importc: "ProtobufCService", header: "protobuf-c.h".} = object 
    descriptor* {.importc: "descriptor".}: ptr ProtobufCServiceDescriptor
    invoke* {.importc: "invoke".}: proc (service: ptr ProtobufCService; 
        method_index: cuint; input: ptr ProtobufCMessage; 
        closure: ProtobufCClosure; closure_data: pointer) {.cdecl.}
    destroy* {.importc: "destroy".}: proc (service: ptr ProtobufCService) {.
        cdecl.}

  ProtobufCServiceDescriptor* {.importc: "ProtobufCServiceDescriptor", 
                                header: "protobuf-c.h".} = object 
    magic* {.importc: "magic".}: uint32
    name* {.importc: "name".}: cstring
    short_name* {.importc: "short_name".}: cstring
    c_name* {.importc: "c_name".}: cstring
    package* {.importc: "package".}: cstring
    n_methods* {.importc: "n_methods".}: cuint
    methods* {.importc: "methods".}: ptr ProtobufCMethodDescriptor
    method_indices_by_name* {.importc: "method_indices_by_name".}: ptr cuint

proc protobuf_c_version*(): cstring {.cdecl, importc: "protobuf_c_version", 
                                      header: "protobuf-c.h".}

proc protobuf_c_version_number*(): uint32 {.cdecl, 
    importc: "protobuf_c_version_number", header: "protobuf-c.h".}

const 
  PROTOBUF_C_VERSION* = "1.0.2"
  PROTOBUF_C_VERSION_NUMBER* = 1000002
  PROTOBUF_C_MIN_COMPILER_VERSION* = 1000000

proc protobuf_c_enum_descriptor_get_value_by_name*(
    desc: ptr ProtobufCEnumDescriptor; name: cstring): ptr ProtobufCEnumValue {.
    cdecl, importc: "protobuf_c_enum_descriptor_get_value_by_name", 
    header: "protobuf-c.h".}

proc protobuf_c_enum_descriptor_get_value*(desc: ptr ProtobufCEnumDescriptor; 
    value: cint): ptr ProtobufCEnumValue {.cdecl, 
    importc: "protobuf_c_enum_descriptor_get_value", header: "protobuf-c.h".}

proc protobuf_c_message_descriptor_get_field_by_name*(
    desc: ptr ProtobufCMessageDescriptor; name: cstring): ptr ProtobufCFieldDescriptor {.
    cdecl, importc: "protobuf_c_message_descriptor_get_field_by_name", 
    header: "protobuf-c.h".}

proc protobuf_c_message_descriptor_get_field*(
    desc: ptr ProtobufCMessageDescriptor; value: cuint): ptr ProtobufCFieldDescriptor {.
    cdecl, importc: "protobuf_c_message_descriptor_get_field", 
    header: "protobuf-c.h".}

proc protobuf_c_message_get_packed_size*(message: ptr ProtobufCMessage): csize {.
    cdecl, importc: "protobuf_c_message_get_packed_size", header: "protobuf-c.h".}

proc protobuf_c_message_pack*(message: ptr ProtobufCMessage; `out`: ptr uint8): csize {.
    cdecl, importc: "protobuf_c_message_pack", header: "protobuf-c.h".}

proc protobuf_c_message_pack_to_buffer*(message: ptr ProtobufCMessage; 
                                        buffer: ptr ProtobufCBuffer): csize {.
    cdecl, importc: "protobuf_c_message_pack_to_buffer", header: "protobuf-c.h".}

proc protobuf_c_message_unpack*(descriptor: ptr ProtobufCMessageDescriptor; 
                                allocator: ptr ProtobufCAllocator; len: csize; 
                                data: ptr uint8): ptr ProtobufCMessage {.
    cdecl, importc: "protobuf_c_message_unpack", header: "protobuf-c.h".}

proc protobuf_c_message_free_unpacked*(message: ptr ProtobufCMessage; 
                                       allocator: ptr ProtobufCAllocator) {.
    cdecl, importc: "protobuf_c_message_free_unpacked", header: "protobuf-c.h".}

proc protobuf_c_message_check*(a2: ptr ProtobufCMessage): protobuf_c_boolean {.
    cdecl, importc: "protobuf_c_message_check", header: "protobuf-c.h".}

proc protobuf_c_message_init*(descriptor: ptr ProtobufCMessageDescriptor; 
                              message: pointer) {.cdecl, 
    importc: "protobuf_c_message_init", header: "protobuf-c.h".}

proc protobuf_c_service_destroy*(service: ptr ProtobufCService) {.cdecl, 
    importc: "protobuf_c_service_destroy", header: "protobuf-c.h".}

proc protobuf_c_service_descriptor_get_method_by_name*(
    desc: ptr ProtobufCServiceDescriptor; name: cstring): ptr ProtobufCMethodDescriptor {.
    cdecl, importc: "protobuf_c_service_descriptor_get_method_by_name", 
    header: "protobuf-c.h".}

proc protobuf_c_buffer_simple_append*(buffer: ptr ProtobufCBuffer; len: csize; 
                                      data: ptr cuchar) {.cdecl, 
    importc: "protobuf_c_buffer_simple_append", header: "protobuf-c.h".}
proc protobuf_c_service_generated_init*(service: ptr ProtobufCService; 
    descriptor: ptr ProtobufCServiceDescriptor; destroy: ProtobufCServiceDestroy) {.
    cdecl, importc: "protobuf_c_service_generated_init", header: "protobuf-c.h".}
proc protobuf_c_service_invoke_internal*(service: ptr ProtobufCService; 
    method_index: cuint; input: ptr ProtobufCMessage; closure: ProtobufCClosure; 
    closure_data: pointer) {.cdecl, 
                             importc: "protobuf_c_service_invoke_internal", 
                             header: "protobuf-c.h".}