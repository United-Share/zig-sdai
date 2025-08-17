const std = @import("std");

/// Bindings for the TigerBeetle client API.
///
/// This file contains placeholders for the TigerBeetle client functions you may
/// need to integrate.  TigerBeetle is typically used via its own client
/// library; you will likely link its C code here and expose functions to
/// Zig.  See TigerBeetle documentation for details.

pub const tb_client = opaque {};

extern fn tb_client_init(cluster_id: u64, addresses: [*]const u8, client_out: *?*tb_client) c_int;
extern fn tb_client_deinit(client: *tb_client) void;
extern fn tb_submit(client: *tb_client, transfers: [*]const u8, transfer_count: u32) c_int;

pub fn initClient(cluster_id: u64, addr: []const u8) !*tb_client {
    var client: ?*tb_client = null;
    const c_addr = try std.cstr.addNullByte(addr);
    if (tb_client_init(cluster_id, c_addr, &client) != 0) return error("tb_client_init failed");
    return client orelse unreachable;
}

pub fn deinitClient(client: *tb_client) void {
    tb_client_deinit(client);
}

pub fn submitTransfers(client: *tb_client, transfers: []const u8) !void {
    // Example stub; actual usage would depend on the TigerBeetle client API.
    if (tb_submit(client, transfers.ptr, @intCast(u32, transfers.len)) != 0) {
        return error("tb_submit failed");
    }
}