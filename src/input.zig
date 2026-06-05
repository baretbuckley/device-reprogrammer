const std = @import("std");
const linux = std.os.linux;
pub const event_codes = @import("input_event_codes.zig");

// Reimplimentation of the linux uapi file linux/input.h struct input_event
pub const InputEvent = extern struct {
    time: linux.timeval,
    event_type: event_codes.Type,
    code: u16,
    value: i32,
};

comptime {
    std.debug.assert(@sizeOf(InputEvent) == 24);
}

const EVIOCGRAB = linux.IOCTL.IOW('E', 0x90, u32);

pub fn eviocgrab(fd: i32, grab: bool) !void {
    const ret = linux.ioctl(fd, EVIOCGRAB, if (grab) 1 else 0);
    if (ret != 0) {
        return error.GrabFailed;
    }
}

const UI_SET_EVBIT = linux.IOCTL.IOW('U', 100, u32);

pub fn ui_set_evbit(fd: i32, evbit: event_codes.Type) !void {
    const ret = linux.ioctl(fd, UI_SET_EVBIT, @intFromEnum(evbit));
    if (ret != 0) {
        return error.SetEvBitFailed;
    }
}

const UI_SET_KEYBIT = linux.IOCTL.IOW('U', 101, u32);

pub fn ui_set_keybit(fd: i32, keybit: event_codes.KeyEvent) !void {
    const ret = linux.ioctl(fd, UI_SET_KEYBIT, keybit.code);
    if (ret != 0) {
        return error.SetKeyBitFailed;
    }
}

pub const inputID = extern struct {
    bustype: u16,
    vendor: u16,
    product: u16,
    version: u16,
};
comptime {
    std.debug.assert(@sizeOf(inputID) == 8);
}

const UINPUT_MAX_NAME_SIZE = 80;

pub const uinputSetup = extern struct {
    id: inputID,
    name: [UINPUT_MAX_NAME_SIZE]u8,
    ff_effects_max: u32,
};
comptime {
    std.debug.assert(@sizeOf(uinputSetup) == 92);
}

const UI_DEV_SETUP = linux.IOCTL.IOW('U', 3, uinputSetup);

pub fn ui_dev_setup(fd: i32, setup: *uinputSetup) !void {
    const ret = linux.ioctl(fd, UI_DEV_SETUP, @intFromPtr(setup));
    if (ret != 0) {
        return error.DevSetupFailed;
    }
}

const UI_DEV_CREATE = linux.IOCTL.IO('U', 1);

pub fn ui_dev_create(fd: i32) !void {
    const ret = linux.ioctl(fd, UI_DEV_CREATE, 0);
    if (ret != 0) {
        return error.DevCreateFailed;
    }
}
