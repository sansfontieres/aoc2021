//! Using zig 0.9.0-dev.something
const std = @import("std");

pub fn build(b: *std.build.Builder) void {
    const target = b.standardTargetOptions(.{});

    const mode = b.standardReleaseOptions();

    var i: u32 = 1;
    while (i <= 25) : (i += 1) {
        const template = b.fmt("day{:0>2}", .{i});
        const src = b.fmt("src/{s}.zig", .{template});
        const exe = b.addExecutable(template, src);
        exe.setTarget(target);
        exe.setBuildMode(mode);
        exe.install();
        const run_cmd = exe.run();

        run_cmd.step.dependOn(b.getInstallStep());
        if (b.args) |args| {
            run_cmd.addArgs(args);
        }

        const description = b.fmt("Run {s}", .{template});
        const run_step = b.step(template, description);
        run_step.dependOn(&run_cmd.step);
    }
}
