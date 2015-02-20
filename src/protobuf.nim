type 
  FieldFlag* {.size: sizeof(cint).} = enum 
    FIELD_FLAG_PACKED = 1, FIELD_FLAG_DEPRECATED = 2

  Label* {.size: sizeof(cint).} = enum 
    LABEL_REQUIRED, LABEL_OPTIONAL, 
    LABEL_REPEATED

  Type* {.size: sizeof(cint).} = enum 
    TYPE_INT32, TYPE_SINT32, TYPE_SFIXED32, 
    TYPE_INT64, TYPE_SINT64, TYPE_SFIXED64, 
    TYPE_UINT32, TYPE_FIXED32, TYPE_UINT64, 
    TYPE_FIXED64, TYPE_FLOAT, TYPE_DOUBLE, 
    TYPE_BOOL, TYPE_ENUM, TYPE_STRING, 
    TYPE_BYTES, TYPE_MESSAGE

  WireType* {.size: sizeof(cint).} = enum 
    WIRE_TYPE_VARINT = 0, WIRE_TYPE_64BIT = 1, 
    WIRE_TYPE_LENGTH_PREFIXED = 2, WIRE_TYPE_32BIT = 5

  protobuf_c_boolean* = cint
  Closure* = proc (a2: ptr Message; closure_data: pointer) {.
      cdecl.}
  MessageInit* = proc (a2: ptr Message) {.cdecl.}
  ServiceDestroy* = proc (a2: ptr Service) {.cdecl.}

  Allocator* {.importc: "ProtobufCAllocator", header: "protobuf-c.h".} = object 
    alloc* {.importc: "alloc".}: proc (allocator_data: pointer; size: csize): pointer {.
        cdecl.}
    free* {.importc: "free".}: proc (allocator_data: pointer; pointer: pointer) {.
        cdecl.}
    allocator_data* {.importc: "allocator_data".}: pointer

  BinaryData* {.importc: "ProtobufCBinaryData", header: "protobuf-c.h".} = object 
    len* {.importc: "len".}: csize
    data* {.importc: "data".}: ptr uint8

  Buffer* {.importc: "ProtobufCBuffer", header: "protobuf-c.h".} = object 
    append* {.importc: "append".}: proc (buffer: ptr Buffer; 
        len: csize; data: ptr uint8) {.cdecl.}

  BufferSimple* {.importc: "ProtobufCBufferSimple", 
                           header: "protobuf-c.h".} = object 
    base* {.importc: "base".}: Buffer
    alloced* {.importc: "alloced".}: csize
    len* {.importc: "len".}: csize
    data* {.importc: "data".}: ptr uint8
    must_free_data* {.importc: "must_free_data".}: protobuf_c_boolean
    allocator* {.importc: "allocator".}: ptr Allocator

  EnumDescriptor* {.importc: "ProtobufCEnumDescriptor", 
                             header: "protobuf-c.h".} = object 
    magic* {.importc: "magic".}: uint32
    name* {.importc: "name".}: cstring
    short_name* {.importc: "short_name".}: cstring
    c_name* {.importc: "c_name".}: cstring
    package_name* {.importc: "package_name".}: cstring
    n_values* {.importc: "n_values".}: cuint
    values* {.importc: "values".}: ptr EnumValue
    n_value_names* {.importc: "n_value_names".}: cuint
    values_by_name* {.importc: "values_by_name".}: ptr EnumValueIndex
    n_value_ranges* {.importc: "n_value_ranges".}: cuint
    value_ranges* {.importc: "value_ranges".}: ptr IntRange
    reserved1* {.importc: "reserved1".}: pointer
    reserved2* {.importc: "reserved2".}: pointer
    reserved3* {.importc: "reserved3".}: pointer
    reserved4* {.importc: "reserved4".}: pointer

  EnumValue* {.importc: "ProtobufCEnumValue", header: "protobuf-c.h".} = object 
    name* {.importc: "name".}: cstring
    c_name* {.importc: "c_name".}: cstring
    value* {.importc: "value".}: cint

  EnumValueIndex* {.importc: "ProtobufCEnumValueIndex", 
                             header: "protobuf-c.h".} = object 
    name* {.importc: "name".}: cstring
    index* {.importc: "index".}: cuint

  FieldDescriptor* {.importc: "ProtobufCFieldDescriptor", 
                              header: "protobuf-c.h".} = object 
    name* {.importc: "name".}: cstring
    id* {.importc: "id".}: uint32
    label* {.importc: "label".}: Label
    `type`* {.importc: "type".}: Type
    quantifier_offset* {.importc: "quantifier_offset".}: cuint
    offset* {.importc: "offset".}: cuint
    descriptor* {.importc: "descriptor".}: pointer
    default_value* {.importc: "default_value".}: pointer
    flags* {.importc: "flags".}: uint32
    reserved_flags* {.importc: "reserved_flags".}: cuint
    reserved2* {.importc: "reserved2".}: pointer
    reserved3* {.importc: "reserved3".}: pointer

  IntRange* {.importc: "ProtobufCIntRange", header: "protobuf-c.h".} = object 
    start_value* {.importc: "start_value".}: cint
    orig_index* {.importc: "orig_index".}: cuint

  Message* {.importc: "ProtobufCMessage", header: "protobuf-c.h".} = object 
    descriptor* {.importc: "descriptor".}: ptr MessageDescriptor
    n_unknown_fields* {.importc: "n_unknown_fields".}: cuint
    unknown_fields* {.importc: "unknown_fields".}: ptr MessageUnknownField

  MessageDescriptor* {.importc: "ProtobufCMessageDescriptor", 
                                header: "protobuf-c.h".} = object 
    magic* {.importc: "magic".}: uint32
    name* {.importc: "name".}: cstring
    short_name* {.importc: "short_name".}: cstring
    c_name* {.importc: "c_name".}: cstring
    package_name* {.importc: "package_name".}: cstring
    sizeof_message* {.importc: "sizeof_message".}: csize
    n_fields* {.importc: "n_fields".}: cuint
    fields* {.importc: "fields".}: ptr FieldDescriptor
    fields_sorted_by_name* {.importc: "fields_sorted_by_name".}: ptr cuint
    n_field_ranges* {.importc: "n_field_ranges".}: cuint
    field_ranges* {.importc: "field_ranges".}: ptr IntRange
    message_init* {.importc: "message_init".}: MessageInit
    reserved1* {.importc: "reserved1".}: pointer
    reserved2* {.importc: "reserved2".}: pointer
    reserved3* {.importc: "reserved3".}: pointer

  MessageUnknownField* {.importc: "ProtobufCMessageUnknownField", 
                                  header: "protobuf-c.h".} = object 
    tag* {.importc: "tag".}: uint32
    wire_type* {.importc: "wire_type".}: WireType
    len* {.importc: "len".}: csize
    data* {.importc: "data".}: ptr uint8

  MethodDescriptor* {.importc: "ProtobufCMethodDescriptor", 
                               header: "protobuf-c.h".} = object 
    name* {.importc: "name".}: cstring
    input* {.importc: "input".}: ptr MessageDescriptor
    output* {.importc: "output".}: ptr MessageDescriptor

  Service* {.importc: "ProtobufCService", header: "protobuf-c.h".} = object 
    descriptor* {.importc: "descriptor".}: ptr ServiceDescriptor
    invoke* {.importc: "invoke".}: proc (service: ptr Service; 
        method_index: cuint; input: ptr Message; 
        closure: Closure; closure_data: pointer) {.cdecl.}
    destroy* {.importc: "destroy".}: proc (service: ptr Service) {.
        cdecl.}

  ServiceDescriptor* {.importc: "ProtobufCServiceDescriptor", 
                                header: "protobuf-c.h".} = object 
    magic* {.importc: "magic".}: uint32
    name* {.importc: "name".}: cstring
    short_name* {.importc: "short_name".}: cstring
    c_name* {.importc: "c_name".}: cstring
    package* {.importc: "package".}: cstring
    n_methods* {.importc: "n_methods".}: cuint
    methods* {.importc: "methods".}: ptr MethodDescriptor
    method_indices_by_name* {.importc: "method_indices_by_name".}: ptr cuint

proc version*(): cstring {.cdecl, importc: "protobuf_c_version", 
                                      header: "protobuf-c.h".}

proc versionNumber*(): uint32 {.cdecl, 
    importc: "protobuf_c_version_number", header: "protobuf-c.h".}

const 
  PROTOBUF_C_VERSION* = "1.0.2"
  PROTOBUF_C_VERSION_NUMBER* = 1000002
  PROTOBUF_C_MIN_COMPILER_VERSION* = 1000000

proc enumDescriptorGetValueByName*(
    desc: ptr EnumDescriptor; name: cstring): ptr EnumValue {.
    cdecl, importc: "protobuf_c_enum_descriptor_get_value_by_name", 
    header: "protobuf-c.h".}

proc enumDescriptorGetValue*(desc: ptr EnumDescriptor; 
    value: cint): ptr EnumValue {.cdecl, 
    importc: "protobuf_c_enum_descriptor_get_value", header: "protobuf-c.h".}

proc messageDescriptorGetFieldByName*(
    desc: ptr MessageDescriptor; name: cstring): ptr FieldDescriptor {.
    cdecl, importc: "protobuf_c_message_descriptor_get_field_by_name", 
    header: "protobuf-c.h".}

proc messageDescriptorGetField*(
    desc: ptr MessageDescriptor; value: cuint): ptr FieldDescriptor {.
    cdecl, importc: "protobuf_c_message_descriptor_get_field", 
    header: "protobuf-c.h".}

proc messageGetPackedSize*(message: ptr Message): csize {.
    cdecl, importc: "protobuf_c_message_get_packed_size", header: "protobuf-c.h".}

proc messagePack*(message: ptr Message; `out`: ptr uint8): csize {.
    cdecl, importc: "protobuf_c_message_pack", header: "protobuf-c.h".}

proc messagePackToBuffer*(message: ptr Message; 
                                        buffer: ptr Buffer): csize {.
    cdecl, importc: "protobuf_c_message_pack_to_buffer", header: "protobuf-c.h".}

proc messageUnpack*(descriptor: ptr MessageDescriptor; 
                                allocator: ptr Allocator; len: csize; 
                                data: ptr uint8): ptr Message {.
    cdecl, importc: "protobuf_c_message_unpack", header: "protobuf-c.h".}

proc messageFreeUnpacked*(message: ptr Message; 
                                       allocator: ptr Allocator) {.
    cdecl, importc: "protobuf_c_message_free_unpacked", header: "protobuf-c.h".}

proc messageCheck*(a2: ptr Message): protobuf_c_boolean {.
    cdecl, importc: "protobuf_c_message_check", header: "protobuf-c.h".}

proc messageInit*(descriptor: ptr MessageDescriptor; 
                              message: pointer) {.cdecl, 
    importc: "protobuf_c_message_init", header: "protobuf-c.h".}

proc serviceDestroy*(service: ptr Service) {.cdecl, 
    importc: "protobuf_c_service_destroy", header: "protobuf-c.h".}

proc serviceDescriptorGetMethodByName*(
    desc: ptr ServiceDescriptor; name: cstring): ptr MethodDescriptor {.
    cdecl, importc: "protobuf_c_service_descriptor_get_method_by_name", 
    header: "protobuf-c.h".}

proc bufferSimpleAppend*(buffer: ptr Buffer; len: csize; 
                                      data: ptr cuchar) {.cdecl, 
    importc: "protobuf_c_buffer_simple_append", header: "protobuf-c.h".}
proc serviceGeneratedInit*(service: ptr Service; 
    descriptor: ptr ServiceDescriptor; destroy: ServiceDestroy) {.
    cdecl, importc: "protobuf_c_service_generated_init", header: "protobuf-c.h".}
proc serviceInvokeInternal*(service: ptr Service; 
    method_index: cuint; input: ptr Message; closure: Closure; 
    closure_data: pointer) {.cdecl, 
                             importc: "protobuf_c_service_invoke_internal", 
                             header: "protobuf-c.h".}