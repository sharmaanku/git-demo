const std = @import("std");

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();

    // List of required environment variables
    const required_vars = [_][]const u8{
        "ENV",
        "DB_HOST",
        "API_KEY",
    };

    var missing = false;

    for (required_vars) |var_name| {
        const value = std.os.getenv(var_name);

        if (value == null) {
            try stdout.print("❌ Missing: {s}\n", .{var_name});
            missing = true;
        } else {
            try stdout.print("✅ Found: {s} = {s}\n", .{var_name, value.?});
        }
    }

    if (missing) {
        std.debug.print("\nERROR: Some environment variables are missing!\n", .{});
        std.os.exit(1);
    } else {
        std.debug.print("\nAll environment variables are valid.\n", .{});
    }
}
