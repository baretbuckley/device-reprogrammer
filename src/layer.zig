const std = @import("std");
const action = @import("action.zig");
const input = @import("input.zig");
const codes = input.event_codes;
const BitSet = @import("bitset.zig");
const ConstBitSet = BitSet.ConstBitSet;

pub const VTable = struct {};

// alloc: *const fn (*anyopaque, len: usize, alignment: Alignment, ret_addr: usize) ?[*]u8,
pub const Interface = struct {
    ptr: *anyopaque,
    v_event_action: *const fn (*anyopaque, keyState: ConstBitSet, event: input.InputEvent) action.Action,

    pub fn impl_by(impl_obj: anytype) Interface {
        const delegate = InterfaceDelegate(impl_obj);
        return .{
            .ptr = impl_obj,
            .v_event_action = delegate.event_action,
        };
    }

    pub fn event_action(self: Interface, keyState: ConstBitSet, event: input.InputEvent) action.Action {
        return self.v_event_action(self.ptr, keyState, event);
    }

    pub const empty: Interface = noOpEventInterface;
};

inline fn InterfaceDelegate(impl_obj: anytype) type {
    const ImplType = @TypeOf(impl_obj);
    return struct {
        fn event_action(impl: *anyopaque, keyState: ConstBitSet, event: input.InputEvent) action.Action {
            return TPtr(ImplType, impl).event_action(keyState, event);
        }
    };
}

fn TPtr(T: type, opaque_ptr: *anyopaque) T {
    return @as(T, @ptrCast(@alignCast(opaque_ptr)));
}

// Simple Layer interfaces

// Simple interface which returns a no op action regardless of input
// Expected behavior is that no action will be taken
pub const noOpEventInterface: Interface = .{
    .ptr = undefined,
    .v_event_action = struct {
        fn ea(self: *anyopaque, keyState: ConstBitSet, event: input.InputEvent) action.Action {
            _ = self;
            _ = keyState;
            _ = event;
            return action.Action.NoOp;
        }
    }.ea,
};

// Simple interface which returns a forward event action regardless of input
// Expected behavior of layer is to forward input device events to the virual output device
pub const forwardEventInterface: Interface = .{
    .ptr = undefined,
    .v_event_action = struct {
        fn ea(self: *anyopaque, keyState: ConstBitSet, event: input.InputEvent) action.Action {
            _ = self;
            _ = keyState;
            _ = event;
            return action.Action.ForwardEvent;
        }
    }.ea,
};

// Complex layers

// Activates
pub const HotKeylayer = struct {
    activation_key: codes.KeyEvent,
    required: []codes.KeyEvent,
    response: action.Action,

    fn keyEventLessThan(context: void, l: codes.KeyEvent, r: codes.KeyEvent) bool {
        _ = context;
        return l.code < r.code;
    }

    pub fn init(activation: codes.KeyEvent, required: []codes.KeyEvent, response: action.Action) HotKeylayer {
        std.sort.insertion(codes.KeyEvent, required, {}, keyEventLessThan);
        return .{
            .activation_key = activation,
            .required = required,
            .response = response,
        };
    }

    pub fn event_action(self: *HotKeylayer, keyState: ConstBitSet, event: input.InputEvent) action.Action {
        if (event.event_type != codes.Type.Key or event.code != self.activation_key.code or event.value != 1) {
            return action.Action.PassLayer;
        }
        var idx: usize = 0;
        for (keyState.data, 0..) |blkval, blk_idx| {
            var blk = blkval;
            // If the block contains the activation key, set it off to not mess with check
            if (blk_idx == self.activation_key.code / 32) {
                blk &= ~(@as(u32, 1) << @intCast(self.activation_key.code % 32));
            }

            // // If no requied keys are in the current block, ensure no keys are pressed
            // if (blk_idx != self.required[idx].code / 32) {
            //     if (blk != 0) {
            //         return action.Action.PassLayer;
            //     } else {
            //         continue;
            //     }
            // }

            // For each required key contained in the block, confirm they are on, then turn off
            while (idx < self.required.len and self.required[idx].code / 32 == blk_idx) {
                // Check if required key is pressed, then turn it off in the block
                if (blk & (@as(u32, 1) << @intCast(self.required[idx].code % 32)) == 0) {
                    return action.Action.PassLayer;
                }
                blk &= ~(@as(u32, 1) << @intCast(self.required[idx].code % 32));
                idx += 1;
            }

            if (blk != 0) {
                return action.Action.PassLayer;
            }
        }

        return self.response;
    }

    pub fn interface(self: *HotKeylayer) Interface {
        return Interface.impl_by(self);
    }
};

pub const TestLayer = struct {
    pub fn init() TestLayer {
        return TestLayer{};
    }

    pub fn event_action(self: *TestLayer, keyState: ConstBitSet, event: input.InputEvent) action.Action {
        _ = self;
        if (event.event_type == codes.Type.Key and event.code == codes.KeyEvent.KEY_Q.code and event.value == 1) {
            return action.Action.BlockKeyboard;
        } else if (event.event_type == codes.Type.Key and event.code == codes.KeyEvent.KEY_W.code and event.value == 1) {
            return action.Action.ReleaseKeyboard;
        } else if (event.event_type == codes.Type.Key and event.code == codes.KeyEvent.KEY_E.code and event.value == 1) {
            return action.Action{ .Tap = codes.KeyEvent.KEY_A };
        } else if (event.event_type == codes.Type.Key and event.value == 1 and keyState.get(codes.KeyEvent.KEY_P.code)) {
            return action.Action{ .Tap = codes.KeyEvent.KEY_P };
        } else {
            return action.Action.PassLayer;
        }
    }

    pub fn interface(self: *TestLayer) Interface {
        return Interface.impl_by(self);
    }
};
