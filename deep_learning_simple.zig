const std = @import("std");

// const round = std.math.round;

fn directSolution(targetString: []const u8, allocator: std.mem.Allocator) ![]f16 {
    var solutionArr = std.ArrayList(f16).init(allocator);

    for (targetString) |char| {
        const val: f16 = (@as(f16, @floatFromInt(char)) - 32) / 100.0;
        try solutionArr.append(val);
    }

    return solutionArr.toOwnedSlice();
}

fn forward(weights: []f16, allocator: std.mem.Allocator) ![]u8 {
    var solutionArr = std.ArrayList(u8).init(allocator);

    for (weights) |value| {
        const roundedValue = @as(u8, @intFromFloat(@round(value * 100)));
        const val: u8 = 32 + (roundedValue & 95);
        try solutionArr.append(val);
    }

    return solutionArr.toOwnedSlice();
}

fn loss(output: []u8, target: []const u8) !f16 {
    var lossValue: f16 = 0.0;

    for (output, target) |o, t| {
        lossValue += (o - t);
    }

    return lossValue;
}

pub fn main() !void {
    // std.debug.print("{d}\n", .{@exp2(4.0)});
    // Init allocator
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer {
        const deinit_status = gpa.deinit();
        if (deinit_status == .leak) std.testing.expect(false) catch @panic("TEST FAIL");
    }

    const targetStr = "out";
    const weightsDirect = directSolution(targetStr, gpa.allocator()) catch |err| {
        std.log.err("failed to get weights: {s}\n", .{err});
        return;
    };

    const outputDirect = forward(weightsDirect, gpa.allocator()) catch |err| {
        std.log.err("propogation failed: {s}\n", .{err});
        return;
    };

    const lossDirect = loss(outputDirect, targetStr) catch |err| {
        std.log.err("loss output failed: {s}\n", .{err});
        return;
    };

    const pr = std.io.getStdOut().writer();
    try pr.print("Direct solution weights: {}\n", .{weightsDirect});
    try pr.print("Forward output: {}\n", .{outputDirect});
    try pr.print("Loss: {}\n", .{lossDirect});
}
