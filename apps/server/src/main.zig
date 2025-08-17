const std = @import("std");
const PluginHost = @import("plugin_host.zig");

/// Entry point for the UnitedShare Zig application server.
///
/// This function initializes the server runtime, loads any available
/// plugins, and then proceeds to run the application.  At this stage
/// the implementation is intentionally simple: we attempt to load
/// plugins from a default directory and then print a message.  You can
/// extend this to start an HTTP/WebSocket server using `std.http` or
/// another library, handle command-line arguments, etc.
pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    // Determine the plugin directory.  You could parse command-line
    // arguments here; for now we default to "plugins" relative to the
    // current working directory.  If the directory does not exist,
    // `loadPlugins` will log a message and return gracefully.
    const plugin_dir = "plugins";
    // Attempt to load plugins.  Errors are logged but not fatal here.
    PluginHost.loadPlugins(plugin_dir) catch |err| {
        std.log.warn("Failed to load plugins from {s}: {s}", .{ plugin_dir, @errorName(err) });
    };

    // TODO: Initialize your FluentScript runtime and HTTP/WebSocket server
    // here.  For now, we simply acknowledge startup and exit.
    std.log.info("UnitedShare Zig Server initialised (plugins directory: {s})", .{plugin_dir});
}