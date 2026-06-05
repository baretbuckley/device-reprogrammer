const BitSet = @This();

data: []u32,

pub const ConstBitSet = struct {
    data: []const u32,

    pub fn get(self: ConstBitSet, idx: usize) bool {
        return self.data[idx / 32] & (@as(u32, 1) << @intCast(idx % 32)) != 0;
    }
};

pub fn neededSize(capacity: comptime_int) comptime_int {
    return (capacity + 31) / 32;
}

pub fn init(data: []u32) BitSet {
    return .{ .data = data };
}

pub fn get(self: BitSet, idx: usize) bool {
    return self.data[idx / 32] & (@as(u32, 1) << @intCast(idx % 32)) != 0;
}

pub fn set(self: BitSet, idx: usize) void {
    self.data[idx / 32] |= (@as(u32, 1) << @intCast(idx % 32));
}

pub fn clear(self: BitSet, idx: usize) void {
    self.data[idx / 32] &= ~(@as(u32, 1) << @intCast(idx % 32));
}

pub fn asConst(self: BitSet) ConstBitSet {
    return .{ .data = self.data };
}
