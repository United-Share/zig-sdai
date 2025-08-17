const std = @import("std");

// This build script configures the UnitedShare application server and related targets.
// It is a starting point for the unified codebase described in our architecture.

pub fn build(b: *std.Build) void {
    // Set up the target and optimization based on the host build settings.
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    // Build the Zig application server.  The root_source_file points to our main Zig file
    // in the apps/server/src folder.

    // Create a LazyPath for the main source file.  In Zig 0.14+, you
    // cannot specify a `.path` field directly on `root_source_file` — you
    // must provide a `std.Build.LazyPath` value via `b.path()`.  See
    // https://ziglang.org/documentation/master/std/#Build.LazyPath for details.
    const main_path = b.path("apps/server/src/main.zig");
    const server_exe = b.addExecutable(.{
        .name = "us_server",
        .root_source_file = main_path,
        .target = target,
        .optimize = optimize,
    });

    // Link against the system C library and OpenSSL for TLS support if needed.
    // Note: `linkSystemLibrary` automatically pulls in transitive dependencies;
    // linking libc twice is unnecessary, so we call it just once.
    server_exe.linkLibC();
    server_exe.linkSystemLibrary("ssl");
    server_exe.linkSystemLibrary("crypto");

    // In the future, you can add more dependencies here (e.g. static libraries for DuckDB, TigerBeetle,
    // or C++ plugins).  For now we only set up the core server.

    // Install the server binary so that `zig build` places it in zig-out/bin by default.
    // Install the server binary so that `zig build` places it in zig-out/bin.
    b.installArtifact(server_exe);

    // Optionally, you can add a custom run step.  This allows `zig build run` to execute the server
    // after building.  Uncomment the following lines if you want this behaviour:
    // const run_cmd = server_exe.run();
    // b.step("run", "Run the application server").dependOn(&run_cmd.step);
}