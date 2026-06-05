const std = @import("std");
const Io = std.Io;

// const device_reprogrammer = @import("device_reprogrammer");
const device_handle = @import("device_handle.zig");
const VirtualDevice = @import("virtual_device.zig");
const input = @import("input.zig");

const linux = std.os.linux;

const layer = @import("layer.zig");
const Profile = @import("profile.zig");
const BitSet = @import("bitset.zig");
const action = @import("action.zig");

pub fn main(init: std.process.Init) !void {
    // // Prints to stderr, unbuffered, ignoring potential errors.
    // std.debug.print("All your {s} are belong to us.\n", .{"codebase"});

    // // This is appropriate for anything that lives as long as the process.
    const arena: std.mem.Allocator = init.arena.allocator();

    // // Accessing command line arguments:
    // const args = try init.minimal.args.toSlice(arena);
    // for (args) |arg| {
    //     std.log.info("arg: {s}", .{arg});
    // }

    const io = init.io;

    // var virtual_dev_setup = try VirtualDevice.Setup.init(io);
    // virtual_dev_setup.setAllKeys() catch {
    //     std.log.err("Failed to set keys on virtual device", .{});
    //     virtual_dev_setup.prematureDestroy(io);
    //     return;
    // };
    // var virtual_dev = virtual_dev_setup.createDevice("zig-virtual-device") catch {
    //     std.log.err("Failed to create virtual device", .{});
    //     virtual_dev_setup.prematureDestroy(io);
    //     return;
    // };

    const virtual_dev_setup = try VirtualDevice.Setup.init(io);
    try virtual_dev_setup.setAllKeys();
    var virtual_dev = try virtual_dev_setup.createDevice("zig-virtual-device");
    defer virtual_dev.destroy(io);

    // var virtual_dev = try VirtualDevice.init(io, "zig-virtual-device2");
    // defer virtual_dev.destroy(io);
    _ = linux.nanosleep(&linux.timespec{ .sec = 1, .nsec = 0 }, null);

    var buffer: [32]input.InputEvent = undefined;

    const device_path = "/dev/input/by-id/usb-Corsair_Corsair_K95W_Gaming_Keyboard-if02-event-kbd";
    var device = device_handle.open(device_path, &buffer, io) catch {
        std.log.err("Failed to open device: {s}", .{device_path});
        return;
    };
    defer device.close(io) catch {
        std.log.err("Failed to close device: {s}", .{device_path});
    };
    try device.grab();

    var key_layer = layer.TestLayer.init();
    var required_combo: [2]input.event_codes.KeyEvent = .{ .KEY_LEFTCTRL, .KEY_LEFTALT };
    var hotkeyLayer = layer.HotKeylayer.init(input.event_codes.KeyEvent.KEY_A, &required_combo, action.Action{ .Tap = .KEY_E });
    var profile = Profile.init(arena);
    defer profile.deinit();

    const layID = try profile.addLayer(key_layer.interface());
    const forwardLayer = try profile.addLayer(layer.forwardEventInterface);
    const hotKeyID = try profile.addLayer(hotkeyLayer.interface());
    profile.forwardLayer(forwardLayer);
    profile.forwardLayer(layID);
    profile.forwardLayer(hotKeyID);

    var keyData = [_]u32{0} ** BitSet.neededSize(input.event_codes.key_cnt);
    var keyState = BitSet.init(&keyData);

    var cont = true;
    var pass_events = true;
    var emit_next_sync = false;
    while (cont) {
        const events = try device.read(&buffer);
        for (events) |event| {
            if (pass_events) {
                virtual_dev.emitEvent(event) catch {
                    std.log.err("Failed to emit event: {s}", .{device_path});
                };
            }

            if (event.event_type != input.event_codes.Type.Key) {
                if (event.event_type == input.event_codes.Type.Sync and emit_next_sync) {
                    try virtual_dev.emitEvent(event);
                    emit_next_sync = false;
                }
                continue;
            } else {
                if (event.value == 1) {
                    keyState.set(event.code);
                } else if (event.value == 0) {
                    keyState.clear(event.code);
                }
            }

            const response = profile.processEvent(keyState.asConst(), event);
            switch (response) {
                .BlockDevice => {
                    std.debug.print("Blocking device\n", .{});
                    pass_events = false;
                },
                .ReleaseDevice => pass_events = true,
                .ForwardEvent => {
                    try virtual_dev.emitEvent(event);
                    emit_next_sync = true;
                },
                .NoOp => {},
                .PressKey => |key| {
                    try virtual_dev.emitKeyEvent(key, 1);
                    try virtual_dev.emitSyncEvent();
                },
                .ReleaseKey => |key| {
                    try virtual_dev.emitKeyEvent(key, 0);
                    try virtual_dev.emitSyncEvent();
                },
                .TapKey => |key| {
                    try virtual_dev.emitKeyEvent(key, 1);
                    try virtual_dev.emitSyncEvent();
                    try virtual_dev.emitKeyEvent(key, 0);
                    try virtual_dev.emitSyncEvent();
                },
            }

            // std.log.info("Event: type={s}, code={d}, value={d}", .{ std.enums.tagName(input.event_codes.Type, event.event_type).?, event.code, event.value });
            if (event.code == 82) {
                cont = false;
            }

            // // gab it on the release so it doesn't leave the button on
            // if (event.code == 74 and event.value == 0) {
            //     if (device.is_grabed) {
            //         std.debug.print("Releasing device\n", .{});
            //         try device.release();
            //     } else {
            //         std.debug.print("Grabbing device\n", .{});
            //         try device.grab();
            //     }
            // }
        }
    }

    if (device.is_grabed) {
        try device.release();
    }

    // // In order to do I/O operations need an `Io` instance.
    // var buffer: [32]input.InputEvent = undefined;

    // const device_path = "/dev/input/by-id/usb-Corsair_Corsair_K95W_Gaming_Keyboard-if02-event-kbd";
    // var device = device_handle.open(device_path, &buffer, io) catch {
    //     std.log.err("Failed to open device: {s}", .{device_path});
    //     return;
    // };
    // defer device.close(io) catch {
    //     std.log.err("Failed to close device: {s}", .{device_path});
    // };

    // var cont = true;
    // while (cont) {
    //     const events = try device.read(&buffer);
    //     for (events) |event| {
    //         virtual_dev.emitEvent(event) catch {
    //             std.log.err("Failed to emit event: {s}", .{device_path});
    //         };
    //         std.log.info("Event: type={s}, code={d}, value={d}", .{ std.enums.tagName(input.event_codes.Type, event.event_type).?, event.code, event.value });
    //         if (event.code == 82) {
    //             cont = false;
    //         }

    //         // gab it on the release so it doesn't leave the button on
    //         if (event.code == 74 and event.value == 0) {
    //             if (device.is_grabed) {
    //                 std.debug.print("Releasing device\n", .{});
    //                 try device.release();
    //             } else {
    //                 std.debug.print("Grabbing device\n", .{});
    //                 try device.grab();
    //             }
    //         }
    //     }
    // }

    // if (device.is_grabed) {
    //     try device.release();
    // }

    // // Stdout is for the actual output of your application, for example if you
    // // are implementing gzip, then only the compressed bytes should be sent to
    // // stdout, not any debugging messages.
    // var stdout_buffer: [1024]u8 = undefined;
    // var stdout_file_writer: Io.File.Writer = .init(.stdout(), io, &stdout_buffer);
    // const stdout_writer = &stdout_file_writer.interface;

    // try device_reprogrammer.printAnotherMessage(stdout_writer);

    // try stdout_writer.flush(); // Don't forget to flush!
}

// test "simple test" {
//     const gpa = std.testing.allocator;
//     var list: std.ArrayList(i32) = .empty;
//     defer list.deinit(gpa); // Try commenting this out and see if zig detects the memory leak!
//     try list.append(gpa, 42);
//     try std.testing.expectEqual(@as(i32, 42), list.pop());
// }

// test "fuzz example" {
//     try std.testing.fuzz({}, testOne, .{});
// }

// fn testOne(context: void, smith: *std.testing.Smith) !void {
//     _ = context;
//     // Try passing `--fuzz` to `zig build test` and see if it manages to fail this test case!

//     const gpa = std.testing.allocator;
//     var list: std.ArrayList(u8) = .empty;
//     defer list.deinit(gpa);
//     while (!smith.eos()) switch (smith.value(enum { add_data, dup_data })) {
//         .add_data => {
//             const slice = try list.addManyAsSlice(gpa, smith.value(u4));
//             smith.bytes(slice);
//         },
//         .dup_data => {
//             if (list.items.len == 0) continue;
//             if (list.items.len > std.math.maxInt(u32)) return error.SkipZigTest;
//             const len = smith.valueRangeAtMost(u32, 1, @min(32, list.items.len));
//             const off = smith.valueRangeAtMost(u32, 0, @intCast(list.items.len - len));
//             try list.appendSlice(gpa, list.items[off..][0..len]);
//             try std.testing.expectEqualSlices(
//                 u8,
//                 list.items[off..][0..len],
//                 list.items[list.items.len - len ..],
//             );
//         },
//     };
// }
