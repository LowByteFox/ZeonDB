const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});

    const optimize = b.standardOptimizeOption(.{});

    var network_mod = b.addModule("networking", .{ .source_file = .{ .path = "src/networking/main.zig" } });
    var mem_mod = b.addModule("memory", .{ .source_file = .{ .path = "src/memory/main.zig" } });

    const exe = b.addExecutable(.{
        .name = "ZeonDB",
        .root_source_file = .{ .path = "src/main.zig" },
        .target = target,
        .optimize = optimize,
    });

    const client = b.addExecutable(.{
        .name = "zeonctl",
        .root_source_file = .{ .path = "src/client/main.zig" },
        .target = target,
        .optimize = optimize,
    });

    const toml = b.dependency("zigtoml", .{ .target = target, .optimize = optimize });
    exe.addModule("ztoml", toml.module("zig-toml"));
    exe.addModule("networking", network_mod);
    exe.addModule("memory", mem_mod);

    client.addModule("networking", network_mod);
    client.addModule("memory", mem_mod);

    b.installArtifact(client);
    b.installArtifact(exe);

    exe.linkSystemLibrary("uv");
    client.linkSystemLibrary("uv");
    client.linkLibC();

    const run_cmd = b.addRunArtifact(exe);
    const run_client = b.addRunArtifact(client);

    run_cmd.step.dependOn(b.getInstallStep());
    run_client.step.dependOn(b.getInstallStep());

    if (b.args) |args| {
        run_cmd.addArgs(args);
        run_client.addArgs(args);
    }

    const run_step = b.step("server", "Start the DB");
    const run_client_step = b.step("client", "Run the client");

    run_client_step.dependOn(&run_client.step);
    run_step.dependOn(&run_cmd.step);

    const unit_tests = b.addTest(.{
        .root_source_file = .{ .path = "src/main.zig" },
        .target = target,
        .optimize = optimize,
    });

    const run_unit_tests = b.addRunArtifact(unit_tests);

    const test_step = b.step("test", "Run unit tests");
    test_step.dependOn(&run_unit_tests.step);
}
