const codes = @import("input_event_codes.zig");

pub const ActionType = enum(u32) {
    Press,
    Release,
    Tap,
    BlockKeyboard,
    ReleaseKeyboard,
    NoOp,
    PassLayer,
    ForwardEvent,
};

pub const Action = union(ActionType) {
    Press: codes.KeyEvent,
    Release: codes.KeyEvent,
    Tap: codes.KeyEvent,
    BlockKeyboard,
    ReleaseKeyboard,
    NoOp,
    PassLayer,
    ForwardEvent,
};
