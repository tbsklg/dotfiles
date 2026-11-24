//! dot – tiny TUI to trigger dotfiles actions.
//! Commands run via /bin/sh in this terminal, so sudo / Touch ID and live output just work.
const std = @import("std");
const config = @import("config.zig");

// Plain libc calls: stable across Zig versions (macOS always links libSystem).
extern "c" fn system(cmd: [*:0]const u8) c_int;
extern "c" fn read(fd: c_int, buf: [*]u8, n: usize) isize;
extern "c" fn write(fd: c_int, buf: [*]const u8, n: usize) isize;

const dir = "~/dotfiles";
const flake = dir ++ "#" ++ config.host;
// Flakes may not be enabled yet on a fresh Nix install.
const nix = "nix --extra-experimental-features 'nix-command flakes'";
const sudo_nix = "sudo \"$(command -v nix)\" --extra-experimental-features 'nix-command flakes'";

const Action = struct {
    label: []const u8,
    cmd: [:0]const u8,
    sudo: bool = false,
};

// Uses the flake-pinned home-manager / darwin-rebuild, so this works before either is installed.
const actions = [_]Action{
    .{ .label = "Update flake inputs", .cmd = nix ++ " flake update --flake " ++ dir },
    .{ .label = "Switch home", .cmd = nix ++ " run " ++ dir ++ "#home-manager -- switch --flake " ++ flake ++ " -b before-home-manager" },
    .{ .label = "Brew upgrade", .cmd = "brew upgrade" },
    .{ .label = "Sync Neovim plugins", .cmd = "nvim --headless '+Lazy! sync' +qa" },
    .{ .label = "Show changes", .cmd = "git -C " ++ dir ++ " status --short && git -C " ++ dir ++ " diff --stat" },
    .{ .label = "Switch system", .cmd = sudo_nix ++ " run " ++ dir ++ "#darwin-rebuild -- switch --flake " ++ flake, .sudo = true },
    .{ .label = "Apply macOS settings", .cmd = sudo_nix ++ " run " ++ dir ++ "#darwin-rebuild -- switch --flake " ++ flake ++ "-macos", .sudo = true },
};

fn out(s: []const u8) void {
    _ = write(1, s.ptr, s.len);
}

fn menuMode(on: bool) void {
    if (on) {
        _ = system("stty -icanon -echo -isig");
        out("\x1b[?25l"); // hide cursor
    } else {
        _ = system("stty icanon echo isig");
        out("\x1b[?25h");
    }
}

fn readKey(buf: []u8) []const u8 {
    const n = read(0, buf.ptr, buf.len);
    if (n <= 0) return "q";
    return buf[0..@intCast(n)];
}

fn draw(sel: usize, status: []const u8) void {
    out("\x1b[2J\x1b[H");
    out(" dotfiles \x1b[2m·\x1b[0m " ++ config.host ++ "\n");
    out(" \x1b[2m─────────────────────────────\x1b[0m\n");
    for (actions, 0..) |a, i| {
        out(if (i == sel) " \x1b[7m › " else "   ");
        out(a.label);
        out(if (i == sel) " \x1b[0m" else " ");
        if (a.sudo) out(" \x1b[33msudo\x1b[0m");
        out("\n");
    }
    out(" \x1b[2m─────────────────────────────\x1b[0m\n");
    out(" \x1b[2m↑↓/jk move · enter run · q quit\x1b[0m\n");
    if (status.len > 0) {
        out("\n ");
        out(status);
        out("\n");
    }
}

fn run(a: Action, status_buf: []u8) []const u8 {
    menuMode(false);
    out("\x1b[2J\x1b[H\x1b[1m› ");
    out(a.label);
    out("\x1b[0m\n\x1b[2m$ ");
    out(a.cmd);
    out("\x1b[0m\n\n");

    const rc = system(a.cmd.ptr);
    const code: u32 = @intCast((rc >> 8) & 0xff);

    const status = if (rc == 0)
        std.fmt.bufPrint(status_buf, "\x1b[32m✓\x1b[0m {s}", .{a.label}) catch ""
    else
        std.fmt.bufPrint(status_buf, "\x1b[31m✗\x1b[0m {s} (exit {d})", .{ a.label, code }) catch "";

    out("\n");
    out(status);
    out("\n\x1b[2mpress any key\x1b[0m");
    menuMode(true);
    var buf: [8]u8 = undefined;
    _ = readKey(&buf);
    return status;
}

pub fn main() void {
    var sel: usize = 0;
    var status_buf: [256]u8 = undefined;
    var status: []const u8 = "";

    menuMode(true);
    defer {
        menuMode(false);
        out("\x1b[2J\x1b[H");
    }

    while (true) {
        draw(sel, status);
        var buf: [8]u8 = undefined;
        const key = readKey(&buf);

        if (std.mem.eql(u8, key, "\x1b[A") or std.mem.eql(u8, key, "k")) {
            sel = (sel + actions.len - 1) % actions.len;
        } else if (std.mem.eql(u8, key, "\x1b[B") or std.mem.eql(u8, key, "j")) {
            sel = (sel + 1) % actions.len;
        } else if (key[0] == '\n' or key[0] == '\r') {
            status = run(actions[sel], &status_buf);
        } else if (key[0] == 'q' or key[0] == 3 or std.mem.eql(u8, key, "\x1b")) {
            return; // q, Ctrl-C, Esc
        }
    }
}
