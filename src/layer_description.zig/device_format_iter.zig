// provide iterating and error checking for reading a device format struct
//  const <format_struct_name> = struct {
//      const keys = enum {
//          SomeKey,
//          AnotherKey,
//          ...
//      }
//  }

const std = @import("std");
const Type = std.builtin.Type;

pub fn iterate_format_struct(format: type) void {
    const info = @typeInfo(format);
    switch (info) {
        std.builtin.Type.@"struct" => |*struct_type| {
            struct_type.
        },
        _ => {},
    }
}
