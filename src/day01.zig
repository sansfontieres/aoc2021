const std = @import("std");
const data = @embedFile("../data/day01.txt");

pub fn main() anyerror!void {
    // Part 1
    var lines = std.mem.tokenize(u8, data, "\n");
    var p1_increases: u32 = 0;
    var previous: u32 = try std.fmt.parseInt(u32, lines.next().?, 10);

    while (lines.next()) |line| {
        const depth = try std.fmt.parseInt(u32, line, 10);
        if (previous < depth) p1_increases += 1;
        previous = depth;
    }

    // Part 2
    lines = std.mem.tokenize(u8, data, "\n");
    var p2_increases: u32 = 0;
    var window: [3]u32 = undefined;
    for (window) |_, i| {
        window[i] = try std.fmt.parseInt(u32, lines.next().?, 10);
    }

    while (lines.next()) |line| {
        const depth = try std.fmt.parseInt(u32, line, 10);
        previous = window[0] + window[1] + window[2];
        window[0] = depth;
        std.mem.rotate(u32, window[0..], 1);
        const new = window[0] + window[1] + window[2];
        if (previous < new) p2_increases += 1;
    }

    std.debug.print(" First part:  {}\n", .{p1_increases});
    std.debug.print("Second part:  {}\n", .{p2_increases});
}
