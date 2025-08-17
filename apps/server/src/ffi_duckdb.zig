const std = @import("std");

/// Bindings to the DuckDB C API.
///
/// This file declares the minimal pieces needed to interact with DuckDB from Zig.
/// You can expand these declarations to suit your needs, or generate them using
/// Zig's `translate-c` on the DuckDB headers.

pub const duckdb_database = opaque {};
pub const duckdb_connection = opaque {};
pub const duckdb_result = opaque {};

extern fn duckdb_open(path: ?[*:0]const u8, out_db: *?*duckdb_database) c_int;
extern fn duckdb_close(out_db: *?*duckdb_database) void;
extern fn duckdb_connect(db: ?*duckdb_database, out_conn: *?*duckdb_connection) c_int;
extern fn duckdb_disconnect(out_conn: *?*duckdb_connection) void;
extern fn duckdb_query(conn: ?*duckdb_connection, query: [*:0]const u8, out_result: *duckdb_result) c_int;
extern fn duckdb_destroy_result(res: *duckdb_result) void;

pub const C = struct {
    pub usingnamespace @cImport({
        @cInclude("duckdb.h");
    });
};

pub fn openDatabase(path: ?[*:0]const u8) !*duckdb_database {
    var db: ?*duckdb_database = null;
    if (duckdb_open(path, &db) != 0) return error("duckdb_open failed");
    return db orelse unreachable;
}

pub fn connect(db: *duckdb_database) !*duckdb_connection {
    var conn: ?*duckdb_connection = null;
    if (duckdb_connect(db, &conn) != 0) return error("duckdb_connect failed");
    return conn orelse unreachable;
}

pub fn query(conn: *duckdb_connection, sql: []const u8) !duckdb_result {
    var res: duckdb_result = undefined;
    const c_str = try std.cstr.addNullByte(sql);
    if (duckdb_query(conn, c_str, &res) != 0) return error("duckdb_query failed");
    return res;
}

pub fn destroyResult(res: *duckdb_result) void {
    duckdb_destroy_result(res);
}