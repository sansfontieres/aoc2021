const std = @import("std");
const data = @embedFile("../data/day02.txt");

const Path = enum { forward, up, down };

pub fn main() anyerror!void {
    // Part 1
    var lines = std.mem.tokenize(u8, data, "\n");
    var horizontal: u32 = 0;
    var depth: u32 = 0;

    while (lines.next()) |line| {
        const space = std.mem.indexOfScalar(u8, line, ' ').?;
        const path = std.meta.stringToEnum(Path, line[0..space]).?;
        const distance = try std.fmt.parseInt(u32, line[space + 1 ..], 10);

        switch (path) {
            .forward => horizontal += distance,
            .up => depth -= distance,
            .down => depth += distance,
        }
    }
    const p1_coordinate = horizontal * depth;

    // Part 2
    lines = std.mem.tokenize(u8, data, "\n");
    horizontal = 0;
    depth = 0;
    var aim: u32 = 0;

    while (lines.next()) |line| {
        const space = std.mem.indexOfScalar(u8, line, ' ').?;
        const path = std.meta.stringToEnum(Path, line[0..space]).?;
        const distance = try std.fmt.parseInt(u32, line[space + 1 ..], 10);

        switch (path) {
            .forward => {
                horizontal += distance;
                depth += aim * distance;
            },
            .up => aim -= distance,
            .down => aim += distance,
        }
    }

    const p2_coordinate = horizontal * depth;

    std.debug.print(" First part:  {}\n", .{p1_coordinate});
    std.debug.print("Second part:  {}\n", .{p2_coordinate});
}
