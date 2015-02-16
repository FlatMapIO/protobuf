#
#  \defgroup api Public API
# 
#  This is the public API for `libprotobuf-c`. These interfaces are stable and
#  subject to Semantic Versioning guarantees.
# 
# 
#
#  Values for the `flags` word in `ProtobufCFieldDescriptor`.
# 

type                          
  ProtobufCFieldFlag* {.size: sizeof(cint).} = enum 
    FIELD_FLAG_PACKED     = 1, 
    FIELD_FLAG_DEPRECATED = 2                        
  ProtobufCLabel* {.size: sizeof(cint).} = enum 
    LABEL_REQUIRED,
    LABEL_OPTIONAL,                          
    LABEL_REPEATED
  ProtobufCType* {.size: sizeof(cint).} = enum 
    TYPE_INT32,    
    TYPE_SINT32,   
    TYPE_SFIXED32, 
    TYPE_INT64,    
    TYPE_SINT64,   
    TYPE_SFIXED64, 
    TYPE_UINT32,   
    TYPE_FIXED32,  
    TYPE_UINT64,   
    TYPE_FIXED64,  
    TYPE_FLOAT,    
    TYPE_DOUBLE,   
    TYPE_BOOL,     
    TYPE_ENUM,     
    TYPE_STRING,   
    TYPE_BYTES,    
    TYPE_MESSAGE   

  ProtobufCWireType* {.size: sizeof(cint).} = enum 
    WIRE_TYPE_VARINT          = 0,
    WIRE_TYPE_64BIT           = 1,
    WIRE_TYPE_LENGTH_PREFIXED = 2,
    WIRE_TYPE_32BIT           = 5

  protobuf_c_boolean* = cint




  ProtobufCAllocator* {.importc: "ProtobufCAllocator", header: "protobuf-c.h".} = object 
  #  Structure for defining a custom memory allocator.
    alloc* {.importc: "alloc".}: proc (allocator_data: pointer; size: csize): pointer {.
        cdecl.}               
    # Function to allocate memory.
    free* {.importc: "free".}: proc (allocator_data: pointer; pointer: pointer) {.
        cdecl.}    
    # Function to free memory.

    allocator_data* {.importc: "allocator_data".}: pointer
    # Opaque pointer passed to `alloc` and `free` functions.

  ProtobufCBinaryData* {.importc: "ProtobufCBinaryData", header: "protobuf-c.h".} = object 
    len* {.importc: "len".}: csize
    # Number of bytes in the `data` field.
    data* {.importc: "data".}: ptr uint8_t 
    # Data bytes.
  
  ProtobufCBuffer* {.importc: "ProtobufCBuffer", header: "protobuf-c.h".} = object 
    append* {.importc: "append".}: proc (buffer: ptr ProtobufCBuffer; 
        len: csize; data: ptr uint8_t) {.cdecl.} 
        # Append function. Consumes the `len` bytes stored at `data`.

  ProtobufCBufferSimple* {.importc: "ProtobufCBufferSimple", 
                           header: "protobuf-c.h".} = object 
    base* {.importc: "base".}: ProtobufCBuffer 
    # "Base class".
    alloced* {.importc: "alloced".}: csize 
    # Number of bytes allocated in `data`.

    len* {.importc: "len".}: csize 
    # Number of bytes currently stored in `data`.

    data* {.importc: "data".}: ptr uint8_t 
    # Data bytes.

    must_free_data* {.importc: "must_free_data".}: protobuf_c_boolean 
    # Whether `data` must be freed.

    allocator* {.importc: "allocator".}: ptr ProtobufCAllocator
    # Allocator to use. May be NULL to indicate the system allocator.

  ProtobufCEnumDescriptor* {.importc: "ProtobufCEnumDescriptor", 
                             header: "protobuf-c.h".} = object 
  #  Describes an enumeration as a whole, with all of its values.

    magic* {.importc: "magic".}: uint32_t 
    # Magic value checked to ensure that the API is used correctly.
    name* {.importc: "name".}: cstring # The unqualified name as given in the .proto file (e.g., "Type").
    short_name* {.importc: "short_name".}: cstring # Identifier used in generated C code.
    c_name* {.importc: "c_name".}: cstring # The dot-separated namespace.
    package_name* {.importc: "package_name".}: cstring # Number elements in `values`.
    n_values* {.importc: "n_values".}: cuint # Array of distinct values, sorted by numeric value.
    values* {.importc: "values".}: ptr ProtobufCEnumValue # Number of elements in `values_by_name`.
    n_value_names* {.importc: "n_value_names".}: cuint # Array of named values, including aliases, sorted by name.
    values_by_name* {.importc: "values_by_name".}: ptr ProtobufCEnumValueIndex # 
                                                                               # Number 
                                                                               # of 
                                                                               # elements 
                                                                               # in 
                                                                               # `value_ranges`.
    n_value_ranges* {.importc: "n_value_ranges".}: cuint # Value ranges, for faster lookups by numeric value.
    value_ranges* {.importc: "value_ranges".}: ptr ProtobufCIntRange # Reserved for future use.
    reserved1* {.importc: "reserved1".}: pointer # Reserved for future use.
    reserved2* {.importc: "reserved2".}: pointer # Reserved for future use.
    reserved3* {.importc: "reserved3".}: pointer # Reserved for future use.
    reserved4* {.importc: "reserved4".}: pointer


  ProtobufCEnumValue* {.importc: "ProtobufCEnumValue", header: "protobuf-c.h".} = object 
    name* {.importc: "name".}: cstring # The string identifying this value in the .proto file.
    # The string identifying this value in generated C code.
    c_name* {.importc: "c_name".}: cstring # The numeric value assigned in the .proto file.
    value* {.importc: "value".}: cint

  ProtobufCEnumValueIndex* {.importc: "ProtobufCEnumValueIndex", 
                             header: "protobuf-c.h".} = object 
    name* {.importc: "name".}: cstring # Name of the enum value.
    # Index into values[] array.
    index* {.importc: "index".}: cuint

  ProtobufCFieldDescriptor* {.importc: "ProtobufCFieldDescriptor", 
                              header: "protobuf-c.h".} = object 
    name* {.importc: "name".}: cstring
    id* {.importc: "id".}: uint32_t
    label* {.importc: "label".}: ProtobufCLabel
    `type`* {.importc: "type".}: ProtobufCType 

    quantifier_offset* {.importc: "quantifier_offset".}: cuint
    offset* {.importc: "offset".}: cuint 
    descriptor* {.importc: "descriptor".}: pointer 
    default_value* {.importc: "default_value".}: pointer
    flags* {.importc: "flags".}: uint32_t # Reserved for future use.
    reserved_flags* {.importc: "reserved_flags".}: cuint # Reserved for future use.
    reserved2* {.importc: "reserved2".}: pointer # Reserved for future use.
    reserved3* {.importc: "reserved3".}: pointer


  ProtobufCIntRange* {.importc: "ProtobufCIntRange", header: "protobuf-c.h".} = object 
    start_value* {.importc: "start_value".}: cint
    orig_index* {.importc: "orig_index".}: cuint

  ProtobufCMessage* {.importc: "ProtobufCMessage", header: "protobuf-c.h".} = object 
    descriptor* {.importc: "descriptor".}: ptr ProtobufCMessageDescriptor 

    # The number of elements in `unknown_fields`.
    n_unknown_fields* {.importc: "n_unknown_fields".}: cuint # The fields that weren't recognized by the parser.
    unknown_fields* {.importc: "unknown_fields".}: ptr ProtobufCMessageUnknownField
    
  ProtobufCClosure* = proc (a2: ptr ProtobufCMessage; closure_data: pointer) {.
      cdecl.}
  ProtobufCMessageInit* = proc (a2: ptr ProtobufCMessage) {.cdecl.}
  ProtobufCServiceDestroy* = proc (a2: ptr ProtobufCService) {.cdecl.}

#
#  Describes a message.
# 

type 
  ProtobufCMessageDescriptor* {.importc: "ProtobufCMessageDescriptor", 
                                header: "protobuf-c.h".} = object 
    magic* {.importc: "magic".}: uint32_t # Magic value checked to ensure that the API is used correctly.
    # The qualified name (e.g., "namespace.Type").
    name* {.importc: "name".}: cstring # The unqualified name as given in the .proto file (e.g., "Type").
    short_name* {.importc: "short_name".}: cstring # Identifier used in generated C code.
    c_name* {.importc: "c_name".}: cstring # The dot-separated namespace.
    package_name* {.importc: "package_name".}: cstring
    sizeof_message* {.importc: "sizeof_message".}: csize # Number of elements in `fields`.
    n_fields* {.importc: "n_fields".}: cuint # Field descriptors, sorted by tag number.
    fields* {.importc: "fields".}: ptr ProtobufCFieldDescriptor # Used for looking up fields by name.
    fields_sorted_by_name* {.importc: "fields_sorted_by_name".}: ptr cuint
    n_field_ranges* {.importc: "n_field_ranges".}: cuint
    field_ranges* {.importc: "field_ranges".}: ptr ProtobufCIntRange
    message_init* {.importc: "message_init".}: ProtobufCMessageInit
    reserved1* {.importc: "reserved1".}: pointer
    reserved2* {.importc: "reserved2".}: pointer
    reserved3* {.importc: "reserved3".}: pointer

type 
  ProtobufCMessageUnknownField* {.importc: "ProtobufCMessageUnknownField", 
                                  header: "protobuf-c.h".} = object 
    tag* {.importc: "tag".}: uint32_t # The tag number.
    # The wire type of the field.
    wire_type* {.importc: "wire_type".}: ProtobufCWireType # Number of bytes in `data`.
    len* {.importc: "len".}: csize # Field data.
    data* {.importc: "data".}: ptr uint8_t


#
#  Method descriptor.
# 

type 
  ProtobufCMethodDescriptor* {.importc: "ProtobufCMethodDescriptor", 
                               header: "protobuf-c.h".} = object 
    name* {.importc: "name".}: cstring # Method name.
    # Input message descriptor.
    input* {.importc: "input".}: ptr ProtobufCMessageDescriptor # Output message descriptor.
    output* {.importc: "output".}: ptr ProtobufCMessageDescriptor


#
#  Service.
# 

type 
  ProtobufCService* {.importc: "ProtobufCService", header: "protobuf-c.h".} = object 
    descriptor* {.importc: "descriptor".}: ptr ProtobufCServiceDescriptor # 
                                                                          # Service 
                                                                          # descriptor.
    # Function to invoke the service.
    invoke* {.importc: "invoke".}: proc (service: ptr ProtobufCService; 
        method_index: cuint; input: ptr ProtobufCMessage; 
        closure: ProtobufCClosure; closure_data: pointer) {.cdecl.} # Function to destroy the service.
    destroy* {.importc: "destroy".}: proc (service: ptr ProtobufCService) {.
        cdecl.}


#
#  Service descriptor.
# 

type 
  ProtobufCServiceDescriptor* {.importc: "ProtobufCServiceDescriptor", 
                                header: "protobuf-c.h".} = object 
    magic* {.importc: "magic".}: uint32_t # Magic value checked to ensure that the API is used correctly.
    # Service name.
    name* {.importc: "name".}: cstring # Short version of service name.
    short_name* {.importc: "short_name".}: cstring # C identifier for the service name.
    c_name* {.importc: "c_name".}: cstring # Package name.
    package* {.importc: "package".}: cstring # Number of elements in `methods`.
    n_methods* {.importc: "n_methods".}: cuint # Method descriptors, in the order defined in the .proto file.
    methods* {.importc: "methods".}: ptr ProtobufCMethodDescriptor # Sort index of methods.
    method_indices_by_name* {.importc: "method_indices_by_name".}: ptr cuint


#
#  Get the version of the protobuf-c library. Note that this is the version of
#  the library linked against, not the version of the headers compiled against.
# 
#  \return A string containing the version number of protobuf-c.
# 

proc protobuf_c_version*(): cstring {.cdecl, importc: "protobuf_c_version", 
                                      header: "protobuf-c.h".}
#
#  Get the version of the protobuf-c library. Note that this is the version of
#  the library linked against, not the version of the headers compiled against.
# 
#  \return A 32 bit unsigned integer containing the version number of
#       protobuf-c, represented in base-10 as (MAJOR*1E6) + (MINOR*1E3) + PATCH.
# 

proc protobuf_c_version_number*(): uint32_t {.cdecl, 
    importc: "protobuf_c_version_number", header: "protobuf-c.h".}
#
#  The version of the protobuf-c headers, represented as a string using the same
#  format as protobuf_c_version().
# 

const 
  PROTOBUF_C_VERSION* = "1.0.2"

#
#  The version of the protobuf-c headers, represented as an integer using the
#  same format as protobuf_c_version_number().
# 

const 
  PROTOBUF_C_VERSION_NUMBER* = 1000002

#
#  The minimum protoc-c version which works with the current version of the
#  protobuf-c headers.
# 

const 
  PROTOBUF_C_MIN_COMPILER_VERSION* = 1000000

#
#  Look up a `ProtobufCEnumValue` from a `ProtobufCEnumDescriptor` by name.
# 
#  \param desc
#       The `ProtobufCEnumDescriptor` object.
#  \param name
#       The `name` field from the corresponding `ProtobufCEnumValue` object to
#       match.
#  \return
#       A `ProtobufCEnumValue` object.
#  \retval NULL
#       If not found.
# 

proc protobuf_c_enum_descriptor_get_value_by_name*(
    desc: ptr ProtobufCEnumDescriptor; name: cstring): ptr ProtobufCEnumValue {.
    cdecl, importc: "protobuf_c_enum_descriptor_get_value_by_name", 
    header: "protobuf-c.h".}
#
#  Look up a `ProtobufCEnumValue` from a `ProtobufCEnumDescriptor` by numeric
#  value.
# 
#  \param desc
#       The `ProtobufCEnumDescriptor` object.
#  \param value
#       The `value` field from the corresponding `ProtobufCEnumValue` object to
#       match.
# 
#  \return
#       A `ProtobufCEnumValue` object.
#  \retval NULL
#       If not found.
# 

proc protobuf_c_enum_descriptor_get_value*(desc: ptr ProtobufCEnumDescriptor; 
    value: cint): ptr ProtobufCEnumValue {.cdecl, 
    importc: "protobuf_c_enum_descriptor_get_value", header: "protobuf-c.h".}
#
#  Look up a `ProtobufCFieldDescriptor` from a `ProtobufCMessageDescriptor` by
#  the name of the field.
# 
#  \param desc
#       The `ProtobufCMessageDescriptor` object.
#  \param name
#       The name of the field.
#  \return
#       A `ProtobufCFieldDescriptor` object.
#  \retval NULL
#       If not found.
# 

proc protobuf_c_message_descriptor_get_field_by_name*(
    desc: ptr ProtobufCMessageDescriptor; name: cstring): ptr ProtobufCFieldDescriptor {.
    cdecl, importc: "protobuf_c_message_descriptor_get_field_by_name", 
    header: "protobuf-c.h".}
#
#  Look up a `ProtobufCFieldDescriptor` from a `ProtobufCMessageDescriptor` by
#  the tag value of the field.
# 
#  \param desc
#       The `ProtobufCMessageDescriptor` object.
#  \param value
#       The tag value of the field.
#  \return
#       A `ProtobufCFieldDescriptor` object.
#  \retval NULL
#       If not found.
# 

proc protobuf_c_message_descriptor_get_field*(
    desc: ptr ProtobufCMessageDescriptor; value: cuint): ptr ProtobufCFieldDescriptor {.
    cdecl, importc: "protobuf_c_message_descriptor_get_field", 
    header: "protobuf-c.h".}
#
#  Determine the number of bytes required to store the serialised message.
# 
#  \param message
#       The message object to serialise.
#  \return
#       Number of bytes.
# 

proc protobuf_c_message_get_packed_size*(message: ptr ProtobufCMessage): csize {.
    cdecl, importc: "protobuf_c_message_get_packed_size", header: "protobuf-c.h".}
#
#  Serialise a message from its in-memory representation.
# 
#  This function stores the serialised bytes of the message in a pre-allocated
#  buffer.
# 
#  \param message
#       The message object to serialise.
#  \param[out] out
#       Buffer to store the bytes of the serialised message. This buffer must
#       have enough space to store the packed message. Use
#       protobuf_c_message_get_packed_size() to determine the number of bytes
#       required.
#  \return
#       Number of bytes stored in `out`.
# 

proc protobuf_c_message_pack*(message: ptr ProtobufCMessage; `out`: ptr uint8_t): csize {.
    cdecl, importc: "protobuf_c_message_pack", header: "protobuf-c.h".}
#
#  Serialise a message from its in-memory representation to a virtual buffer.
# 
#  This function calls the `append` method of a `ProtobufCBuffer` object to
#  consume the bytes generated by the serialiser.
# 
#  \param message
#       The message object to serialise.
#  \param buffer
#       The virtual buffer object.
#  \return
#       Number of bytes passed to the virtual buffer.
# 

proc protobuf_c_message_pack_to_buffer*(message: ptr ProtobufCMessage; 
                                        buffer: ptr ProtobufCBuffer): csize {.
    cdecl, importc: "protobuf_c_message_pack_to_buffer", header: "protobuf-c.h".}
#
#  Unpack a serialised message into an in-memory representation.
# 
#  \param descriptor
#       The message descriptor.
#  \param allocator
#       `ProtobufCAllocator` to use for memory allocation. May be NULL to
#       specify the default allocator.
#  \param len
#       Length in bytes of the serialised message.
#  \param data
#       Pointer to the serialised message.
#  \return
#       An unpacked message object.
#  \retval NULL
#       If an error occurred during unpacking.
# 

proc protobuf_c_message_unpack*(descriptor: ptr ProtobufCMessageDescriptor; 
                                allocator: ptr ProtobufCAllocator; len: csize; 
                                data: ptr uint8_t): ptr ProtobufCMessage {.
    cdecl, importc: "protobuf_c_message_unpack", header: "protobuf-c.h".}
#
#  Free an unpacked message object.
# 
#  This function should be used to deallocate the memory used by a call to
#  protobuf_c_message_unpack().
# 
#  \param message
#       The message object to free.
#  \param allocator
#       `ProtobufCAllocator` to use for memory deallocation. May be NULL to
#       specify the default allocator.
# 

proc protobuf_c_message_free_unpacked*(message: ptr ProtobufCMessage; 
                                       allocator: ptr ProtobufCAllocator) {.
    cdecl, importc: "protobuf_c_message_free_unpacked", header: "protobuf-c.h".}
#
#  Check the validity of a message object.
# 
#  Makes sure all required fields (`PROTOBUF_C_LABEL_REQUIRED`) are present.
#  Recursively checks nested messages.
# 
#  \retval TRUE
#       Message is valid.
#  \retval FALSE
#       Message is invalid.
# 

proc protobuf_c_message_check*(a2: ptr ProtobufCMessage): protobuf_c_boolean {.
    cdecl, importc: "protobuf_c_message_check", header: "protobuf-c.h".}
#
#  Initialise a message object from a message descriptor.
# 
#  \param descriptor
#       Message descriptor.
#  \param message
#       Allocated block of memory of size `descriptor->sizeof_message`.
# 

proc protobuf_c_message_init*(descriptor: ptr ProtobufCMessageDescriptor; 
                              message: pointer) {.cdecl, 
    importc: "protobuf_c_message_init", header: "protobuf-c.h".}
#
#  Free a service.
# 
#  \param service
#       The service object to free.
# 

proc protobuf_c_service_destroy*(service: ptr ProtobufCService) {.cdecl, 
    importc: "protobuf_c_service_destroy", header: "protobuf-c.h".}
#
#  Look up a `ProtobufCMethodDescriptor` by name.
# 
#  \param desc
#       Service descriptor.
#  \param name
#       Name of the method.
# 
#  \return
#       A `ProtobufCMethodDescriptor` object.
#  \retval NULL
#       If not found.
# 

proc protobuf_c_service_descriptor_get_method_by_name*(
    desc: ptr ProtobufCServiceDescriptor; name: cstring): ptr ProtobufCMethodDescriptor {.
    cdecl, importc: "protobuf_c_service_descriptor_get_method_by_name", 
    header: "protobuf-c.h".}
#
#  The `append` method for `ProtobufCBufferSimple`.
# 
#  \param buffer
#       The buffer object to append to. Must actually be a
#       `ProtobufCBufferSimple` object.
#  \param len
#       Number of bytes in `data`.
#  \param data
#       Data to append.
# 

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