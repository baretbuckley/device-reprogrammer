const std = @import("std");

const layer = @import("layer.zig");
const input = @import("input.zig");

const Profile = @This();
const ConstBitSet = @import("bitset.zig").ConstBitSet;

const ResponseType = enum {
    PressKey,
    ReleaseKey,
    TapKey,
    BlockDevice,
    ReleaseDevice,
    ForwardEvent,
    NoOp,
};

const Response = union(ResponseType) {
    PressKey: input.event_codes.KeyEvent,
    ReleaseKey: input.event_codes.KeyEvent,
    TapKey: input.event_codes.KeyEvent,
    BlockDevice,
    ReleaseDevice,
    ForwardEvent,
    NoOp,
};

const LayerLink = struct {
    back: ?*LayerLink,
    next: ?*LayerLink,
    interface: layer.Interface,

    fn init(interface: layer.Interface) LayerLink {
        return LayerLink{
            .back = null,
            .next = null,
            .interface = interface,
        };
    }

    const empty = LayerLink{
        .back = null,
        .next = null,
        .interface = .empty,
    };
};

alloc: std.mem.Allocator,
layers: std.ArrayList(LayerLink),
first: ?*LayerLink,
last: ?*LayerLink,

pub fn init(alloc: std.mem.Allocator) Profile {
    return Profile{
        .alloc = alloc,
        .layers = .empty,
        .first = null,
        .last = null,
    };
}

pub fn deinit(self: *Profile) void {
    self.layers.deinit(self.alloc);
}

// unique id given to each layer in the profile
// used for referencing layers when modifying layer order
const LayerID = usize;

pub fn addLayer(self: *Profile, layer_interface: layer.Interface) !LayerID {
    const id: LayerID = self.layers.items.len;
    try self.layers.append(self.alloc, LayerLink.init(layer_interface));
    return id;
}

pub fn addEmptyLayer(self: *Profile) !LayerID {
    const id: LayerID = self.layers.items.len;
    try self.layers.append(self.alloc, LayerLink.empty);
    return id;
}

pub fn detatchLayer(self: *Profile, layerID: LayerID) void {
    const layer_ptr = &self.layers.items[layerID];
    // Pop layer from its current placement
    if (layer_ptr.back != null) {
        layer_ptr.back.?.next = layer_ptr.next;
    }
    if (layer_ptr.next != null) {
        layer_ptr.next.?.back = layer_ptr.back;
    }
}

pub fn forwardLayer(self: *Profile, layerID: LayerID) void {
    self.detatchLayer(layerID);
    const layer_ptr = &self.layers.items[layerID];
    // Insert at front of order
    layer_ptr.next = self.first;
    self.first = layer_ptr;
    if (self.last == null) {
        self.last = layer_ptr;
    }
}

pub fn processEvent(self: *Profile, keyState: ConstBitSet, event: input.InputEvent) Response {
    var cur_layer = self.first;
    while (cur_layer != null) {
        const action = cur_layer.?.interface.event_action(keyState, event);
        switch (action) {
            .Press => |key| return .{ .PressKey = key },
            .Release => |key| return .{ .ReleaseKey = key },
            .Tap => |key| return .{ .TapKey = key },
            .BlockKeyboard => return .BlockDevice,
            .ReleaseKeyboard => return .ReleaseDevice,
            .NoOp => return .NoOp,
            .PassLayer => cur_layer = cur_layer.?.next,
            .ForwardEvent => return .ForwardEvent,
        }
    }
    return Response.NoOp;
}
