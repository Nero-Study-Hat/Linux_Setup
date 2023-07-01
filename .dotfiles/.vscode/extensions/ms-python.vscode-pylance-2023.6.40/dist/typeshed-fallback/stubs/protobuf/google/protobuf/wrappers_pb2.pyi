"""
@generated by mypy-protobuf.  Do not edit manually!
isort:skip_file
Wrappers for primitive (non-message) types. These types are useful
for embedding primitives in the `google.protobuf.Any` type and for places
where we need to distinguish between the absence of a primitive
typed field and its default value.

These wrappers have no meaningful use within repeated fields as they lack
the ability to detect presence on individual elements.
These wrappers have no meaningful use within a map or a oneof since
individual entries of a map or fields of a oneof can already detect presence.
"""
import builtins
import google.protobuf.descriptor
import google.protobuf.message
import sys

if sys.version_info >= (3, 8):
    import typing as typing_extensions
else:
    import typing_extensions

DESCRIPTOR: google.protobuf.descriptor.FileDescriptor

@typing_extensions.final
class DoubleValue(google.protobuf.message.Message):
    """Wrapper message for `double`.

    The JSON representation for `DoubleValue` is JSON number.
    """

    DESCRIPTOR: google.protobuf.descriptor.Descriptor

    VALUE_FIELD_NUMBER: builtins.int
    value: builtins.float
    """The double value."""
    def __init__(
        self,
        *,
        value: builtins.float | None = ...,
    ) -> None: ...
    def ClearField(self, field_name: typing_extensions.Literal["value", b"value"]) -> None: ...

global___DoubleValue = DoubleValue

@typing_extensions.final
class FloatValue(google.protobuf.message.Message):
    """Wrapper message for `float`.

    The JSON representation for `FloatValue` is JSON number.
    """

    DESCRIPTOR: google.protobuf.descriptor.Descriptor

    VALUE_FIELD_NUMBER: builtins.int
    value: builtins.float
    """The float value."""
    def __init__(
        self,
        *,
        value: builtins.float | None = ...,
    ) -> None: ...
    def ClearField(self, field_name: typing_extensions.Literal["value", b"value"]) -> None: ...

global___FloatValue = FloatValue

@typing_extensions.final
class Int64Value(google.protobuf.message.Message):
    """Wrapper message for `int64`.

    The JSON representation for `Int64Value` is JSON string.
    """

    DESCRIPTOR: google.protobuf.descriptor.Descriptor

    VALUE_FIELD_NUMBER: builtins.int
    value: builtins.int
    """The int64 value."""
    def __init__(
        self,
        *,
        value: builtins.int | None = ...,
    ) -> None: ...
    def ClearField(self, field_name: typing_extensions.Literal["value", b"value"]) -> None: ...

global___Int64Value = Int64Value

@typing_extensions.final
class UInt64Value(google.protobuf.message.Message):
    """Wrapper message for `uint64`.

    The JSON representation for `UInt64Value` is JSON string.
    """

    DESCRIPTOR: google.protobuf.descriptor.Descriptor

    VALUE_FIELD_NUMBER: builtins.int
    value: builtins.int
    """The uint64 value."""
    def __init__(
        self,
        *,
        value: builtins.int | None = ...,
    ) -> None: ...
    def ClearField(self, field_name: typing_extensions.Literal["value", b"value"]) -> None: ...

global___UInt64Value = UInt64Value

@typing_extensions.final
class Int32Value(google.protobuf.message.Message):
    """Wrapper message for `int32`.

    The JSON representation for `Int32Value` is JSON number.
    """

    DESCRIPTOR: google.protobuf.descriptor.Descriptor

    VALUE_FIELD_NUMBER: builtins.int
    value: builtins.int
    """The int32 value."""
    def __init__(
        self,
        *,
        value: builtins.int | None = ...,
    ) -> None: ...
    def ClearField(self, field_name: typing_extensions.Literal["value", b"value"]) -> None: ...

global___Int32Value = Int32Value

@typing_extensions.final
class UInt32Value(google.protobuf.message.Message):
    """Wrapper message for `uint32`.

    The JSON representation for `UInt32Value` is JSON number.
    """

    DESCRIPTOR: google.protobuf.descriptor.Descriptor

    VALUE_FIELD_NUMBER: builtins.int
    value: builtins.int
    """The uint32 value."""
    def __init__(
        self,
        *,
        value: builtins.int | None = ...,
    ) -> None: ...
    def ClearField(self, field_name: typing_extensions.Literal["value", b"value"]) -> None: ...

global___UInt32Value = UInt32Value

@typing_extensions.final
class BoolValue(google.protobuf.message.Message):
    """Wrapper message for `bool`.

    The JSON representation for `BoolValue` is JSON `true` and `false`.
    """

    DESCRIPTOR: google.protobuf.descriptor.Descriptor

    VALUE_FIELD_NUMBER: builtins.int
    value: builtins.bool
    """The bool value."""
    def __init__(
        self,
        *,
        value: builtins.bool | None = ...,
    ) -> None: ...
    def ClearField(self, field_name: typing_extensions.Literal["value", b"value"]) -> None: ...

global___BoolValue = BoolValue

@typing_extensions.final
class StringValue(google.protobuf.message.Message):
    """Wrapper message for `string`.

    The JSON representation for `StringValue` is JSON string.
    """

    DESCRIPTOR: google.protobuf.descriptor.Descriptor

    VALUE_FIELD_NUMBER: builtins.int
    value: builtins.str
    """The string value."""
    def __init__(
        self,
        *,
        value: builtins.str | None = ...,
    ) -> None: ...
    def ClearField(self, field_name: typing_extensions.Literal["value", b"value"]) -> None: ...

global___StringValue = StringValue

@typing_extensions.final
class BytesValue(google.protobuf.message.Message):
    """Wrapper message for `bytes`.

    The JSON representation for `BytesValue` is JSON string.
    """

    DESCRIPTOR: google.protobuf.descriptor.Descriptor

    VALUE_FIELD_NUMBER: builtins.int
    value: builtins.bytes
    """The bytes value."""
    def __init__(
        self,
        *,
        value: builtins.bytes | None = ...,
    ) -> None: ...
    def ClearField(self, field_name: typing_extensions.Literal["value", b"value"]) -> None: ...

global___BytesValue = BytesValue
