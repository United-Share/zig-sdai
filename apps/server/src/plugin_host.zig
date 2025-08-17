const std = @import("std");

/// Plugin host and loader.
///
/// The application server can be extended via plugins.  This module provides
/// the skeleton for loading shared libraries at runtime and managing their
/// lifecycle.  Each plugin should expose a `createPlugin()` function that
/// returns an instance implementing a common interface.

pub fn loadPlugins(dir: []const u8) !void {
    // TODO: Discover and load plugins from the given directory.
    // On Unix-like systems, you can use `dlopen` via @cImport("dlfcn.h") and
    // then lookup symbol `createPlugin`.  For now, this is unimplemented.
    std.log.info("Loading plugins from {s} (not yet implemented)", .{dir});
}