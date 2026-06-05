const std = @import("std");
const linux = std.os.linux;

const DeviceHandle = @This();
const input = @import("input.zig");
// This is a wrapper struct around a linux device handle file descriptor. It provides a safe interface for reading and writing to the device.

// Maximun number of input events that can be read in one call to read.

handle_path: []const u8,
input_buffer: []input.InputEvent,
file_handle: std.Io.File,
is_open: bool,
is_grabed: bool,

// IOCTL commands for interfacing with the device. These are defined in linux/input.h
const EVIOCGRAB = linux.IOCTL.IOW('E', 0x90, u32);

pub fn open(path: []const u8, buffer: []input.InputEvent, io: std.Io) !DeviceHandle {
    var handle = DeviceHandle{
        .handle_path = path,
        .input_buffer = buffer,
        .file_handle = undefined,
        .is_open = false,
        .is_grabed = false,
    };
    handle.file_handle = try std.Io.Dir.cwd().openFile(io, path, .{ .mode = .read_only });
    handle.is_open = true;
    return handle;
}

pub fn close(self: *DeviceHandle, io: std.Io) !void {
    if (!self.is_open) {
        return error.DeviceNotOpen;
    }
    self.file_handle.close(io);
    self.is_open = false;
}

pub fn grab(self: *DeviceHandle) !void {
    if (!self.is_open) {
        return error.DeviceNotOpen;
    }
    if (self.is_grabed) {
        return error.DeviceAlreadyGrabed;
    }
    const fd = self.file_handle.handle;
    const ret = linux.ioctl(fd, EVIOCGRAB, 1);
    if (ret != 0) {
        return error.GrabFailed;
    }
    self.is_grabed = true;
}

pub fn release(self: *DeviceHandle) !void {
    if (!self.is_open) {
        return error.DeviceNotOpen;
    }
    if (!self.is_grabed) {
        return error.DeviceNotGrabed;
    }
    const fd = self.file_handle.handle;
    const ret = linux.ioctl(fd, EVIOCGRAB, 0);
    if (ret != 0) {
        return error.ReleaseFailed;
    }
    self.is_grabed = false;
}

// pub const InputReader = struct {
//     intern_reader: std.Io.Reader,

//     fn new(reader: std.Io.Reader) InputReader {
//         return InputReader{ .intern_reader = reader };
//     }

//     pub fn takePointer(self: *InputReader) !*InputEvent {
//         const input_buffer: *InputEvent = @alignCast(try self.intern_reader.takeStructPointer(InputEvent));
//         return input_buffer;
//     }
// };

// pub fn input_reader(self: *DeviceHandle, io: std.Io) !InputReader {
//     if (!self.is_open) {
//         return error.DeviceNotOpen;
//     }

//     const fr = self.file_handle.reader(io, std.mem.sliceAsBytes(self.input_buffer));
//     const self.file_handle.
//     const file_reader = fr.interface;
//     return InputReader{ .intern_reader = file_reader };
// }

pub fn read(self: *DeviceHandle, buffer: []input.InputEvent) ![]input.InputEvent {
    if (!self.is_open) {
        return error.DeviceNotOpen;
    }
    const bytes_to_read = buffer.len * @sizeOf(input.InputEvent);
    const bytes_read = linux.read(self.file_handle.handle, std.mem.sliceAsBytes(buffer).ptr, bytes_to_read);
    if (bytes_read % @sizeOf(input.InputEvent) != 0) {
        return error.InvalidRead;
    }
    return buffer[0..(bytes_read / @sizeOf(input.InputEvent))];
}
