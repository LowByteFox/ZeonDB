pub const __builtin_bswap16 = @import("std").zig.c_builtins.__builtin_bswap16;
pub const __builtin_bswap32 = @import("std").zig.c_builtins.__builtin_bswap32;
pub const __builtin_bswap64 = @import("std").zig.c_builtins.__builtin_bswap64;
pub const __builtin_signbit = @import("std").zig.c_builtins.__builtin_signbit;
pub const __builtin_signbitf = @import("std").zig.c_builtins.__builtin_signbitf;
pub const __builtin_popcount = @import("std").zig.c_builtins.__builtin_popcount;
pub const __builtin_ctz = @import("std").zig.c_builtins.__builtin_ctz;
pub const __builtin_clz = @import("std").zig.c_builtins.__builtin_clz;
pub const __builtin_sqrt = @import("std").zig.c_builtins.__builtin_sqrt;
pub const __builtin_sqrtf = @import("std").zig.c_builtins.__builtin_sqrtf;
pub const __builtin_sin = @import("std").zig.c_builtins.__builtin_sin;
pub const __builtin_sinf = @import("std").zig.c_builtins.__builtin_sinf;
pub const __builtin_cos = @import("std").zig.c_builtins.__builtin_cos;
pub const __builtin_cosf = @import("std").zig.c_builtins.__builtin_cosf;
pub const __builtin_exp = @import("std").zig.c_builtins.__builtin_exp;
pub const __builtin_expf = @import("std").zig.c_builtins.__builtin_expf;
pub const __builtin_exp2 = @import("std").zig.c_builtins.__builtin_exp2;
pub const __builtin_exp2f = @import("std").zig.c_builtins.__builtin_exp2f;
pub const __builtin_log = @import("std").zig.c_builtins.__builtin_log;
pub const __builtin_logf = @import("std").zig.c_builtins.__builtin_logf;
pub const __builtin_log2 = @import("std").zig.c_builtins.__builtin_log2;
pub const __builtin_log2f = @import("std").zig.c_builtins.__builtin_log2f;
pub const __builtin_log10 = @import("std").zig.c_builtins.__builtin_log10;
pub const __builtin_log10f = @import("std").zig.c_builtins.__builtin_log10f;
pub const __builtin_abs = @import("std").zig.c_builtins.__builtin_abs;
pub const __builtin_fabs = @import("std").zig.c_builtins.__builtin_fabs;
pub const __builtin_fabsf = @import("std").zig.c_builtins.__builtin_fabsf;
pub const __builtin_floor = @import("std").zig.c_builtins.__builtin_floor;
pub const __builtin_floorf = @import("std").zig.c_builtins.__builtin_floorf;
pub const __builtin_ceil = @import("std").zig.c_builtins.__builtin_ceil;
pub const __builtin_ceilf = @import("std").zig.c_builtins.__builtin_ceilf;
pub const __builtin_trunc = @import("std").zig.c_builtins.__builtin_trunc;
pub const __builtin_truncf = @import("std").zig.c_builtins.__builtin_truncf;
pub const __builtin_round = @import("std").zig.c_builtins.__builtin_round;
pub const __builtin_roundf = @import("std").zig.c_builtins.__builtin_roundf;
pub const __builtin_strlen = @import("std").zig.c_builtins.__builtin_strlen;
pub const __builtin_strcmp = @import("std").zig.c_builtins.__builtin_strcmp;
pub const __builtin_object_size = @import("std").zig.c_builtins.__builtin_object_size;
pub const __builtin___memset_chk = @import("std").zig.c_builtins.__builtin___memset_chk;
pub const __builtin_memset = @import("std").zig.c_builtins.__builtin_memset;
pub const __builtin___memcpy_chk = @import("std").zig.c_builtins.__builtin___memcpy_chk;
pub const __builtin_memcpy = @import("std").zig.c_builtins.__builtin_memcpy;
pub const __builtin_expect = @import("std").zig.c_builtins.__builtin_expect;
pub const __builtin_nanf = @import("std").zig.c_builtins.__builtin_nanf;
pub const __builtin_huge_valf = @import("std").zig.c_builtins.__builtin_huge_valf;
pub const __builtin_inff = @import("std").zig.c_builtins.__builtin_inff;
pub const __builtin_isnan = @import("std").zig.c_builtins.__builtin_isnan;
pub const __builtin_isinf = @import("std").zig.c_builtins.__builtin_isinf;
pub const __builtin_isinf_sign = @import("std").zig.c_builtins.__builtin_isinf_sign;
pub const __has_builtin = @import("std").zig.c_builtins.__has_builtin;
pub const __builtin_assume = @import("std").zig.c_builtins.__builtin_assume;
pub const __builtin_unreachable = @import("std").zig.c_builtins.__builtin_unreachable;
pub const __builtin_constant_p = @import("std").zig.c_builtins.__builtin_constant_p;
pub const __builtin_mul_overflow = @import("std").zig.c_builtins.__builtin_mul_overflow;
pub extern var sys_nerr: c_int;
pub const sys_errlist: [*c][*c]u8 = @extern([*c][*c]u8, .{
    .name = "sys_errlist",
});
pub extern fn __errno() [*c]c_int;
pub const ptrdiff_t = c_long;
pub const wchar_t = c_int;
pub const max_align_t = extern struct {
    __clang_max_align_nonce1: c_longlong align(8),
    __clang_max_align_nonce2: c_longdouble align(16),
};
pub const __int8_t = i8;
pub const __uint8_t = u8;
pub const __int16_t = c_short;
pub const __uint16_t = c_ushort;
pub const __int32_t = c_int;
pub const __uint32_t = c_uint;
pub const __int64_t = c_longlong;
pub const __uint64_t = c_ulonglong;
pub const __int_least8_t = __int8_t;
pub const __uint_least8_t = __uint8_t;
pub const __int_least16_t = __int16_t;
pub const __uint_least16_t = __uint16_t;
pub const __int_least32_t = __int32_t;
pub const __uint_least32_t = __uint32_t;
pub const __int_least64_t = __int64_t;
pub const __uint_least64_t = __uint64_t;
pub const __int_fast8_t = __int32_t;
pub const __uint_fast8_t = __uint32_t;
pub const __int_fast16_t = __int32_t;
pub const __uint_fast16_t = __uint32_t;
pub const __int_fast32_t = __int32_t;
pub const __uint_fast32_t = __uint32_t;
pub const __int_fast64_t = __int64_t;
pub const __uint_fast64_t = __uint64_t;
pub const __intptr_t = c_long;
pub const __uintptr_t = c_ulong;
pub const __intmax_t = __int64_t;
pub const __uintmax_t = __uint64_t;
pub const __register_t = c_long;
pub const __vaddr_t = c_ulong;
pub const __paddr_t = c_ulong;
pub const __vsize_t = c_ulong;
pub const __psize_t = c_ulong;
pub const __double_t = f64;
pub const __float_t = f32;
pub const __ptrdiff_t = c_long;
pub const __size_t = c_ulong;
pub const __ssize_t = c_long;
pub const struct___va_list_tag = extern struct {
    gp_offset: c_uint,
    fp_offset: c_uint,
    overflow_arg_area: ?*anyopaque,
    reg_save_area: ?*anyopaque,
};
pub const __builtin_va_list = [1]struct___va_list_tag;
pub const __va_list = __builtin_va_list;
pub const __wchar_t = c_int;
pub const __wint_t = c_int;
pub const __rune_t = c_int;
pub const __wctrans_t = ?*anyopaque;
pub const __wctype_t = ?*anyopaque;
pub const __blkcnt_t = __int64_t;
pub const __blksize_t = __int32_t;
pub const __clock_t = __int64_t;
pub const __clockid_t = __int32_t;
pub const __cpuid_t = c_ulong;
pub const __dev_t = __int32_t;
pub const __fixpt_t = __uint32_t;
pub const __fsblkcnt_t = __uint64_t;
pub const __fsfilcnt_t = __uint64_t;
pub const __gid_t = __uint32_t;
pub const __id_t = __uint32_t;
pub const __in_addr_t = __uint32_t;
pub const __in_port_t = __uint16_t;
pub const __ino_t = __uint64_t;
pub const __key_t = c_long;
pub const __mode_t = __uint32_t;
pub const __nlink_t = __uint32_t;
pub const __off_t = __int64_t;
pub const __pid_t = __int32_t;
pub const __rlim_t = __uint64_t;
pub const __sa_family_t = __uint8_t;
pub const __segsz_t = __int32_t;
pub const __socklen_t = __uint32_t;
pub const __suseconds_t = c_long;
pub const __time_t = __int64_t;
pub const __timer_t = __int32_t;
pub const __uid_t = __uint32_t;
pub const __useconds_t = __uint32_t;
pub const __mbstate_t = extern union {
    __mbstate8: [128]u8,
    __mbstateL: __int64_t,
}; // /usr/include/machine/endian.h:37:2: warning: TODO implement translation of stmt class GCCAsmStmtClass
// /usr/include/machine/endian.h:35:1: warning: unable to translate function, demoted to extern
pub extern fn __swap16md(arg__x: __uint16_t) callconv(.C) __uint16_t; // /usr/include/machine/endian.h:44:2: warning: TODO implement translation of stmt class GCCAsmStmtClass
// /usr/include/machine/endian.h:42:1: warning: unable to translate function, demoted to extern
pub extern fn __swap32md(arg__x: __uint32_t) callconv(.C) __uint32_t; // /usr/include/machine/endian.h:51:2: warning: TODO implement translation of stmt class GCCAsmStmtClass
// /usr/include/machine/endian.h:49:1: warning: unable to translate function, demoted to extern
pub extern fn __swap64md(arg__x: __uint64_t) callconv(.C) __uint64_t;
pub const u_char = u8;
pub const u_short = c_ushort;
pub const u_int = c_uint;
pub const u_long = c_ulong;
pub const unchar = u8;
pub const ushort = c_ushort;
pub const uint = c_uint;
pub const ulong = c_ulong;
pub const cpuid_t = __cpuid_t;
pub const register_t = __register_t;
pub const u_int8_t = __uint8_t;
pub const u_int16_t = __uint16_t;
pub const u_int32_t = __uint32_t;
pub const u_int64_t = __uint64_t;
pub const quad_t = __int64_t;
pub const u_quad_t = __uint64_t;
pub const vaddr_t = __vaddr_t;
pub const paddr_t = __paddr_t;
pub const vsize_t = __vsize_t;
pub const psize_t = __psize_t;
pub const blkcnt_t = __blkcnt_t;
pub const blksize_t = __blksize_t;
pub const caddr_t = [*c]u8;
pub const daddr32_t = __int32_t;
pub const daddr_t = __int64_t;
pub const dev_t = __dev_t;
pub const fixpt_t = __fixpt_t;
pub const gid_t = __gid_t;
pub const id_t = __id_t;
pub const ino_t = __ino_t;
pub const key_t = __key_t;
pub const mode_t = __mode_t;
pub const nlink_t = __nlink_t;
pub const rlim_t = __rlim_t;
pub const segsz_t = __segsz_t;
pub const uid_t = __uid_t;
pub const useconds_t = __useconds_t;
pub const suseconds_t = __suseconds_t;
pub const fsblkcnt_t = __fsblkcnt_t;
pub const fsfilcnt_t = __fsfilcnt_t;
pub const clock_t = __clock_t;
pub const clockid_t = __clockid_t;
pub const pid_t = __pid_t;
pub const time_t = __time_t;
pub const timer_t = __timer_t;
pub const off_t = __off_t;
pub extern fn lseek(c_int, off_t, c_int) off_t;
pub extern fn ftruncate(c_int, off_t) c_int;
pub extern fn truncate([*c]const u8, off_t) c_int;
pub const fpos_t = off_t;
pub const struct___sbuf = extern struct {
    _base: [*c]u8,
    _size: c_int,
};
pub const struct___sFILE = extern struct {
    _p: [*c]u8,
    _r: c_int,
    _w: c_int,
    _flags: c_short,
    _file: c_short,
    _bf: struct___sbuf,
    _lbfsize: c_int,
    _cookie: ?*anyopaque,
    _close: ?*const fn (?*anyopaque) callconv(.C) c_int,
    _read: ?*const fn (?*anyopaque, [*c]u8, c_int) callconv(.C) c_int,
    _seek: ?*const fn (?*anyopaque, fpos_t, c_int) callconv(.C) fpos_t,
    _write: ?*const fn (?*anyopaque, [*c]const u8, c_int) callconv(.C) c_int,
    _ext: struct___sbuf,
    _up: [*c]u8,
    _ur: c_int,
    _ubuf: [3]u8,
    _nbuf: [1]u8,
    _lb: struct___sbuf,
    _blksize: c_int,
    _offset: fpos_t,
};
pub const FILE = struct___sFILE;
pub const __sF: [*c]FILE = @extern([*c]FILE, .{
    .name = "__sF",
});
pub extern fn clearerr([*c]FILE) void;
pub extern fn dprintf(c_int, noalias [*c]const u8, ...) c_int;
pub extern fn fclose([*c]FILE) c_int;
pub extern fn feof([*c]FILE) c_int;
pub extern fn ferror([*c]FILE) c_int;
pub extern fn fflush([*c]FILE) c_int;
pub extern fn fgetc([*c]FILE) c_int;
pub extern fn fgetpos([*c]FILE, [*c]fpos_t) c_int;
pub extern fn fgets([*c]u8, c_int, [*c]FILE) [*c]u8;
pub extern fn fopen([*c]const u8, [*c]const u8) [*c]FILE;
pub extern fn fprintf([*c]FILE, [*c]const u8, ...) c_int;
pub extern fn fputc(c_int, [*c]FILE) c_int;
pub extern fn fputs([*c]const u8, [*c]FILE) c_int;
pub extern fn fread(?*anyopaque, c_ulong, c_ulong, [*c]FILE) c_ulong;
pub extern fn freopen([*c]const u8, [*c]const u8, [*c]FILE) [*c]FILE;
pub extern fn fscanf(noalias [*c]FILE, noalias [*c]const u8, ...) c_int;
pub extern fn fseek([*c]FILE, c_long, c_int) c_int;
pub extern fn fseeko([*c]FILE, off_t, c_int) c_int;
pub extern fn fsetpos([*c]FILE, [*c]const fpos_t) c_int;
pub extern fn ftell([*c]FILE) c_long;
pub extern fn ftello([*c]FILE) off_t;
pub extern fn fwrite(?*const anyopaque, c_ulong, c_ulong, [*c]FILE) c_ulong;
pub extern fn getc([*c]FILE) c_int;
pub extern fn getchar() c_int;
pub extern fn getdelim(noalias [*c][*c]u8, noalias [*c]usize, c_int, noalias [*c]FILE) isize;
pub extern fn getline(noalias [*c][*c]u8, noalias [*c]usize, noalias [*c]FILE) isize;
pub extern fn perror([*c]const u8) void;
pub extern fn printf([*c]const u8, ...) c_int;
pub extern fn putc(c_int, [*c]FILE) c_int;
pub extern fn putchar(c_int) c_int;
pub extern fn puts([*c]const u8) c_int;
pub extern fn remove([*c]const u8) c_int;
pub extern fn rename([*c]const u8, [*c]const u8) c_int;
pub extern fn renameat(c_int, [*c]const u8, c_int, [*c]const u8) c_int;
pub extern fn rewind([*c]FILE) void;
pub extern fn scanf(noalias [*c]const u8, ...) c_int;
pub extern fn setbuf([*c]FILE, [*c]u8) void;
pub extern fn setvbuf([*c]FILE, [*c]u8, c_int, usize) c_int;
pub extern fn sprintf([*c]u8, [*c]const u8, ...) c_int;
pub extern fn sscanf(noalias [*c]const u8, noalias [*c]const u8, ...) c_int;
pub extern fn tmpfile() [*c]FILE;
pub extern fn tmpnam([*c]u8) [*c]u8;
pub extern fn ungetc(c_int, [*c]FILE) c_int;
pub extern fn vfprintf([*c]FILE, [*c]const u8, [*c]struct___va_list_tag) c_int;
pub extern fn vprintf([*c]const u8, [*c]struct___va_list_tag) c_int;
pub extern fn vsprintf([*c]u8, [*c]const u8, [*c]struct___va_list_tag) c_int;
pub extern fn vdprintf(c_int, noalias [*c]const u8, [*c]struct___va_list_tag) c_int;
pub extern fn snprintf([*c]u8, c_ulong, [*c]const u8, ...) c_int;
pub extern fn vsnprintf([*c]u8, c_ulong, [*c]const u8, [*c]struct___va_list_tag) c_int;
pub extern fn vfscanf(noalias [*c]FILE, noalias [*c]const u8, [*c]struct___va_list_tag) c_int;
pub extern fn vscanf(noalias [*c]const u8, [*c]struct___va_list_tag) c_int;
pub extern fn vsscanf(noalias [*c]const u8, noalias [*c]const u8, [*c]struct___va_list_tag) c_int;
pub extern fn ctermid([*c]u8) [*c]u8;
pub extern fn fdopen(c_int, [*c]const u8) [*c]FILE;
pub extern fn fileno([*c]FILE) c_int;
pub extern fn pclose([*c]FILE) c_int;
pub extern fn popen([*c]const u8, [*c]const u8) [*c]FILE;
pub extern fn flockfile([*c]FILE) void;
pub extern fn ftrylockfile([*c]FILE) c_int;
pub extern fn funlockfile([*c]FILE) void;
pub extern fn getc_unlocked([*c]FILE) c_int;
pub extern fn getchar_unlocked() c_int;
pub extern fn putc_unlocked(c_int, [*c]FILE) c_int;
pub extern fn putchar_unlocked(c_int) c_int;
pub extern fn fmemopen(?*anyopaque, usize, [*c]const u8) [*c]FILE;
pub extern fn open_memstream([*c][*c]u8, [*c]usize) [*c]FILE;
pub extern fn tempnam([*c]const u8, [*c]const u8) [*c]u8;
pub extern fn asprintf([*c][*c]u8, [*c]const u8, ...) c_int;
pub extern fn fgetln([*c]FILE, [*c]usize) [*c]u8;
pub extern fn fpurge([*c]FILE) c_int;
pub extern fn getw([*c]FILE) c_int;
pub extern fn putw(c_int, [*c]FILE) c_int;
pub extern fn setbuffer([*c]FILE, [*c]u8, c_int) void;
pub extern fn setlinebuf([*c]FILE) c_int;
pub extern fn vasprintf([*c][*c]u8, [*c]const u8, [*c]struct___va_list_tag) c_int;
pub extern fn funopen(?*const anyopaque, ?*const fn (?*anyopaque, [*c]u8, c_int) callconv(.C) c_int, ?*const fn (?*anyopaque, [*c]const u8, c_int) callconv(.C) c_int, ?*const fn (?*anyopaque, off_t, c_int) callconv(.C) off_t, ?*const fn (?*anyopaque) callconv(.C) c_int) [*c]FILE;
pub extern fn __srget([*c]FILE) c_int;
pub extern fn __swbuf(c_int, [*c]FILE) c_int;
pub fn __sputc(arg__c: c_int, arg__p: [*c]FILE) callconv(.C) c_int {
    var _c = arg__c;
    var _p = arg__p;
    if (((blk: {
        const ref = &_p.*._w;
        ref.* -= 1;
        break :blk ref.*;
    }) >= @as(c_int, 0)) or ((_p.*._w >= _p.*._lbfsize) and (@as(c_int, @bitCast(@as(c_uint, @as(u8, @bitCast(@as(i8, @truncate(_c))))))) != @as(c_int, '\n')))) return @as(c_int, @bitCast(@as(c_uint, blk: {
        const tmp = @as(u8, @bitCast(@as(i8, @truncate(_c))));
        (blk_1: {
            const ref = &_p.*._p;
            const tmp_2 = ref.*;
            ref.* += 1;
            break :blk_1 tmp_2;
        }).* = tmp;
        break :blk tmp;
    }))) else return __swbuf(_c, _p);
    return 0;
}
pub extern var __isthreaded: c_int;
pub const int_least8_t = __int_least8_t;
pub const uint_least8_t = __uint_least8_t;
pub const int_least16_t = __int_least16_t;
pub const uint_least16_t = __uint_least16_t;
pub const int_least32_t = __int_least32_t;
pub const uint_least32_t = __uint_least32_t;
pub const int_least64_t = __int_least64_t;
pub const uint_least64_t = __uint_least64_t;
pub const int_fast8_t = __int_fast8_t;
pub const uint_fast8_t = __uint_fast8_t;
pub const int_fast16_t = __int_fast16_t;
pub const uint_fast16_t = __uint_fast16_t;
pub const int_fast32_t = __int_fast32_t;
pub const uint_fast32_t = __uint_fast32_t;
pub const int_fast64_t = __int_fast64_t;
pub const uint_fast64_t = __uint_fast64_t;
pub const intmax_t = __intmax_t;
pub const uintmax_t = __uintmax_t;
pub const struct_timeval = extern struct {
    tv_sec: time_t,
    tv_usec: suseconds_t,
};
pub const struct_timespec = extern struct {
    tv_sec: time_t,
    tv_nsec: c_long,
};
pub const __fd_mask = u32;
pub const struct_fd_set = extern struct {
    fds_bits: [32]__fd_mask,
};
pub const fd_set = struct_fd_set;
pub fn __fd_set(arg_fd: c_int, arg_p: [*c]fd_set) callconv(.C) void {
    var fd = arg_fd;
    var p = arg_p;
    p.*.fds_bits[@as(c_uint, @bitCast(fd)) / @as(c_uint, @bitCast(@as(c_uint, @truncate(@sizeOf(__fd_mask) *% @as(c_ulong, @bitCast(@as(c_long, @as(c_int, 8))))))))] |= @as(c_uint, 1) << @intCast(@as(c_uint, @bitCast(fd)) % @as(c_uint, @bitCast(@as(c_uint, @truncate(@sizeOf(__fd_mask) *% @as(c_ulong, @bitCast(@as(c_long, @as(c_int, 8)))))))));
}
pub fn __fd_clr(arg_fd: c_int, arg_p: [*c]fd_set) callconv(.C) void {
    var fd = arg_fd;
    var p = arg_p;
    p.*.fds_bits[@as(c_uint, @bitCast(fd)) / @as(c_uint, @bitCast(@as(c_uint, @truncate(@sizeOf(__fd_mask) *% @as(c_ulong, @bitCast(@as(c_long, @as(c_int, 8))))))))] &= ~(@as(c_uint, 1) << @intCast(@as(c_uint, @bitCast(fd)) % @as(c_uint, @bitCast(@as(c_uint, @truncate(@sizeOf(__fd_mask) *% @as(c_ulong, @bitCast(@as(c_long, @as(c_int, 8))))))))));
}
pub fn __fd_isset(arg_fd: c_int, arg_p: [*c]const fd_set) callconv(.C) c_int {
    var fd = arg_fd;
    var p = arg_p;
    return @as(c_int, @bitCast(p.*.fds_bits[@as(c_uint, @bitCast(fd)) / @as(c_uint, @bitCast(@as(c_uint, @truncate(@sizeOf(__fd_mask) *% @as(c_ulong, @bitCast(@as(c_long, @as(c_int, 8))))))))] & (@as(c_uint, 1) << @intCast(@as(c_uint, @bitCast(fd)) % @as(c_uint, @bitCast(@as(c_uint, @truncate(@sizeOf(__fd_mask) *% @as(c_ulong, @bitCast(@as(c_long, @as(c_int, 8))))))))))));
}
pub const sigset_t = c_uint;
pub extern fn select(c_int, noalias [*c]fd_set, noalias [*c]fd_set, noalias [*c]fd_set, noalias [*c]struct_timeval) c_int;
pub extern fn pselect(c_int, noalias [*c]fd_set, noalias [*c]fd_set, noalias [*c]fd_set, noalias [*c]const struct_timespec, noalias [*c]const sigset_t) c_int;
pub const struct_timezone = extern struct {
    tz_minuteswest: c_int,
    tz_dsttime: c_int,
};
pub const struct_itimerval = extern struct {
    it_interval: struct_timeval,
    it_value: struct_timeval,
};
pub const struct_clockinfo = extern struct {
    hz: c_int,
    tick: c_int,
    stathz: c_int,
    profhz: c_int,
};
pub const struct_itimerspec = extern struct {
    it_interval: struct_timespec,
    it_value: struct_timespec,
};
pub const locale_t = ?*anyopaque;
pub const struct_tm = extern struct {
    tm_sec: c_int,
    tm_min: c_int,
    tm_hour: c_int,
    tm_mday: c_int,
    tm_mon: c_int,
    tm_year: c_int,
    tm_wday: c_int,
    tm_yday: c_int,
    tm_isdst: c_int,
    tm_gmtoff: c_long,
    tm_zone: [*c]u8,
};
pub extern fn asctime([*c]const struct_tm) [*c]u8;
pub extern fn clock() clock_t;
pub extern fn ctime([*c]const time_t) [*c]u8;
pub extern fn difftime(time_t, time_t) f64;
pub extern fn gmtime([*c]const time_t) [*c]struct_tm;
pub extern fn localtime([*c]const time_t) [*c]struct_tm;
pub extern fn mktime([*c]struct_tm) time_t;
pub extern fn strftime(noalias [*c]u8, usize, noalias [*c]const u8, noalias [*c]const struct_tm) usize;
pub extern fn time([*c]time_t) time_t;
pub extern var daylight: c_int;
pub extern var timezone: c_long;
pub extern fn strptime(noalias [*c]const u8, noalias [*c]const u8, noalias [*c]struct_tm) [*c]u8;
pub extern fn asctime_r(noalias [*c]const struct_tm, noalias [*c]u8) [*c]u8;
pub extern fn ctime_r([*c]const time_t, [*c]u8) [*c]u8;
pub extern fn gmtime_r(noalias [*c]const time_t, noalias [*c]struct_tm) [*c]struct_tm;
pub extern fn localtime_r(noalias [*c]const time_t, noalias [*c]struct_tm) [*c]struct_tm;
pub extern var tzname: [2][*c]u8;
pub extern fn tzset() void;
pub extern fn clock_getres(clockid_t, [*c]struct_timespec) c_int;
pub extern fn clock_gettime(clockid_t, [*c]struct_timespec) c_int;
pub extern fn clock_settime(clockid_t, [*c]const struct_timespec) c_int;
pub extern fn nanosleep([*c]const struct_timespec, [*c]struct_timespec) c_int;
pub extern fn clock_getcpuclockid(pid_t, [*c]clockid_t) c_int;
pub extern fn strftime_l(noalias [*c]u8, usize, noalias [*c]const u8, noalias [*c]const struct_tm, locale_t) usize;
pub extern fn timespec_get(_ts: [*c]struct_timespec, _base: c_int) c_int;
pub extern fn tzsetwall() void;
pub extern fn timelocal([*c]struct_tm) time_t;
pub extern fn timegm([*c]struct_tm) time_t;
pub extern fn timeoff([*c]struct_tm, c_long) time_t;
pub extern fn adjtime([*c]const struct_timeval, [*c]struct_timeval) c_int;
pub extern fn adjfreq([*c]const i64, [*c]i64) c_int;
pub extern fn futimes(c_int, [*c]const struct_timeval) c_int;
pub extern fn getitimer(c_int, [*c]struct_itimerval) c_int;
pub extern fn gettimeofday([*c]struct_timeval, [*c]struct_timezone) c_int;
pub extern fn setitimer(c_int, [*c]const struct_itimerval, [*c]struct_itimerval) c_int;
pub extern fn settimeofday([*c]const struct_timeval, [*c]const struct_timezone) c_int;
pub extern fn utimes([*c]const u8, [*c]const struct_timeval) c_int;
pub const struct_stat = extern struct {
    st_mode: mode_t,
    st_dev: dev_t,
    st_ino: ino_t,
    st_nlink: nlink_t,
    st_uid: uid_t,
    st_gid: gid_t,
    st_rdev: dev_t,
    st_atim: struct_timespec,
    st_mtim: struct_timespec,
    st_ctim: struct_timespec,
    st_size: off_t,
    st_blocks: blkcnt_t,
    st_blksize: blksize_t,
    st_flags: u_int32_t,
    st_gen: u_int32_t,
    __st_birthtim: struct_timespec,
};
pub extern fn chmod([*c]const u8, mode_t) c_int;
pub extern fn fstat(c_int, [*c]struct_stat) c_int;
pub extern fn mknod([*c]const u8, mode_t, dev_t) c_int;
pub extern fn mkdir([*c]const u8, mode_t) c_int;
pub extern fn mkfifo([*c]const u8, mode_t) c_int;
pub extern fn stat([*c]const u8, [*c]struct_stat) c_int;
pub extern fn umask(mode_t) mode_t;
pub extern fn fchmod(c_int, mode_t) c_int;
pub extern fn lstat([*c]const u8, [*c]struct_stat) c_int;
pub extern fn fchmodat(c_int, [*c]const u8, mode_t, c_int) c_int;
pub extern fn fstatat(c_int, [*c]const u8, [*c]struct_stat, c_int) c_int;
pub extern fn mkdirat(c_int, [*c]const u8, mode_t) c_int;
pub extern fn mkfifoat(c_int, [*c]const u8, mode_t) c_int;
pub extern fn mknodat(c_int, [*c]const u8, mode_t, dev_t) c_int;
pub extern fn utimensat(c_int, [*c]const u8, [*c]const struct_timespec, c_int) c_int;
pub extern fn futimens(c_int, [*c]const struct_timespec) c_int;
pub extern fn chflags([*c]const u8, c_uint) c_int;
pub extern fn chflagsat(c_int, [*c]const u8, c_uint, c_int) c_int;
pub extern fn fchflags(c_int, c_uint) c_int;
pub extern fn isfdtype(c_int, c_int) c_int;
pub const struct_flock = extern struct {
    l_start: off_t,
    l_len: off_t,
    l_pid: pid_t,
    l_type: c_short,
    l_whence: c_short,
};
pub extern fn open([*c]const u8, c_int, ...) c_int;
pub extern fn creat([*c]const u8, mode_t) c_int;
pub extern fn fcntl(c_int, c_int, ...) c_int;
pub extern fn flock(c_int, c_int) c_int;
pub extern fn openat(c_int, [*c]const u8, c_int, ...) c_int;
pub const struct_dirent = extern struct {
    d_fileno: __ino_t,
    d_off: __off_t,
    d_reclen: __uint16_t,
    d_type: __uint8_t,
    d_namlen: __uint8_t,
    __d_padding: [4]__uint8_t,
    d_name: [256]u8,
};
pub const struct__dirdesc = opaque {};
pub const DIR = struct__dirdesc;
pub extern fn opendir([*c]const u8) ?*DIR;
pub extern fn fdopendir(c_int) ?*DIR;
pub extern fn readdir(?*DIR) [*c]struct_dirent;
pub extern fn rewinddir(?*DIR) void;
pub extern fn closedir(?*DIR) c_int;
pub extern fn getdents(c_int, ?*anyopaque, usize) c_int;
pub extern fn telldir(?*DIR) c_long;
pub extern fn seekdir(?*DIR, c_long) void;
pub extern fn readdir_r(noalias ?*DIR, noalias [*c]struct_dirent, noalias [*c][*c]struct_dirent) c_int;
pub extern fn scandir([*c]const u8, [*c][*c][*c]struct_dirent, ?*const fn ([*c]const struct_dirent) callconv(.C) c_int, ?*const fn ([*c][*c]const struct_dirent, [*c][*c]const struct_dirent) callconv(.C) c_int) c_int;
pub extern fn alphasort([*c][*c]const struct_dirent, [*c][*c]const struct_dirent) c_int;
pub extern fn dirfd(?*DIR) c_int;
pub const struct_iovec = extern struct {
    iov_base: ?*anyopaque,
    iov_len: usize,
};
pub const UIO_READ: c_int = 0;
pub const UIO_WRITE: c_int = 1;
pub const enum_uio_rw = c_uint;
pub const UIO_USERSPACE: c_int = 0;
pub const UIO_SYSSPACE: c_int = 1;
pub const enum_uio_seg = c_uint;
pub extern fn preadv(c_int, [*c]const struct_iovec, c_int, __off_t) isize;
pub extern fn pwritev(c_int, [*c]const struct_iovec, c_int, __off_t) isize;
pub extern fn readv(c_int, [*c]const struct_iovec, c_int) isize;
pub extern fn writev(c_int, [*c]const struct_iovec, c_int) isize;
pub const socklen_t = __socklen_t;
pub const sa_family_t = __sa_family_t;
pub const struct_linger = extern struct {
    l_onoff: c_int,
    l_linger: c_int,
};
pub const struct_splice = extern struct {
    sp_fd: c_int,
    sp_max: off_t,
    sp_idle: struct_timeval,
};
pub const struct_sockaddr = extern struct {
    sa_len: __uint8_t,
    sa_family: sa_family_t,
    sa_data: [14]u8,
};
pub const struct_sockaddr_storage = extern struct {
    ss_len: __uint8_t,
    ss_family: sa_family_t,
    __ss_pad1: [6]u8,
    __ss_pad2: __uint64_t,
    __ss_pad3: [240]u8,
};
pub const struct_sockpeercred = extern struct {
    uid: uid_t,
    gid: gid_t,
    pid: pid_t,
};
pub const struct_msghdr = extern struct {
    msg_name: ?*anyopaque,
    msg_namelen: socklen_t,
    msg_iov: [*c]struct_iovec,
    msg_iovlen: c_uint,
    msg_control: ?*anyopaque,
    msg_controllen: socklen_t,
    msg_flags: c_int,
};
pub const struct_mmsghdr = extern struct {
    msg_hdr: struct_msghdr,
    msg_len: c_uint,
};
pub const struct_cmsghdr = extern struct {
    cmsg_len: socklen_t,
    cmsg_level: c_int,
    cmsg_type: c_int,
};
pub extern fn accept(c_int, [*c]struct_sockaddr, [*c]socklen_t) c_int;
pub extern fn bind(c_int, [*c]const struct_sockaddr, socklen_t) c_int;
pub extern fn connect(c_int, [*c]const struct_sockaddr, socklen_t) c_int;
pub extern fn getpeername(c_int, [*c]struct_sockaddr, [*c]socklen_t) c_int;
pub extern fn getsockname(c_int, [*c]struct_sockaddr, [*c]socklen_t) c_int;
pub extern fn getsockopt(c_int, c_int, c_int, ?*anyopaque, [*c]socklen_t) c_int;
pub extern fn listen(c_int, c_int) c_int;
pub extern fn recv(c_int, ?*anyopaque, usize, c_int) isize;
pub extern fn recvfrom(c_int, ?*anyopaque, usize, c_int, [*c]struct_sockaddr, [*c]socklen_t) isize;
pub extern fn recvmsg(c_int, [*c]struct_msghdr, c_int) isize;
pub extern fn recvmmsg(c_int, [*c]struct_mmsghdr, c_uint, c_int, [*c]struct_timespec) c_int;
pub extern fn send(c_int, ?*const anyopaque, usize, c_int) isize;
pub extern fn sendto(c_int, ?*const anyopaque, usize, c_int, [*c]const struct_sockaddr, socklen_t) isize;
pub extern fn sendmsg(c_int, [*c]const struct_msghdr, c_int) isize;
pub extern fn sendmmsg(c_int, [*c]struct_mmsghdr, c_uint, c_int) c_int;
pub extern fn setsockopt(c_int, c_int, c_int, ?*const anyopaque, socklen_t) c_int;
pub extern fn shutdown(c_int, c_int) c_int;
pub extern fn sockatmark(c_int) c_int;
pub extern fn socket(c_int, c_int, c_int) c_int;
pub extern fn socketpair(c_int, c_int, c_int, [*c]c_int) c_int;
pub extern fn accept4(c_int, noalias [*c]struct_sockaddr, noalias [*c]socklen_t, c_int) c_int;
pub extern fn getpeereid(c_int, [*c]uid_t, [*c]gid_t) c_int;
pub extern fn getrtable() c_int;
pub extern fn setrtable(c_int) c_int;
pub const in_addr_t = __in_addr_t;
pub const in_port_t = __in_port_t;
pub const struct_in_addr = extern struct {
    s_addr: in_addr_t,
};
pub const struct_sockaddr_in = extern struct {
    sin_len: u_int8_t,
    sin_family: sa_family_t,
    sin_port: in_port_t,
    sin_addr: struct_in_addr,
    sin_zero: [8]i8,
};
pub const struct_ip_opts = extern struct {
    ip_dst: struct_in_addr,
    ip_opts: [40]i8,
};
pub const struct_ip_mreq = extern struct {
    imr_multiaddr: struct_in_addr,
    imr_interface: struct_in_addr,
};
pub const struct_ip_mreqn = extern struct {
    imr_multiaddr: struct_in_addr,
    imr_address: struct_in_addr,
    imr_ifindex: c_int,
};
const union_unnamed_1 = extern union {
    __u6_addr8: [16]u_int8_t,
    __u6_addr16: [8]u_int16_t,
    __u6_addr32: [4]u_int32_t,
};
pub const struct_in6_addr = extern struct {
    __u6_addr: union_unnamed_1,
};
pub const struct_sockaddr_in6 = extern struct {
    sin6_len: u_int8_t,
    sin6_family: sa_family_t,
    sin6_port: in_port_t,
    sin6_flowinfo: u_int32_t,
    sin6_addr: struct_in6_addr,
    sin6_scope_id: u_int32_t,
};
pub extern const in6addr_any: struct_in6_addr;
pub extern const in6addr_loopback: struct_in6_addr;
pub extern const in6addr_intfacelocal_allnodes: struct_in6_addr;
pub extern const in6addr_linklocal_allnodes: struct_in6_addr;
pub extern const in6addr_linklocal_allrouters: struct_in6_addr;
pub const struct_rtentry = opaque {};
pub const struct_route_in6 = extern struct {
    ro_rt: ?*struct_rtentry,
    ro_tableid: u_long,
    ro_dst: struct_sockaddr_in6,
};
pub const struct_ipv6_mreq = extern struct {
    ipv6mr_multiaddr: struct_in6_addr,
    ipv6mr_interface: c_uint,
};
pub const struct_in6_pktinfo = extern struct {
    ipi6_addr: struct_in6_addr,
    ipi6_ifindex: c_uint,
};
pub const struct_ip6_mtuinfo = extern struct {
    ip6m_addr: struct_sockaddr_in6,
    ip6m_mtu: u_int32_t,
};
pub extern fn inet6_opt_init(?*anyopaque, socklen_t) c_int;
pub extern fn inet6_opt_append(?*anyopaque, socklen_t, c_int, u_int8_t, socklen_t, u_int8_t, [*c]?*anyopaque) c_int;
pub extern fn inet6_opt_finish(?*anyopaque, socklen_t, c_int) c_int;
pub extern fn inet6_opt_set_val(?*anyopaque, c_int, ?*anyopaque, socklen_t) c_int;
pub extern fn inet6_opt_next(?*anyopaque, socklen_t, c_int, [*c]u_int8_t, [*c]socklen_t, [*c]?*anyopaque) c_int;
pub extern fn inet6_opt_find(?*anyopaque, socklen_t, c_int, u_int8_t, [*c]socklen_t, [*c]?*anyopaque) c_int;
pub extern fn inet6_opt_get_val(?*anyopaque, c_int, ?*anyopaque, socklen_t) c_int;
pub extern fn inet6_rth_space(c_int, c_int) socklen_t;
pub extern fn inet6_rth_init(?*anyopaque, socklen_t, c_int, c_int) ?*anyopaque;
pub extern fn inet6_rth_add(?*anyopaque, [*c]const struct_in6_addr) c_int;
pub extern fn inet6_rth_reverse(?*const anyopaque, ?*anyopaque) c_int;
pub extern fn inet6_rth_segments(?*const anyopaque) c_int;
pub extern fn inet6_rth_getaddr(?*const anyopaque, c_int) [*c]struct_in6_addr;
pub extern fn bindresvport(c_int, [*c]struct_sockaddr_in) c_int;
pub extern fn bindresvport_sa(c_int, [*c]struct_sockaddr) c_int;
pub const tcp_seq = u_int32_t; // /usr/include/netinet/tcp.h:54:12: warning: struct demoted to opaque type - has bitfield
pub const struct_tcphdr = opaque {};
pub const struct_tcp_info = extern struct {
    tcpi_state: u8,
    __tcpi_ca_state: u8,
    __tcpi_retransmits: u8,
    __tcpi_probes: u8,
    __tcpi_backoff: u8,
    tcpi_options: u8,
    tcpi_snd_wscale: u8,
    tcpi_rcv_wscale: u8,
    tcpi_rto: u32,
    __tcpi_ato: u32,
    tcpi_snd_mss: u32,
    tcpi_rcv_mss: u32,
    __tcpi_unacked: u32,
    __tcpi_sacked: u32,
    __tcpi_lost: u32,
    __tcpi_retrans: u32,
    __tcpi_fackets: u32,
    tcpi_last_data_sent: u32,
    tcpi_last_ack_sent: u32,
    tcpi_last_data_recv: u32,
    tcpi_last_ack_recv: u32,
    __tcpi_pmtu: u32,
    __tcpi_rcv_ssthresh: u32,
    tcpi_rtt: u32,
    tcpi_rttvar: u32,
    tcpi_snd_ssthresh: u32,
    tcpi_snd_cwnd: u32,
    __tcpi_advmss: u32,
    __tcpi_reordering: u32,
    __tcpi_rcv_rtt: u32,
    tcpi_rcv_space: u32,
    tcpi_snd_wnd: u32,
    tcpi_snd_nxt: u32,
    tcpi_rcv_nxt: u32,
    tcpi_toe_tid: u32,
    tcpi_snd_rexmitpack: u32,
    tcpi_rcv_ooopack: u32,
    tcpi_snd_zerowin: u32,
    tcpi_rttmin: u32,
    tcpi_max_sndwnd: u32,
    tcpi_rcv_adv: u32,
    tcpi_rcv_up: u32,
    tcpi_snd_una: u32,
    tcpi_snd_up: u32,
    tcpi_snd_wl1: u32,
    tcpi_snd_wl2: u32,
    tcpi_snd_max: u32,
    tcpi_ts_recent: u32,
    tcpi_ts_recent_age: u32,
    tcpi_rfbuf_cnt: u32,
    tcpi_rfbuf_ts: u32,
    tcpi_so_rcv_sb_cc: u32,
    tcpi_so_rcv_sb_hiwat: u32,
    tcpi_so_rcv_sb_lowat: u32,
    tcpi_so_rcv_sb_wat: u32,
    tcpi_so_snd_sb_cc: u32,
    tcpi_so_snd_sb_hiwat: u32,
    tcpi_so_snd_sb_lowat: u32,
    tcpi_so_snd_sb_wat: u32,
};
pub extern fn inet_addr([*c]const u8) in_addr_t;
pub extern fn inet_ntoa(struct_in_addr) [*c]u8;
pub extern fn inet_ntop(c_int, noalias ?*const anyopaque, noalias [*c]u8, socklen_t) [*c]const u8;
pub extern fn inet_pton(c_int, noalias [*c]const u8, noalias ?*anyopaque) c_int;
pub extern fn inet_aton([*c]const u8, [*c]struct_in_addr) c_int;
pub extern fn inet_lnaof(struct_in_addr) in_addr_t;
pub extern fn inet_makeaddr(in_addr_t, in_addr_t) struct_in_addr;
pub extern fn inet_neta(in_addr_t, [*c]u8, usize) [*c]u8;
pub extern fn inet_netof(struct_in_addr) in_addr_t;
pub extern fn inet_network([*c]const u8) in_addr_t;
pub extern fn inet_net_ntop(c_int, ?*const anyopaque, c_int, [*c]u8, usize) [*c]u8;
pub extern fn inet_net_pton(c_int, [*c]const u8, ?*anyopaque, usize) c_int;
pub const struct_hostent = extern struct {
    h_name: [*c]u8,
    h_aliases: [*c][*c]u8,
    h_addrtype: c_int,
    h_length: c_int,
    h_addr_list: [*c][*c]u8,
};
pub const struct_netent = extern struct {
    n_name: [*c]u8,
    n_aliases: [*c][*c]u8,
    n_addrtype: c_int,
    n_net: in_addr_t,
};
pub const struct_servent = extern struct {
    s_name: [*c]u8,
    s_aliases: [*c][*c]u8,
    s_port: c_int,
    s_proto: [*c]u8,
};
pub const struct_protoent = extern struct {
    p_name: [*c]u8,
    p_aliases: [*c][*c]u8,
    p_proto: c_int,
};
pub extern var h_errno: c_int;
pub const struct_addrinfo = extern struct {
    ai_flags: c_int,
    ai_family: c_int,
    ai_socktype: c_int,
    ai_protocol: c_int,
    ai_addrlen: socklen_t,
    ai_addr: [*c]struct_sockaddr,
    ai_canonname: [*c]u8,
    ai_next: [*c]struct_addrinfo,
};
pub const struct_rdatainfo = extern struct {
    rdi_length: c_uint,
    rdi_data: [*c]u8,
};
pub const struct_rrsetinfo = extern struct {
    rri_flags: c_uint,
    rri_rdclass: c_uint,
    rri_rdtype: c_uint,
    rri_ttl: c_uint,
    rri_nrdatas: c_uint,
    rri_nsigs: c_uint,
    rri_name: [*c]u8,
    rri_rdatas: [*c]struct_rdatainfo,
    rri_sigs: [*c]struct_rdatainfo,
};
pub const struct_servent_data = extern struct {
    fp: ?*anyopaque,
    aliases: [*c][*c]u8,
    maxaliases: c_int,
    stayopen: c_int,
    line: [*c]u8,
};
pub const struct_protoent_data = extern struct {
    fp: ?*anyopaque,
    aliases: [*c][*c]u8,
    maxaliases: c_int,
    stayopen: c_int,
    line: [*c]u8,
};
pub extern fn endhostent() void;
pub extern fn endnetent() void;
pub extern fn endprotoent() void;
pub extern fn endservent() void;
pub extern fn gethostbyaddr(?*const anyopaque, socklen_t, c_int) [*c]struct_hostent;
pub extern fn gethostbyname([*c]const u8) [*c]struct_hostent;
pub extern fn gethostbyname2([*c]const u8, c_int) [*c]struct_hostent;
pub extern fn gethostent() [*c]struct_hostent;
pub extern fn getnetbyaddr(in_addr_t, c_int) [*c]struct_netent;
pub extern fn getnetbyname([*c]const u8) [*c]struct_netent;
pub extern fn getnetent() [*c]struct_netent;
pub extern fn getprotobyname([*c]const u8) [*c]struct_protoent;
pub extern fn getprotobynumber(c_int) [*c]struct_protoent;
pub extern fn getprotoent() [*c]struct_protoent;
pub extern fn getservbyname([*c]const u8, [*c]const u8) [*c]struct_servent;
pub extern fn getservbyport(c_int, [*c]const u8) [*c]struct_servent;
pub extern fn getservent() [*c]struct_servent;
pub extern fn herror([*c]const u8) void;
pub extern fn hstrerror(c_int) [*c]const u8;
pub extern fn sethostent(c_int) void;
pub extern fn setnetent(c_int) void;
pub extern fn setprotoent(c_int) void;
pub extern fn setservent(c_int) void;
pub extern fn endprotoent_r([*c]struct_protoent_data) void;
pub extern fn endservent_r([*c]struct_servent_data) void;
pub extern fn getprotobyname_r([*c]const u8, [*c]struct_protoent, [*c]struct_protoent_data) c_int;
pub extern fn getprotobynumber_r(c_int, [*c]struct_protoent, [*c]struct_protoent_data) c_int;
pub extern fn getservbyname_r([*c]const u8, [*c]const u8, [*c]struct_servent, [*c]struct_servent_data) c_int;
pub extern fn getservbyport_r(c_int, [*c]const u8, [*c]struct_servent, [*c]struct_servent_data) c_int;
pub extern fn getservent_r([*c]struct_servent, [*c]struct_servent_data) c_int;
pub extern fn getprotoent_r([*c]struct_protoent, [*c]struct_protoent_data) c_int;
pub extern fn setprotoent_r(c_int, [*c]struct_protoent_data) void;
pub extern fn setservent_r(c_int, [*c]struct_servent_data) void;
pub extern fn getaddrinfo([*c]const u8, [*c]const u8, [*c]const struct_addrinfo, [*c][*c]struct_addrinfo) c_int;
pub extern fn freeaddrinfo([*c]struct_addrinfo) void;
pub extern fn getnameinfo([*c]const struct_sockaddr, socklen_t, [*c]u8, usize, [*c]u8, usize, c_int) c_int;
pub extern fn gai_strerror(c_int) [*c]const u8;
pub extern fn getrrsetbyname([*c]const u8, c_uint, c_uint, c_uint, [*c][*c]struct_rrsetinfo) c_int;
pub extern fn freerrset([*c]struct_rrsetinfo) void;
pub const tcflag_t = c_uint;
pub const cc_t = u8;
pub const speed_t = c_uint;
pub const struct_termios = extern struct {
    c_iflag: tcflag_t,
    c_oflag: tcflag_t,
    c_cflag: tcflag_t,
    c_lflag: tcflag_t,
    c_cc: [20]cc_t,
    c_ispeed: c_int,
    c_ospeed: c_int,
};
pub extern fn cfgetispeed([*c]const struct_termios) speed_t;
pub extern fn cfgetospeed([*c]const struct_termios) speed_t;
pub extern fn cfsetispeed([*c]struct_termios, speed_t) c_int;
pub extern fn cfsetospeed([*c]struct_termios, speed_t) c_int;
pub extern fn tcgetattr(c_int, [*c]struct_termios) c_int;
pub extern fn tcsetattr(c_int, c_int, [*c]const struct_termios) c_int;
pub extern fn tcdrain(c_int) c_int;
pub extern fn tcflow(c_int, c_int) c_int;
pub extern fn tcflush(c_int, c_int) c_int;
pub extern fn tcsendbreak(c_int, c_int) c_int;
pub extern fn tcgetsid(c_int) pid_t;
pub extern fn cfmakeraw([*c]struct_termios) void;
pub extern fn cfsetspeed([*c]struct_termios, speed_t) c_int;
pub const struct_winsize = extern struct {
    ws_row: c_ushort,
    ws_col: c_ushort,
    ws_xpixel: c_ushort,
    ws_ypixel: c_ushort,
};
pub const struct_tstamps = extern struct {
    ts_set: c_int,
    ts_clr: c_int,
};
pub const struct_passwd = extern struct {
    pw_name: [*c]u8,
    pw_passwd: [*c]u8,
    pw_uid: uid_t,
    pw_gid: gid_t,
    pw_change: time_t,
    pw_class: [*c]u8,
    pw_gecos: [*c]u8,
    pw_dir: [*c]u8,
    pw_shell: [*c]u8,
    pw_expire: time_t,
};
pub extern fn getpwuid(uid_t) [*c]struct_passwd;
pub extern fn getpwnam([*c]const u8) [*c]struct_passwd;
pub extern fn getpwuid_shadow(uid_t) [*c]struct_passwd;
pub extern fn getpwnam_shadow([*c]const u8) [*c]struct_passwd;
pub extern fn getpwnam_r([*c]const u8, [*c]struct_passwd, [*c]u8, usize, [*c][*c]struct_passwd) c_int;
pub extern fn getpwuid_r(uid_t, [*c]struct_passwd, [*c]u8, usize, [*c][*c]struct_passwd) c_int;
pub extern fn getpwent() [*c]struct_passwd;
pub extern fn setpwent() void;
pub extern fn endpwent() void;
pub extern fn setpassent(c_int) c_int;
pub extern fn uid_from_user([*c]const u8, [*c]uid_t) c_int;
pub extern fn user_from_uid(uid_t, c_int) [*c]const u8;
pub extern fn bcrypt_gensalt(u_int8_t) [*c]u8;
pub extern fn bcrypt([*c]const u8, [*c]const u8) [*c]u8;
pub extern fn bcrypt_newhash([*c]const u8, c_int, [*c]u8, usize) c_int;
pub extern fn bcrypt_checkpass([*c]const u8, [*c]const u8) c_int;
pub extern fn pw_dup([*c]const struct_passwd) [*c]struct_passwd;
pub const struct___sem = opaque {};
pub const sem_t = ?*struct___sem;
pub extern fn sem_init([*c]sem_t, c_int, c_uint) c_int;
pub extern fn sem_destroy([*c]sem_t) c_int;
pub extern fn sem_open([*c]const u8, c_int, ...) [*c]sem_t;
pub extern fn sem_close([*c]sem_t) c_int;
pub extern fn sem_unlink([*c]const u8) c_int;
pub extern fn sem_wait([*c]sem_t) c_int;
pub extern fn sem_timedwait(noalias [*c]sem_t, noalias [*c]const struct_timespec) c_int;
pub extern fn sem_trywait([*c]sem_t) c_int;
pub extern fn sem_post([*c]sem_t) c_int;
pub extern fn sem_getvalue(noalias [*c]sem_t, noalias [*c]c_int) c_int;
pub const sig_atomic_t = c_int;
pub const struct_fxsave64 = opaque {};
pub const struct_sigcontext = extern struct {
    sc_rdi: c_long,
    sc_rsi: c_long,
    sc_rdx: c_long,
    sc_rcx: c_long,
    sc_r8: c_long,
    sc_r9: c_long,
    sc_r10: c_long,
    sc_r11: c_long,
    sc_r12: c_long,
    sc_r13: c_long,
    sc_r14: c_long,
    sc_r15: c_long,
    sc_rbp: c_long,
    sc_rbx: c_long,
    sc_rax: c_long,
    sc_gs: c_long,
    sc_fs: c_long,
    sc_es: c_long,
    sc_ds: c_long,
    sc_trapno: c_long,
    sc_err: c_long,
    sc_rip: c_long,
    sc_cs: c_long,
    sc_rflags: c_long,
    sc_rsp: c_long,
    sc_ss: c_long,
    sc_fpstate: ?*struct_fxsave64,
    __sc_unused: c_int,
    sc_mask: c_int,
    sc_cookie: c_long,
};
pub const union_sigval = extern union {
    sival_int: c_int,
    sival_ptr: ?*anyopaque,
};
const struct_unnamed_5 = extern struct {
    _value: union_sigval,
};
const struct_unnamed_6 = extern struct {
    _utime: clock_t,
    _stime: clock_t,
    _status: c_int,
};
const union_unnamed_4 = extern union {
    _kill: struct_unnamed_5,
    _cld: struct_unnamed_6,
};
const struct_unnamed_3 = extern struct {
    _pid: pid_t,
    _uid: uid_t,
    _pdata: union_unnamed_4,
};
const struct_unnamed_7 = extern struct {
    _addr: ?*anyopaque,
    _trapno: c_int,
};
const union_unnamed_2 = extern union {
    _pad: [29]c_int,
    _proc: struct_unnamed_3,
    _fault: struct_unnamed_7,
};
pub const siginfo_t = extern struct {
    si_signo: c_int,
    si_code: c_int,
    si_errno: c_int,
    _data: union_unnamed_2,
};
const union_unnamed_8 = extern union {
    __sa_handler: ?*const fn (c_int) callconv(.C) void,
    __sa_sigaction: ?*const fn (c_int, [*c]siginfo_t, ?*anyopaque) callconv(.C) void,
};
pub const struct_sigaction = extern struct {
    __sigaction_u: union_unnamed_8,
    sa_mask: sigset_t,
    sa_flags: c_int,
};
pub const sig_t = ?*const fn (c_int) callconv(.C) void;
pub const struct_sigvec = extern struct {
    sv_handler: ?*const fn (c_int) callconv(.C) void,
    sv_mask: c_int,
    sv_flags: c_int,
};
pub const struct_sigaltstack = extern struct {
    ss_sp: ?*anyopaque,
    ss_size: usize,
    ss_flags: c_int,
};
pub const stack_t = struct_sigaltstack;
pub const ucontext_t = struct_sigcontext;
pub extern fn signal(c_int, ?*const fn (c_int) callconv(.C) void) ?*const fn (c_int) callconv(.C) void;
pub const struct_sched_param = extern struct {
    sched_priority: c_int,
};
pub extern fn sched_yield() c_int;
pub extern fn sched_get_priority_max(c_int) c_int;
pub extern fn sched_get_priority_min(c_int) c_int;
pub const struct_pthread = opaque {};
pub const struct_pthread_attr = opaque {};
pub const struct_pthread_cond = opaque {};
pub const struct_pthread_cond_attr = opaque {};
pub const struct_pthread_mutex = opaque {};
pub const struct_pthread_mutex_attr = opaque {};
pub const pthread_mutex_t = ?*volatile struct_pthread_mutex;
pub const struct_pthread_once = extern struct {
    state: c_int,
    mutex: pthread_mutex_t,
};
pub const struct_pthread_rwlock = opaque {};
pub const struct_pthread_rwlockattr = opaque {};
pub const pthread_t = ?*struct_pthread;
pub const pthread_attr_t = ?*struct_pthread_attr;
pub const pthread_mutexattr_t = ?*struct_pthread_mutex_attr;
pub const pthread_cond_t = ?*struct_pthread_cond;
pub const pthread_condattr_t = ?*struct_pthread_cond_attr;
pub const pthread_key_t = c_int;
pub const pthread_once_t = struct_pthread_once;
pub const pthread_rwlock_t = ?*struct_pthread_rwlock;
pub const pthread_rwlockattr_t = ?*struct_pthread_rwlockattr;
pub const struct_pthread_barrier = opaque {};
pub const pthread_barrier_t = ?*struct_pthread_barrier;
pub const struct_pthread_barrierattr = opaque {};
pub const pthread_barrierattr_t = ?*struct_pthread_barrierattr;
pub const struct_pthread_spinlock = opaque {};
pub const pthread_spinlock_t = ?*struct_pthread_spinlock;
pub const pthread_addr_t = ?*anyopaque;
pub const pthread_startroutine_t = ?*const fn (?*anyopaque) callconv(.C) ?*anyopaque;
pub const PTHREAD_MUTEX_ERRORCHECK: c_int = 1;
pub const PTHREAD_MUTEX_RECURSIVE: c_int = 2;
pub const PTHREAD_MUTEX_NORMAL: c_int = 3;
pub const PTHREAD_MUTEX_STRICT_NP: c_int = 4;
pub const PTHREAD_MUTEX_TYPE_MAX: c_int = 5;
pub const enum_pthread_mutextype = c_uint;
pub extern fn pthread_atfork(?*const fn () callconv(.C) void, ?*const fn () callconv(.C) void, ?*const fn () callconv(.C) void) c_int;
pub extern fn pthread_attr_destroy([*c]pthread_attr_t) c_int;
pub extern fn pthread_attr_getstack([*c]const pthread_attr_t, [*c]?*anyopaque, [*c]usize) c_int;
pub extern fn pthread_attr_getstacksize([*c]const pthread_attr_t, [*c]usize) c_int;
pub extern fn pthread_attr_getstackaddr([*c]const pthread_attr_t, [*c]?*anyopaque) c_int;
pub extern fn pthread_attr_getguardsize([*c]const pthread_attr_t, [*c]usize) c_int;
pub extern fn pthread_attr_getdetachstate([*c]const pthread_attr_t, [*c]c_int) c_int;
pub extern fn pthread_attr_init([*c]pthread_attr_t) c_int;
pub extern fn pthread_attr_setstacksize([*c]pthread_attr_t, usize) c_int;
pub extern fn pthread_attr_setstack([*c]pthread_attr_t, ?*anyopaque, usize) c_int;
pub extern fn pthread_attr_setstackaddr([*c]pthread_attr_t, ?*anyopaque) c_int;
pub extern fn pthread_attr_setguardsize([*c]pthread_attr_t, usize) c_int;
pub extern fn pthread_attr_setdetachstate([*c]pthread_attr_t, c_int) c_int;
pub extern fn pthread_cleanup_pop(c_int) void;
pub extern fn pthread_cleanup_push(?*const fn (?*anyopaque) callconv(.C) void, routine_arg: ?*anyopaque) void;
pub extern fn pthread_condattr_destroy([*c]pthread_condattr_t) c_int;
pub extern fn pthread_condattr_init([*c]pthread_condattr_t) c_int;
pub extern fn pthread_cond_broadcast([*c]pthread_cond_t) c_int;
pub extern fn pthread_cond_destroy([*c]pthread_cond_t) c_int;
pub extern fn pthread_cond_init([*c]pthread_cond_t, [*c]const pthread_condattr_t) c_int;
pub extern fn pthread_cond_signal([*c]pthread_cond_t) c_int;
pub extern fn pthread_cond_timedwait([*c]pthread_cond_t, [*c]pthread_mutex_t, [*c]const struct_timespec) c_int;
pub extern fn pthread_cond_wait([*c]pthread_cond_t, [*c]pthread_mutex_t) c_int;
pub extern fn pthread_create([*c]pthread_t, [*c]const pthread_attr_t, ?*const fn (?*anyopaque) callconv(.C) ?*anyopaque, ?*anyopaque) c_int;
pub extern fn pthread_detach(pthread_t) c_int;
pub extern fn pthread_equal(pthread_t, pthread_t) c_int;
pub extern fn pthread_exit(?*anyopaque) noreturn;
pub extern fn pthread_getspecific(pthread_key_t) ?*anyopaque;
pub extern fn pthread_join(pthread_t, [*c]?*anyopaque) c_int;
pub extern fn pthread_key_create([*c]pthread_key_t, ?*const fn (?*anyopaque) callconv(.C) void) c_int;
pub extern fn pthread_key_delete(pthread_key_t) c_int;
pub extern fn pthread_kill(pthread_t, c_int) c_int;
pub extern fn pthread_mutexattr_init([*c]pthread_mutexattr_t) c_int;
pub extern fn pthread_mutexattr_destroy([*c]pthread_mutexattr_t) c_int;
pub extern fn pthread_mutexattr_gettype([*c]pthread_mutexattr_t, [*c]c_int) c_int;
pub extern fn pthread_mutexattr_settype([*c]pthread_mutexattr_t, c_int) c_int;
pub extern fn pthread_mutex_destroy([*c]pthread_mutex_t) c_int;
pub extern fn pthread_mutex_init([*c]pthread_mutex_t, [*c]const pthread_mutexattr_t) c_int;
pub extern fn pthread_mutex_lock([*c]pthread_mutex_t) c_int;
pub extern fn pthread_mutex_timedlock([*c]pthread_mutex_t, [*c]const struct_timespec) c_int;
pub extern fn pthread_mutex_trylock([*c]pthread_mutex_t) c_int;
pub extern fn pthread_mutex_unlock([*c]pthread_mutex_t) c_int;
pub extern fn pthread_once([*c]pthread_once_t, ?*const fn () callconv(.C) void) c_int;
pub extern fn pthread_rwlock_destroy([*c]pthread_rwlock_t) c_int;
pub extern fn pthread_rwlock_init([*c]pthread_rwlock_t, [*c]const pthread_rwlockattr_t) c_int;
pub extern fn pthread_rwlock_rdlock([*c]pthread_rwlock_t) c_int;
pub extern fn pthread_rwlock_timedrdlock([*c]pthread_rwlock_t, [*c]const struct_timespec) c_int;
pub extern fn pthread_rwlock_timedwrlock([*c]pthread_rwlock_t, [*c]const struct_timespec) c_int;
pub extern fn pthread_rwlock_tryrdlock([*c]pthread_rwlock_t) c_int;
pub extern fn pthread_rwlock_trywrlock([*c]pthread_rwlock_t) c_int;
pub extern fn pthread_rwlock_unlock([*c]pthread_rwlock_t) c_int;
pub extern fn pthread_rwlock_wrlock([*c]pthread_rwlock_t) c_int;
pub extern fn pthread_rwlockattr_init([*c]pthread_rwlockattr_t) c_int;
pub extern fn pthread_rwlockattr_getpshared([*c]const pthread_rwlockattr_t, [*c]c_int) c_int;
pub extern fn pthread_rwlockattr_setpshared([*c]pthread_rwlockattr_t, c_int) c_int;
pub extern fn pthread_rwlockattr_destroy([*c]pthread_rwlockattr_t) c_int;
pub extern fn pthread_self() pthread_t;
pub extern fn pthread_setspecific(pthread_key_t, ?*const anyopaque) c_int;
pub extern fn pthread_cancel(pthread_t) c_int;
pub extern fn pthread_setcancelstate(c_int, [*c]c_int) c_int;
pub extern fn pthread_setcanceltype(c_int, [*c]c_int) c_int;
pub extern fn pthread_testcancel() void;
pub extern fn pthread_getprio(pthread_t) c_int;
pub extern fn pthread_setprio(pthread_t, c_int) c_int;
pub extern fn pthread_yield() void;
pub extern fn pthread_mutexattr_getprioceiling([*c]pthread_mutexattr_t, [*c]c_int) c_int;
pub extern fn pthread_mutexattr_setprioceiling([*c]pthread_mutexattr_t, c_int) c_int;
pub extern fn pthread_mutex_getprioceiling([*c]pthread_mutex_t, [*c]c_int) c_int;
pub extern fn pthread_mutex_setprioceiling([*c]pthread_mutex_t, c_int, [*c]c_int) c_int;
pub extern fn pthread_mutexattr_getprotocol([*c]pthread_mutexattr_t, [*c]c_int) c_int;
pub extern fn pthread_mutexattr_setprotocol([*c]pthread_mutexattr_t, c_int) c_int;
pub extern fn pthread_condattr_getclock([*c]const pthread_condattr_t, [*c]clockid_t) c_int;
pub extern fn pthread_condattr_setclock([*c]pthread_condattr_t, clockid_t) c_int;
pub extern fn pthread_attr_getinheritsched([*c]const pthread_attr_t, [*c]c_int) c_int;
pub extern fn pthread_attr_getschedparam([*c]const pthread_attr_t, [*c]struct_sched_param) c_int;
pub extern fn pthread_attr_getschedpolicy([*c]const pthread_attr_t, [*c]c_int) c_int;
pub extern fn pthread_attr_getscope([*c]const pthread_attr_t, [*c]c_int) c_int;
pub extern fn pthread_attr_setinheritsched([*c]pthread_attr_t, c_int) c_int;
pub extern fn pthread_attr_setschedparam([*c]pthread_attr_t, [*c]const struct_sched_param) c_int;
pub extern fn pthread_attr_setschedpolicy([*c]pthread_attr_t, c_int) c_int;
pub extern fn pthread_attr_setscope([*c]pthread_attr_t, c_int) c_int;
pub extern fn pthread_getschedparam(pthread: pthread_t, [*c]c_int, [*c]struct_sched_param) c_int;
pub extern fn pthread_setschedparam(pthread_t, c_int, [*c]const struct_sched_param) c_int;
pub extern fn pthread_getconcurrency() c_int;
pub extern fn pthread_setconcurrency(c_int) c_int;
pub extern fn pthread_barrier_init([*c]pthread_barrier_t, [*c]pthread_barrierattr_t, c_uint) c_int;
pub extern fn pthread_barrier_destroy([*c]pthread_barrier_t) c_int;
pub extern fn pthread_barrier_wait([*c]pthread_barrier_t) c_int;
pub extern fn pthread_barrierattr_init([*c]pthread_barrierattr_t) c_int;
pub extern fn pthread_barrierattr_destroy([*c]pthread_barrierattr_t) c_int;
pub extern fn pthread_barrierattr_getpshared([*c]pthread_barrierattr_t, [*c]c_int) c_int;
pub extern fn pthread_barrierattr_setpshared([*c]pthread_barrierattr_t, c_int) c_int;
pub extern fn pthread_spin_init([*c]pthread_spinlock_t, c_int) c_int;
pub extern fn pthread_spin_destroy([*c]pthread_spinlock_t) c_int;
pub extern fn pthread_spin_trylock([*c]pthread_spinlock_t) c_int;
pub extern fn pthread_spin_lock([*c]pthread_spinlock_t) c_int;
pub extern fn pthread_spin_unlock([*c]pthread_spinlock_t) c_int;
pub extern fn pthread_getcpuclockid(pthread_t, [*c]clockid_t) c_int;
pub extern const sys_signame: [33][*c]const u8;
pub extern const sys_siglist: [33][*c]const u8;
pub extern fn raise(c_int) c_int;
pub extern fn bsd_signal(c_int, ?*const fn (c_int) callconv(.C) void) ?*const fn (c_int) callconv(.C) void;
pub extern fn kill(pid_t, c_int) c_int;
pub extern fn sigaction(c_int, noalias [*c]const struct_sigaction, noalias [*c]struct_sigaction) c_int;
pub fn sigaddset(arg___set: [*c]sigset_t, arg___signo: c_int) callconv(.C) c_int {
    var __set = arg___set;
    var __signo = arg___signo;
    if ((__signo <= @as(c_int, 0)) or (__signo >= @as(c_int, 33))) {
        __errno().* = 22;
        return -@as(c_int, 1);
    }
    __set.* |= @as(c_uint, 1) << @intCast(__signo - @as(c_int, 1));
    return @as(c_int, 0);
}
pub fn sigdelset(arg___set: [*c]sigset_t, arg___signo: c_int) callconv(.C) c_int {
    var __set = arg___set;
    var __signo = arg___signo;
    if ((__signo <= @as(c_int, 0)) or (__signo >= @as(c_int, 33))) {
        __errno().* = 22;
        return -@as(c_int, 1);
    }
    __set.* &= ~(@as(c_uint, 1) << @intCast(__signo - @as(c_int, 1)));
    return @as(c_int, 0);
}
pub fn sigemptyset(arg___set: [*c]sigset_t) callconv(.C) c_int {
    var __set = arg___set;
    __set.* = 0;
    return @as(c_int, 0);
}
pub fn sigfillset(arg___set: [*c]sigset_t) callconv(.C) c_int {
    var __set = arg___set;
    __set.* = ~@as(sigset_t, @bitCast(@as(c_int, 0)));
    return @as(c_int, 0);
}
pub fn sigismember(arg___set: [*c]const sigset_t, arg___signo: c_int) callconv(.C) c_int {
    var __set = arg___set;
    var __signo = arg___signo;
    if ((__signo <= @as(c_int, 0)) or (__signo >= @as(c_int, 33))) {
        __errno().* = 22;
        return -@as(c_int, 1);
    }
    return @intFromBool((__set.* & (@as(c_uint, 1) << @intCast(__signo - @as(c_int, 1)))) != @as(c_uint, @bitCast(@as(c_int, 0))));
}
pub extern fn sigpending([*c]sigset_t) c_int;
pub extern fn sigprocmask(c_int, noalias [*c]const sigset_t, noalias [*c]sigset_t) c_int;
pub extern fn pthread_sigmask(c_int, noalias [*c]const sigset_t, noalias [*c]sigset_t) c_int;
pub extern fn sigsuspend([*c]const sigset_t) c_int;
pub extern fn killpg(pid_t, c_int) c_int;
pub extern fn siginterrupt(c_int, c_int) c_int;
pub extern fn sigaltstack(noalias [*c]const struct_sigaltstack, noalias [*c]struct_sigaltstack) c_int;
pub extern fn sigblock(c_int) c_int;
pub extern fn sigpause(c_int) c_int;
pub extern fn sigsetmask(c_int) c_int;
pub extern fn sigvec(c_int, [*c]struct_sigvec, [*c]struct_sigvec) c_int;
pub extern fn thrkill(_tid: pid_t, _signum: c_int, _tcb: ?*anyopaque) c_int;
pub extern fn sigwait(noalias [*c]const sigset_t, noalias [*c]c_int) c_int;
pub extern fn psignal(c_uint, [*c]const u8) void;
const union_unnamed_9 = extern union {
    unused: ?*anyopaque,
    count: c_uint,
};
pub const uv__io_cb = ?*const fn ([*c]struct_uv_loop_s, [*c]struct_uv__io_s, c_uint) callconv(.C) void;
pub const struct_uv__io_s = extern struct {
    cb: uv__io_cb,
    pending_queue: [2]?*anyopaque,
    watcher_queue: [2]?*anyopaque,
    pevents: c_uint,
    events: c_uint,
    fd: c_int,
    rcount: c_int,
    wcount: c_int,
};
pub const uv__io_t = struct_uv__io_s;
pub const uv_mutex_t = pthread_mutex_t;
pub const uv_loop_t = struct_uv_loop_s;
const union_unnamed_10 = extern union {
    fd: c_int,
    reserved: [4]?*anyopaque,
};
pub const struct_uv_handle_s = extern struct {
    data: ?*anyopaque,
    loop: [*c]uv_loop_t,
    type: uv_handle_type,
    close_cb: uv_close_cb,
    handle_queue: [2]?*anyopaque,
    u: union_unnamed_10,
    next_closing: [*c]uv_handle_t,
    flags: c_uint,
};
pub const uv_handle_t = struct_uv_handle_s;
pub const uv_close_cb = ?*const fn ([*c]uv_handle_t) callconv(.C) void;
const union_unnamed_11 = extern union {
    fd: c_int,
    reserved: [4]?*anyopaque,
};
pub const uv_async_cb = ?*const fn ([*c]uv_async_t) callconv(.C) void;
pub const struct_uv_async_s = extern struct {
    data: ?*anyopaque,
    loop: [*c]uv_loop_t,
    type: uv_handle_type,
    close_cb: uv_close_cb,
    handle_queue: [2]?*anyopaque,
    u: union_unnamed_11,
    next_closing: [*c]uv_handle_t,
    flags: c_uint,
    async_cb: uv_async_cb,
    queue: [2]?*anyopaque,
    pending: c_int,
};
pub const uv_async_t = struct_uv_async_s;
pub const uv_rwlock_t = pthread_rwlock_t;
const struct_unnamed_12 = extern struct {
    min: ?*anyopaque,
    nelts: c_uint,
};
const union_unnamed_13 = extern union {
    fd: c_int,
    reserved: [4]?*anyopaque,
};
pub const uv_signal_cb = ?*const fn ([*c]uv_signal_t, c_int) callconv(.C) void;
const struct_unnamed_14 = extern struct {
    rbe_left: [*c]struct_uv_signal_s,
    rbe_right: [*c]struct_uv_signal_s,
    rbe_parent: [*c]struct_uv_signal_s,
    rbe_color: c_int,
};
pub const struct_uv_signal_s = extern struct {
    data: ?*anyopaque,
    loop: [*c]uv_loop_t,
    type: uv_handle_type,
    close_cb: uv_close_cb,
    handle_queue: [2]?*anyopaque,
    u: union_unnamed_13,
    next_closing: [*c]uv_handle_t,
    flags: c_uint,
    signal_cb: uv_signal_cb,
    signum: c_int,
    tree_entry: struct_unnamed_14,
    caught_signals: c_uint,
    dispatched_signals: c_uint,
};
pub const uv_signal_t = struct_uv_signal_s;
pub const struct_uv_loop_s = extern struct {
    data: ?*anyopaque,
    active_handles: c_uint,
    handle_queue: [2]?*anyopaque,
    active_reqs: union_unnamed_9,
    internal_fields: ?*anyopaque,
    stop_flag: c_uint,
    flags: c_ulong,
    backend_fd: c_int,
    pending_queue: [2]?*anyopaque,
    watcher_queue: [2]?*anyopaque,
    watchers: [*c][*c]uv__io_t,
    nwatchers: c_uint,
    nfds: c_uint,
    wq: [2]?*anyopaque,
    wq_mutex: uv_mutex_t,
    wq_async: uv_async_t,
    cloexec_lock: uv_rwlock_t,
    closing_handles: [*c]uv_handle_t,
    process_handles: [2]?*anyopaque,
    prepare_handles: [2]?*anyopaque,
    check_handles: [2]?*anyopaque,
    idle_handles: [2]?*anyopaque,
    async_handles: [2]?*anyopaque,
    async_unused: ?*const fn () callconv(.C) void,
    async_io_watcher: uv__io_t,
    async_wfd: c_int,
    timer_heap: struct_unnamed_12,
    timer_counter: u64,
    time: u64,
    signal_pipefd: [2]c_int,
    signal_io_watcher: uv__io_t,
    child_watcher: uv_signal_t,
    emfile_fd: c_int,
};
pub const struct_uv__work = extern struct {
    work: ?*const fn ([*c]struct_uv__work) callconv(.C) void,
    done: ?*const fn ([*c]struct_uv__work, c_int) callconv(.C) void,
    loop: [*c]struct_uv_loop_s,
    wq: [2]?*anyopaque,
};
pub const struct_uv_buf_t = extern struct {
    base: [*c]u8,
    len: usize,
};
pub const uv_buf_t = struct_uv_buf_t;
pub const uv_file = c_int;
pub const uv_os_sock_t = c_int;
pub const uv_os_fd_t = c_int;
pub const uv_pid_t = pid_t;
pub const uv_once_t = pthread_once_t;
pub const uv_thread_t = pthread_t;
pub const uv_sem_t = sem_t;
pub const uv_cond_t = pthread_cond_t;
pub const uv_key_t = pthread_key_t;
pub const struct__uv_barrier = extern struct {
    mutex: uv_mutex_t,
    cond: uv_cond_t,
    threshold: c_uint,
    in: c_uint,
    out: c_uint,
};
pub const uv_barrier_t = extern struct {
    b: [*c]struct__uv_barrier align(8),
    pub fn pad(self: anytype) @import("std").zig.c_translation.FlexibleArrayType(@TypeOf(self), u8) {
        const Intermediate = @import("std").zig.c_translation.FlexibleArrayType(@TypeOf(self), u8);
        const ReturnType = @import("std").zig.c_translation.FlexibleArrayType(@TypeOf(self), u8);
        return @as(ReturnType, @ptrCast(@alignCast(@as(Intermediate, @ptrCast(self)) + 8)));
    }
};
pub const uv_gid_t = gid_t;
pub const uv_uid_t = uid_t;
pub const uv__dirent_t = struct_dirent;
pub const uv_lib_t = extern struct {
    handle: ?*anyopaque,
    errmsg: [*c]u8,
};
pub const UV_E2BIG: c_int = -7;
pub const UV_EACCES: c_int = -13;
pub const UV_EADDRINUSE: c_int = -48;
pub const UV_EADDRNOTAVAIL: c_int = -49;
pub const UV_EAFNOSUPPORT: c_int = -47;
pub const UV_EAGAIN: c_int = -35;
pub const UV_EAI_ADDRFAMILY: c_int = -3000;
pub const UV_EAI_AGAIN: c_int = -3001;
pub const UV_EAI_BADFLAGS: c_int = -3002;
pub const UV_EAI_BADHINTS: c_int = -3013;
pub const UV_EAI_CANCELED: c_int = -3003;
pub const UV_EAI_FAIL: c_int = -3004;
pub const UV_EAI_FAMILY: c_int = -3005;
pub const UV_EAI_MEMORY: c_int = -3006;
pub const UV_EAI_NODATA: c_int = -3007;
pub const UV_EAI_NONAME: c_int = -3008;
pub const UV_EAI_OVERFLOW: c_int = -3009;
pub const UV_EAI_PROTOCOL: c_int = -3014;
pub const UV_EAI_SERVICE: c_int = -3010;
pub const UV_EAI_SOCKTYPE: c_int = -3011;
pub const UV_EALREADY: c_int = -37;
pub const UV_EBADF: c_int = -9;
pub const UV_EBUSY: c_int = -16;
pub const UV_ECANCELED: c_int = -88;
pub const UV_ECHARSET: c_int = -4080;
pub const UV_ECONNABORTED: c_int = -53;
pub const UV_ECONNREFUSED: c_int = -61;
pub const UV_ECONNRESET: c_int = -54;
pub const UV_EDESTADDRREQ: c_int = -39;
pub const UV_EEXIST: c_int = -17;
pub const UV_EFAULT: c_int = -14;
pub const UV_EFBIG: c_int = -27;
pub const UV_EHOSTUNREACH: c_int = -65;
pub const UV_EINTR: c_int = -4;
pub const UV_EINVAL: c_int = -22;
pub const UV_EIO: c_int = -5;
pub const UV_EISCONN: c_int = -56;
pub const UV_EISDIR: c_int = -21;
pub const UV_ELOOP: c_int = -62;
pub const UV_EMFILE: c_int = -24;
pub const UV_EMSGSIZE: c_int = -40;
pub const UV_ENAMETOOLONG: c_int = -63;
pub const UV_ENETDOWN: c_int = -50;
pub const UV_ENETUNREACH: c_int = -51;
pub const UV_ENFILE: c_int = -23;
pub const UV_ENOBUFS: c_int = -55;
pub const UV_ENODEV: c_int = -19;
pub const UV_ENOENT: c_int = -2;
pub const UV_ENOMEM: c_int = -12;
pub const UV_ENONET: c_int = -4056;
pub const UV_ENOPROTOOPT: c_int = -42;
pub const UV_ENOSPC: c_int = -28;
pub const UV_ENOSYS: c_int = -78;
pub const UV_ENOTCONN: c_int = -57;
pub const UV_ENOTDIR: c_int = -20;
pub const UV_ENOTEMPTY: c_int = -66;
pub const UV_ENOTSOCK: c_int = -38;
pub const UV_ENOTSUP: c_int = -91;
pub const UV_EOVERFLOW: c_int = -87;
pub const UV_EPERM: c_int = -1;
pub const UV_EPIPE: c_int = -32;
pub const UV_EPROTO: c_int = -95;
pub const UV_EPROTONOSUPPORT: c_int = -43;
pub const UV_EPROTOTYPE: c_int = -41;
pub const UV_ERANGE: c_int = -34;
pub const UV_EROFS: c_int = -30;
pub const UV_ESHUTDOWN: c_int = -58;
pub const UV_ESPIPE: c_int = -29;
pub const UV_ESRCH: c_int = -3;
pub const UV_ETIMEDOUT: c_int = -60;
pub const UV_ETXTBSY: c_int = -26;
pub const UV_EXDEV: c_int = -18;
pub const UV_UNKNOWN: c_int = -4094;
pub const UV_EOF: c_int = -4095;
pub const UV_ENXIO: c_int = -6;
pub const UV_EMLINK: c_int = -31;
pub const UV_EHOSTDOWN: c_int = -64;
pub const UV_EREMOTEIO: c_int = -4030;
pub const UV_ENOTTY: c_int = -25;
pub const UV_EFTYPE: c_int = -79;
pub const UV_EILSEQ: c_int = -84;
pub const UV_ESOCKTNOSUPPORT: c_int = -44;
pub const UV_ERRNO_MAX: c_int = -4096;
pub const uv_errno_t = c_int;
pub const UV_UNKNOWN_HANDLE: c_int = 0;
pub const UV_ASYNC: c_int = 1;
pub const UV_CHECK: c_int = 2;
pub const UV_FS_EVENT: c_int = 3;
pub const UV_FS_POLL: c_int = 4;
pub const UV_HANDLE: c_int = 5;
pub const UV_IDLE: c_int = 6;
pub const UV_NAMED_PIPE: c_int = 7;
pub const UV_POLL: c_int = 8;
pub const UV_PREPARE: c_int = 9;
pub const UV_PROCESS: c_int = 10;
pub const UV_STREAM: c_int = 11;
pub const UV_TCP: c_int = 12;
pub const UV_TIMER: c_int = 13;
pub const UV_TTY: c_int = 14;
pub const UV_UDP: c_int = 15;
pub const UV_SIGNAL: c_int = 16;
pub const UV_FILE: c_int = 17;
pub const UV_HANDLE_TYPE_MAX: c_int = 18;
pub const uv_handle_type = c_uint;
pub const UV_UNKNOWN_REQ: c_int = 0;
pub const UV_REQ: c_int = 1;
pub const UV_CONNECT: c_int = 2;
pub const UV_WRITE: c_int = 3;
pub const UV_SHUTDOWN: c_int = 4;
pub const UV_UDP_SEND: c_int = 5;
pub const UV_FS: c_int = 6;
pub const UV_WORK: c_int = 7;
pub const UV_GETADDRINFO: c_int = 8;
pub const UV_GETNAMEINFO: c_int = 9;
pub const UV_RANDOM: c_int = 10;
pub const UV_REQ_TYPE_MAX: c_int = 11;
pub const uv_req_type = c_uint;
pub const struct_uv_dirent_s = extern struct {
    name: [*c]const u8,
    type: uv_dirent_type_t,
};
pub const uv_dirent_t = struct_uv_dirent_s;
pub const struct_uv_dir_s = extern struct {
    dirents: [*c]uv_dirent_t,
    nentries: usize,
    reserved: [4]?*anyopaque,
    dir: ?*DIR,
};
pub const uv_dir_t = struct_uv_dir_s;
const union_unnamed_15 = extern union {
    fd: c_int,
    reserved: [4]?*anyopaque,
};
pub const uv_alloc_cb = ?*const fn ([*c]uv_handle_t, usize, [*c]uv_buf_t) callconv(.C) void;
pub const uv_stream_t = struct_uv_stream_s;
pub const uv_read_cb = ?*const fn ([*c]uv_stream_t, isize, [*c]const uv_buf_t) callconv(.C) void;
pub const uv_connect_cb = ?*const fn ([*c]uv_connect_t, c_int) callconv(.C) void;
pub const struct_uv_connect_s = extern struct {
    data: ?*anyopaque,
    type: uv_req_type,
    reserved: [6]?*anyopaque,
    cb: uv_connect_cb,
    handle: [*c]uv_stream_t,
    queue: [2]?*anyopaque,
};
pub const uv_connect_t = struct_uv_connect_s;
pub const uv_shutdown_cb = ?*const fn ([*c]uv_shutdown_t, c_int) callconv(.C) void;
pub const struct_uv_shutdown_s = extern struct {
    data: ?*anyopaque,
    type: uv_req_type,
    reserved: [6]?*anyopaque,
    handle: [*c]uv_stream_t,
    cb: uv_shutdown_cb,
};
pub const uv_shutdown_t = struct_uv_shutdown_s;
pub const uv_connection_cb = ?*const fn ([*c]uv_stream_t, c_int) callconv(.C) void;
pub const struct_uv_stream_s = extern struct {
    data: ?*anyopaque,
    loop: [*c]uv_loop_t,
    type: uv_handle_type,
    close_cb: uv_close_cb,
    handle_queue: [2]?*anyopaque,
    u: union_unnamed_15,
    next_closing: [*c]uv_handle_t,
    flags: c_uint,
    write_queue_size: usize,
    alloc_cb: uv_alloc_cb,
    read_cb: ?*const anyopaque, // Zig monke
    connect_req: [*c]uv_connect_t,
    shutdown_req: [*c]uv_shutdown_t,
    io_watcher: uv__io_t,
    write_queue: [2]?*anyopaque,
    write_completed_queue: [2]?*anyopaque,
    connection_cb: uv_connection_cb,
    delayed_error: c_int,
    accepted_fd: c_int,
    queued_fds: ?*anyopaque,
};
const union_unnamed_16 = extern union {
    fd: c_int,
    reserved: [4]?*anyopaque,
};
pub const struct_uv_tcp_s = extern struct {
    data: ?*anyopaque,
    loop: [*c]uv_loop_t,
    type: uv_handle_type,
    close_cb: uv_close_cb,
    handle_queue: [2]?*anyopaque,
    u: union_unnamed_16,
    next_closing: [*c]uv_handle_t,
    flags: c_uint,
    write_queue_size: usize,
    alloc_cb: uv_alloc_cb,
    read_cb: uv_read_cb,
    connect_req: [*c]uv_connect_t,
    shutdown_req: [*c]uv_shutdown_t,
    io_watcher: uv__io_t,
    write_queue: [2]?*anyopaque,
    write_completed_queue: [2]?*anyopaque,
    connection_cb: uv_connection_cb,
    delayed_error: c_int,
    accepted_fd: c_int,
    queued_fds: ?*anyopaque,
};
pub const uv_tcp_t = struct_uv_tcp_s;
const union_unnamed_17 = extern union {
    fd: c_int,
    reserved: [4]?*anyopaque,
};
pub const uv_udp_t = struct_uv_udp_s;
pub const uv_udp_recv_cb = ?*const fn ([*c]uv_udp_t, isize, [*c]const uv_buf_t, [*c]const struct_sockaddr, c_uint) callconv(.C) void;
pub const struct_uv_udp_s = extern struct {
    data: ?*anyopaque,
    loop: [*c]uv_loop_t,
    type: uv_handle_type,
    close_cb: uv_close_cb,
    handle_queue: [2]?*anyopaque,
    u: union_unnamed_17,
    next_closing: [*c]uv_handle_t,
    flags: c_uint,
    send_queue_size: usize,
    send_queue_count: usize,
    alloc_cb: uv_alloc_cb,
    recv_cb: uv_udp_recv_cb,
    io_watcher: uv__io_t,
    write_queue: [2]?*anyopaque,
    write_completed_queue: [2]?*anyopaque,
};
const union_unnamed_18 = extern union {
    fd: c_int,
    reserved: [4]?*anyopaque,
};
pub const struct_uv_pipe_s = extern struct {
    data: ?*anyopaque,
    loop: [*c]uv_loop_t,
    type: uv_handle_type,
    close_cb: uv_close_cb,
    handle_queue: [2]?*anyopaque,
    u: union_unnamed_18,
    next_closing: [*c]uv_handle_t,
    flags: c_uint,
    write_queue_size: usize,
    alloc_cb: uv_alloc_cb,
    read_cb: uv_read_cb,
    connect_req: [*c]uv_connect_t,
    shutdown_req: [*c]uv_shutdown_t,
    io_watcher: uv__io_t,
    write_queue: [2]?*anyopaque,
    write_completed_queue: [2]?*anyopaque,
    connection_cb: uv_connection_cb,
    delayed_error: c_int,
    accepted_fd: c_int,
    queued_fds: ?*anyopaque,
    ipc: c_int,
    pipe_fname: [*c]const u8,
};
pub const uv_pipe_t = struct_uv_pipe_s;
const union_unnamed_19 = extern union {
    fd: c_int,
    reserved: [4]?*anyopaque,
};
pub const struct_uv_tty_s = extern struct {
    data: ?*anyopaque,
    loop: [*c]uv_loop_t,
    type: uv_handle_type,
    close_cb: uv_close_cb,
    handle_queue: [2]?*anyopaque,
    u: union_unnamed_19,
    next_closing: [*c]uv_handle_t,
    flags: c_uint,
    write_queue_size: usize,
    alloc_cb: uv_alloc_cb,
    read_cb: uv_read_cb,
    connect_req: [*c]uv_connect_t,
    shutdown_req: [*c]uv_shutdown_t,
    io_watcher: uv__io_t,
    write_queue: [2]?*anyopaque,
    write_completed_queue: [2]?*anyopaque,
    connection_cb: uv_connection_cb,
    delayed_error: c_int,
    accepted_fd: c_int,
    queued_fds: ?*anyopaque,
    orig_termios: struct_termios,
    mode: c_int,
};
pub const uv_tty_t = struct_uv_tty_s;
const union_unnamed_20 = extern union {
    fd: c_int,
    reserved: [4]?*anyopaque,
};
pub const uv_poll_t = struct_uv_poll_s;
pub const uv_poll_cb = ?*const fn ([*c]uv_poll_t, c_int, c_int) callconv(.C) void;
pub const struct_uv_poll_s = extern struct {
    data: ?*anyopaque,
    loop: [*c]uv_loop_t,
    type: uv_handle_type,
    close_cb: uv_close_cb,
    handle_queue: [2]?*anyopaque,
    u: union_unnamed_20,
    next_closing: [*c]uv_handle_t,
    flags: c_uint,
    poll_cb: uv_poll_cb,
    io_watcher: uv__io_t,
};
const union_unnamed_21 = extern union {
    fd: c_int,
    reserved: [4]?*anyopaque,
};
pub const uv_timer_t = struct_uv_timer_s;
pub const uv_timer_cb = ?*const fn ([*c]uv_timer_t) callconv(.C) void;
pub const struct_uv_timer_s = extern struct {
    data: ?*anyopaque,
    loop: [*c]uv_loop_t,
    type: uv_handle_type,
    close_cb: uv_close_cb,
    handle_queue: [2]?*anyopaque,
    u: union_unnamed_21,
    next_closing: [*c]uv_handle_t,
    flags: c_uint,
    timer_cb: uv_timer_cb,
    heap_node: [3]?*anyopaque,
    timeout: u64,
    repeat: u64,
    start_id: u64,
};
const union_unnamed_22 = extern union {
    fd: c_int,
    reserved: [4]?*anyopaque,
};
pub const uv_prepare_t = struct_uv_prepare_s;
pub const uv_prepare_cb = ?*const fn ([*c]uv_prepare_t) callconv(.C) void;
pub const struct_uv_prepare_s = extern struct {
    data: ?*anyopaque,
    loop: [*c]uv_loop_t,
    type: uv_handle_type,
    close_cb: uv_close_cb,
    handle_queue: [2]?*anyopaque,
    u: union_unnamed_22,
    next_closing: [*c]uv_handle_t,
    flags: c_uint,
    prepare_cb: uv_prepare_cb,
    queue: [2]?*anyopaque,
};
const union_unnamed_23 = extern union {
    fd: c_int,
    reserved: [4]?*anyopaque,
};
pub const uv_check_t = struct_uv_check_s;
pub const uv_check_cb = ?*const fn ([*c]uv_check_t) callconv(.C) void;
pub const struct_uv_check_s = extern struct {
    data: ?*anyopaque,
    loop: [*c]uv_loop_t,
    type: uv_handle_type,
    close_cb: uv_close_cb,
    handle_queue: [2]?*anyopaque,
    u: union_unnamed_23,
    next_closing: [*c]uv_handle_t,
    flags: c_uint,
    check_cb: uv_check_cb,
    queue: [2]?*anyopaque,
};
const union_unnamed_24 = extern union {
    fd: c_int,
    reserved: [4]?*anyopaque,
};
pub const uv_idle_t = struct_uv_idle_s;
pub const uv_idle_cb = ?*const fn ([*c]uv_idle_t) callconv(.C) void;
pub const struct_uv_idle_s = extern struct {
    data: ?*anyopaque,
    loop: [*c]uv_loop_t,
    type: uv_handle_type,
    close_cb: uv_close_cb,
    handle_queue: [2]?*anyopaque,
    u: union_unnamed_24,
    next_closing: [*c]uv_handle_t,
    flags: c_uint,
    idle_cb: uv_idle_cb,
    queue: [2]?*anyopaque,
};
const union_unnamed_25 = extern union {
    fd: c_int,
    reserved: [4]?*anyopaque,
};
pub const uv_process_t = struct_uv_process_s;
pub const uv_exit_cb = ?*const fn ([*c]uv_process_t, i64, c_int) callconv(.C) void;
pub const struct_uv_process_s = extern struct {
    data: ?*anyopaque,
    loop: [*c]uv_loop_t,
    type: uv_handle_type,
    close_cb: uv_close_cb,
    handle_queue: [2]?*anyopaque,
    u: union_unnamed_25,
    next_closing: [*c]uv_handle_t,
    flags: c_uint,
    exit_cb: uv_exit_cb,
    pid: c_int,
    queue: [2]?*anyopaque,
    status: c_int,
};
const union_unnamed_26 = extern union {
    fd: c_int,
    reserved: [4]?*anyopaque,
};
pub const uv_fs_event_t = struct_uv_fs_event_s;
pub const uv_fs_event_cb = ?*const fn ([*c]uv_fs_event_t, [*c]const u8, c_int, c_int) callconv(.C) void;
pub const struct_uv_fs_event_s = extern struct {
    data: ?*anyopaque,
    loop: [*c]uv_loop_t,
    type: uv_handle_type,
    close_cb: uv_close_cb,
    handle_queue: [2]?*anyopaque,
    u: union_unnamed_26,
    next_closing: [*c]uv_handle_t,
    flags: c_uint,
    path: [*c]u8,
    cb: uv_fs_event_cb,
    event_watcher: uv__io_t,
};
const union_unnamed_27 = extern union {
    fd: c_int,
    reserved: [4]?*anyopaque,
};
pub const struct_uv_fs_poll_s = extern struct {
    data: ?*anyopaque,
    loop: [*c]uv_loop_t,
    type: uv_handle_type,
    close_cb: uv_close_cb,
    handle_queue: [2]?*anyopaque,
    u: union_unnamed_27,
    next_closing: [*c]uv_handle_t,
    flags: c_uint,
    poll_ctx: ?*anyopaque,
};
pub const uv_fs_poll_t = struct_uv_fs_poll_s;
pub const struct_uv_req_s = extern struct {
    data: ?*anyopaque,
    type: uv_req_type,
    reserved: [6]?*anyopaque,
};
pub const uv_req_t = struct_uv_req_s;
pub const uv_getaddrinfo_t = struct_uv_getaddrinfo_s;
pub const uv_getaddrinfo_cb = ?*const fn ([*c]uv_getaddrinfo_t, c_int, [*c]struct_addrinfo) callconv(.C) void;
pub const struct_uv_getaddrinfo_s = extern struct {
    data: ?*anyopaque,
    type: uv_req_type,
    reserved: [6]?*anyopaque,
    loop: [*c]uv_loop_t,
    work_req: struct_uv__work,
    cb: uv_getaddrinfo_cb,
    hints: [*c]struct_addrinfo,
    hostname: [*c]u8,
    service: [*c]u8,
    addrinfo: [*c]struct_addrinfo,
    retcode: c_int,
};
pub const uv_getnameinfo_t = struct_uv_getnameinfo_s;
pub const uv_getnameinfo_cb = ?*const fn ([*c]uv_getnameinfo_t, c_int, [*c]const u8, [*c]const u8) callconv(.C) void;
pub const struct_uv_getnameinfo_s = extern struct {
    data: ?*anyopaque,
    type: uv_req_type,
    reserved: [6]?*anyopaque,
    loop: [*c]uv_loop_t,
    work_req: struct_uv__work,
    getnameinfo_cb: uv_getnameinfo_cb,
    storage: struct_sockaddr_storage,
    flags: c_int,
    host: [256]u8,
    service: [32]u8,
    retcode: c_int,
};
pub const uv_write_t = struct_uv_write_s;
pub const uv_write_cb = ?*const fn ([*c]uv_write_t, c_int) callconv(.C) void;
pub const struct_uv_write_s = extern struct {
    data: ?*anyopaque,
    type: uv_req_type,
    reserved: [6]?*anyopaque,
    cb: uv_write_cb,
    send_handle: [*c]uv_stream_t,
    handle: [*c]uv_stream_t,
    queue: [2]?*anyopaque,
    write_index: c_uint,
    bufs: [*c]uv_buf_t,
    nbufs: c_uint,
    @"error": c_int,
    bufsml: [4]uv_buf_t,
};
pub const uv_udp_send_t = struct_uv_udp_send_s;
pub const uv_udp_send_cb = ?*const fn ([*c]uv_udp_send_t, c_int) callconv(.C) void;
pub const struct_uv_udp_send_s = extern struct {
    data: ?*anyopaque,
    type: uv_req_type,
    reserved: [6]?*anyopaque,
    handle: [*c]uv_udp_t,
    cb: uv_udp_send_cb,
    queue: [2]?*anyopaque,
    addr: struct_sockaddr_storage,
    nbufs: c_uint,
    bufs: [*c]uv_buf_t,
    status: isize,
    send_cb: uv_udp_send_cb,
    bufsml: [4]uv_buf_t,
};
pub const uv_fs_t = struct_uv_fs_s;
pub const uv_fs_cb = ?*const fn ([*c]uv_fs_t) callconv(.C) void;
pub const struct_uv_fs_s = extern struct {
    data: ?*anyopaque,
    type: uv_req_type,
    reserved: [6]?*anyopaque,
    fs_type: uv_fs_type,
    loop: [*c]uv_loop_t,
    cb: uv_fs_cb,
    result: isize,
    ptr: ?*anyopaque,
    path: [*c]const u8,
    statbuf: uv_stat_t,
    new_path: [*c]const u8,
    file: uv_file,
    flags: c_int,
    mode: mode_t,
    nbufs: c_uint,
    bufs: [*c]uv_buf_t,
    off: off_t,
    uid: uv_uid_t,
    gid: uv_gid_t,
    atime: f64,
    mtime: f64,
    work_req: struct_uv__work,
    bufsml: [4]uv_buf_t,
};
pub const uv_work_t = struct_uv_work_s;
pub const uv_work_cb = ?*const fn ([*c]uv_work_t) callconv(.C) void;
pub const uv_after_work_cb = ?*const fn ([*c]uv_work_t, c_int) callconv(.C) void;
pub const struct_uv_work_s = extern struct {
    data: ?*anyopaque,
    type: uv_req_type,
    reserved: [6]?*anyopaque,
    loop: [*c]uv_loop_t,
    work_cb: uv_work_cb,
    after_work_cb: uv_after_work_cb,
    work_req: struct_uv__work,
};
pub const uv_random_t = struct_uv_random_s;
pub const uv_random_cb = ?*const fn ([*c]uv_random_t, c_int, ?*anyopaque, usize) callconv(.C) void;
pub const struct_uv_random_s = extern struct {
    data: ?*anyopaque,
    type: uv_req_type,
    reserved: [6]?*anyopaque,
    loop: [*c]uv_loop_t,
    status: c_int,
    buf: ?*anyopaque,
    buflen: usize,
    cb: uv_random_cb,
    work_req: struct_uv__work,
};
pub const struct_uv_env_item_s = extern struct {
    name: [*c]u8,
    value: [*c]u8,
};
pub const uv_env_item_t = struct_uv_env_item_s;
pub const struct_uv_cpu_times_s = extern struct {
    user: u64,
    nice: u64,
    sys: u64,
    idle: u64,
    irq: u64,
};
pub const struct_uv_cpu_info_s = extern struct {
    model: [*c]u8,
    speed: c_int,
    cpu_times: struct_uv_cpu_times_s,
};
pub const uv_cpu_info_t = struct_uv_cpu_info_s;
const union_unnamed_28 = extern union {
    address4: struct_sockaddr_in,
    address6: struct_sockaddr_in6,
};
const union_unnamed_29 = extern union {
    netmask4: struct_sockaddr_in,
    netmask6: struct_sockaddr_in6,
};
pub const struct_uv_interface_address_s = extern struct {
    name: [*c]u8,
    phys_addr: [6]u8,
    is_internal: c_int,
    address: union_unnamed_28,
    netmask: union_unnamed_29,
};
pub const uv_interface_address_t = struct_uv_interface_address_s;
pub const struct_uv_passwd_s = extern struct {
    username: [*c]u8,
    uid: c_ulong,
    gid: c_ulong,
    shell: [*c]u8,
    homedir: [*c]u8,
};
pub const uv_passwd_t = struct_uv_passwd_s;
pub const struct_uv_utsname_s = extern struct {
    sysname: [256]u8,
    release: [256]u8,
    version: [256]u8,
    machine: [256]u8,
};
pub const uv_utsname_t = struct_uv_utsname_s;
pub const struct_uv_statfs_s = extern struct {
    f_type: u64,
    f_bsize: u64,
    f_blocks: u64,
    f_bfree: u64,
    f_bavail: u64,
    f_files: u64,
    f_ffree: u64,
    f_spare: [4]u64,
};
pub const uv_statfs_t = struct_uv_statfs_s;
pub const UV_LOOP_BLOCK_SIGNAL: c_int = 0;
pub const UV_METRICS_IDLE_TIME: c_int = 1;
pub const uv_loop_option = c_uint;
pub const UV_RUN_DEFAULT: c_int = 0;
pub const UV_RUN_ONCE: c_int = 1;
pub const UV_RUN_NOWAIT: c_int = 2;
pub const uv_run_mode = c_uint;
pub extern fn uv_version() c_uint;
pub extern fn uv_version_string() [*c]const u8;
pub const uv_malloc_func = ?*const fn (usize) callconv(.C) ?*anyopaque;
pub const uv_realloc_func = ?*const fn (?*anyopaque, usize) callconv(.C) ?*anyopaque;
pub const uv_calloc_func = ?*const fn (usize, usize) callconv(.C) ?*anyopaque;
pub const uv_free_func = ?*const fn (?*anyopaque) callconv(.C) void;
pub extern fn uv_library_shutdown() void;
pub extern fn uv_replace_allocator(malloc_func: uv_malloc_func, realloc_func: uv_realloc_func, calloc_func: uv_calloc_func, free_func: uv_free_func) c_int;
pub extern fn uv_default_loop() [*c]uv_loop_t;
pub extern fn uv_loop_init(loop: [*c]uv_loop_t) c_int;
pub extern fn uv_loop_close(loop: [*c]uv_loop_t) c_int;
pub extern fn uv_loop_new() [*c]uv_loop_t;
pub extern fn uv_loop_delete([*c]uv_loop_t) void;
pub extern fn uv_loop_size() usize;
pub extern fn uv_loop_alive(loop: [*c]const uv_loop_t) c_int;
pub extern fn uv_loop_configure(loop: [*c]uv_loop_t, option: uv_loop_option, ...) c_int;
pub extern fn uv_loop_fork(loop: [*c]uv_loop_t) c_int;
pub extern fn uv_run([*c]uv_loop_t, mode: uv_run_mode) c_int;
pub extern fn uv_stop([*c]uv_loop_t) void;
pub extern fn uv_ref([*c]uv_handle_t) void;
pub extern fn uv_unref([*c]uv_handle_t) void;
pub extern fn uv_has_ref([*c]const uv_handle_t) c_int;
pub extern fn uv_update_time([*c]uv_loop_t) void;
pub extern fn uv_now([*c]const uv_loop_t) u64;
pub extern fn uv_backend_fd([*c]const uv_loop_t) c_int;
pub extern fn uv_backend_timeout([*c]const uv_loop_t) c_int;
pub const uv_walk_cb = ?*const fn ([*c]uv_handle_t, ?*anyopaque) callconv(.C) void;
pub const uv_timespec_t = extern struct {
    tv_sec: c_long,
    tv_nsec: c_long,
};
pub const uv_stat_t = extern struct {
    st_dev: u64,
    st_mode: u64,
    st_nlink: u64,
    st_uid: u64,
    st_gid: u64,
    st_rdev: u64,
    st_ino: u64,
    st_size: u64,
    st_blksize: u64,
    st_blocks: u64,
    st_flags: u64,
    st_gen: u64,
    st_atim: uv_timespec_t,
    st_mtim: uv_timespec_t,
    st_ctim: uv_timespec_t,
    st_birthtim: uv_timespec_t,
};
pub const uv_fs_poll_cb = ?*const fn ([*c]uv_fs_poll_t, c_int, [*c]const uv_stat_t, [*c]const uv_stat_t) callconv(.C) void;
pub const UV_LEAVE_GROUP: c_int = 0;
pub const UV_JOIN_GROUP: c_int = 1;
pub const uv_membership = c_uint;
pub extern fn uv_translate_sys_error(sys_errno: c_int) c_int;
pub extern fn uv_strerror(err: c_int) [*c]const u8;
pub extern fn uv_strerror_r(err: c_int, buf: [*c]u8, buflen: usize) [*c]u8;
pub extern fn uv_err_name(err: c_int) [*c]const u8;
pub extern fn uv_err_name_r(err: c_int, buf: [*c]u8, buflen: usize) [*c]u8;
pub extern fn uv_shutdown(req: [*c]uv_shutdown_t, handle: [*c]uv_stream_t, cb: uv_shutdown_cb) c_int;
pub extern fn uv_handle_size(@"type": uv_handle_type) usize;
pub extern fn uv_handle_get_type(handle: [*c]const uv_handle_t) uv_handle_type;
pub extern fn uv_handle_type_name(@"type": uv_handle_type) [*c]const u8;
pub extern fn uv_handle_get_data(handle: [*c]const uv_handle_t) ?*anyopaque;
pub extern fn uv_handle_get_loop(handle: [*c]const uv_handle_t) [*c]uv_loop_t;
pub extern fn uv_handle_set_data(handle: [*c]uv_handle_t, data: ?*anyopaque) void;
pub extern fn uv_req_size(@"type": uv_req_type) usize;
pub extern fn uv_req_get_data(req: [*c]const uv_req_t) ?*anyopaque;
pub extern fn uv_req_set_data(req: [*c]uv_req_t, data: ?*anyopaque) void;
pub extern fn uv_req_get_type(req: [*c]const uv_req_t) uv_req_type;
pub extern fn uv_req_type_name(@"type": uv_req_type) [*c]const u8;
pub extern fn uv_is_active(handle: [*c]const uv_handle_t) c_int;
pub extern fn uv_walk(loop: [*c]uv_loop_t, walk_cb: uv_walk_cb, arg: ?*anyopaque) void;
pub extern fn uv_print_all_handles(loop: [*c]uv_loop_t, stream: [*c]FILE) void;
pub extern fn uv_print_active_handles(loop: [*c]uv_loop_t, stream: [*c]FILE) void;
pub extern fn uv_close(handle: [*c]uv_handle_t, close_cb: uv_close_cb) void;
pub extern fn uv_send_buffer_size(handle: [*c]uv_handle_t, value: [*c]c_int) c_int;
pub extern fn uv_recv_buffer_size(handle: [*c]uv_handle_t, value: [*c]c_int) c_int;
pub extern fn uv_fileno(handle: [*c]const uv_handle_t, fd: [*c]uv_os_fd_t) c_int;
pub extern fn uv_buf_init(base: [*c]u8, len: c_uint) uv_buf_t;
pub extern fn uv_pipe(fds: [*c]uv_file, read_flags: c_int, write_flags: c_int) c_int;
pub extern fn uv_socketpair(@"type": c_int, protocol: c_int, socket_vector: [*c]uv_os_sock_t, flags0: c_int, flags1: c_int) c_int;
pub extern fn uv_stream_get_write_queue_size(stream: [*c]const uv_stream_t) usize;
pub extern fn uv_listen(stream: [*c]uv_stream_t, backlog: c_int, cb: uv_connection_cb) c_int;
pub extern fn uv_accept(server: [*c]uv_stream_t, client: [*c]uv_stream_t) c_int;
pub extern fn uv_read_start([*c]uv_stream_t, alloc_cb: uv_alloc_cb, read_cb: uv_read_cb) c_int;
pub extern fn uv_read_stop([*c]uv_stream_t) c_int;
pub extern fn uv_write(req: [*c]uv_write_t, handle: [*c]uv_stream_t, bufs: [*c]const uv_buf_t, nbufs: c_uint, cb: uv_write_cb) c_int;
pub extern fn uv_write2(req: [*c]uv_write_t, handle: [*c]uv_stream_t, bufs: [*c]const uv_buf_t, nbufs: c_uint, send_handle: [*c]uv_stream_t, cb: uv_write_cb) c_int;
pub extern fn uv_try_write(handle: [*c]uv_stream_t, bufs: [*c]const uv_buf_t, nbufs: c_uint) c_int;
pub extern fn uv_try_write2(handle: [*c]uv_stream_t, bufs: [*c]const uv_buf_t, nbufs: c_uint, send_handle: [*c]uv_stream_t) c_int;
pub extern fn uv_is_readable(handle: [*c]const uv_stream_t) c_int;
pub extern fn uv_is_writable(handle: [*c]const uv_stream_t) c_int;
pub extern fn uv_stream_set_blocking(handle: [*c]uv_stream_t, blocking: c_int) c_int;
pub extern fn uv_is_closing(handle: [*c]const uv_handle_t) c_int;
pub extern fn uv_tcp_init([*c]uv_loop_t, handle: [*c]uv_tcp_t) c_int;
pub extern fn uv_tcp_init_ex([*c]uv_loop_t, handle: [*c]uv_tcp_t, flags: c_uint) c_int;
pub extern fn uv_tcp_open(handle: [*c]uv_tcp_t, sock: uv_os_sock_t) c_int;
pub extern fn uv_tcp_nodelay(handle: [*c]uv_tcp_t, enable: c_int) c_int;
pub extern fn uv_tcp_keepalive(handle: [*c]uv_tcp_t, enable: c_int, delay: c_uint) c_int;
pub extern fn uv_tcp_simultaneous_accepts(handle: [*c]uv_tcp_t, enable: c_int) c_int;
pub const UV_TCP_IPV6ONLY: c_int = 1;
pub const enum_uv_tcp_flags = c_uint;
pub extern fn uv_tcp_bind(handle: [*c]uv_tcp_t, addr: [*c]const struct_sockaddr, flags: c_uint) c_int;
pub extern fn uv_tcp_getsockname(handle: [*c]const uv_tcp_t, name: [*c]struct_sockaddr, namelen: [*c]c_int) c_int;
pub extern fn uv_tcp_getpeername(handle: [*c]const uv_tcp_t, name: [*c]struct_sockaddr, namelen: [*c]c_int) c_int;
pub extern fn uv_tcp_close_reset(handle: [*c]uv_tcp_t, close_cb: uv_close_cb) c_int;
pub extern fn uv_tcp_connect(req: [*c]uv_connect_t, handle: [*c]uv_tcp_t, addr: [*c]const struct_sockaddr, cb: uv_connect_cb) c_int;
pub const UV_UDP_IPV6ONLY: c_int = 1;
pub const UV_UDP_PARTIAL: c_int = 2;
pub const UV_UDP_REUSEADDR: c_int = 4;
pub const UV_UDP_MMSG_CHUNK: c_int = 8;
pub const UV_UDP_MMSG_FREE: c_int = 16;
pub const UV_UDP_LINUX_RECVERR: c_int = 32;
pub const UV_UDP_RECVMMSG: c_int = 256;
pub const enum_uv_udp_flags = c_uint;
pub extern fn uv_udp_init([*c]uv_loop_t, handle: [*c]uv_udp_t) c_int;
pub extern fn uv_udp_init_ex([*c]uv_loop_t, handle: [*c]uv_udp_t, flags: c_uint) c_int;
pub extern fn uv_udp_open(handle: [*c]uv_udp_t, sock: uv_os_sock_t) c_int;
pub extern fn uv_udp_bind(handle: [*c]uv_udp_t, addr: [*c]const struct_sockaddr, flags: c_uint) c_int;
pub extern fn uv_udp_connect(handle: [*c]uv_udp_t, addr: [*c]const struct_sockaddr) c_int;
pub extern fn uv_udp_getpeername(handle: [*c]const uv_udp_t, name: [*c]struct_sockaddr, namelen: [*c]c_int) c_int;
pub extern fn uv_udp_getsockname(handle: [*c]const uv_udp_t, name: [*c]struct_sockaddr, namelen: [*c]c_int) c_int;
pub extern fn uv_udp_set_membership(handle: [*c]uv_udp_t, multicast_addr: [*c]const u8, interface_addr: [*c]const u8, membership: uv_membership) c_int;
pub extern fn uv_udp_set_source_membership(handle: [*c]uv_udp_t, multicast_addr: [*c]const u8, interface_addr: [*c]const u8, source_addr: [*c]const u8, membership: uv_membership) c_int;
pub extern fn uv_udp_set_multicast_loop(handle: [*c]uv_udp_t, on: c_int) c_int;
pub extern fn uv_udp_set_multicast_ttl(handle: [*c]uv_udp_t, ttl: c_int) c_int;
pub extern fn uv_udp_set_multicast_interface(handle: [*c]uv_udp_t, interface_addr: [*c]const u8) c_int;
pub extern fn uv_udp_set_broadcast(handle: [*c]uv_udp_t, on: c_int) c_int;
pub extern fn uv_udp_set_ttl(handle: [*c]uv_udp_t, ttl: c_int) c_int;
pub extern fn uv_udp_send(req: [*c]uv_udp_send_t, handle: [*c]uv_udp_t, bufs: [*c]const uv_buf_t, nbufs: c_uint, addr: [*c]const struct_sockaddr, send_cb: uv_udp_send_cb) c_int;
pub extern fn uv_udp_try_send(handle: [*c]uv_udp_t, bufs: [*c]const uv_buf_t, nbufs: c_uint, addr: [*c]const struct_sockaddr) c_int;
pub extern fn uv_udp_recv_start(handle: [*c]uv_udp_t, alloc_cb: uv_alloc_cb, recv_cb: uv_udp_recv_cb) c_int;
pub extern fn uv_udp_using_recvmmsg(handle: [*c]const uv_udp_t) c_int;
pub extern fn uv_udp_recv_stop(handle: [*c]uv_udp_t) c_int;
pub extern fn uv_udp_get_send_queue_size(handle: [*c]const uv_udp_t) usize;
pub extern fn uv_udp_get_send_queue_count(handle: [*c]const uv_udp_t) usize;
pub const UV_TTY_MODE_NORMAL: c_int = 0;
pub const UV_TTY_MODE_RAW: c_int = 1;
pub const UV_TTY_MODE_IO: c_int = 2;
pub const uv_tty_mode_t = c_uint;
pub const UV_TTY_SUPPORTED: c_int = 0;
pub const UV_TTY_UNSUPPORTED: c_int = 1;
pub const uv_tty_vtermstate_t = c_uint;
pub extern fn uv_tty_init([*c]uv_loop_t, [*c]uv_tty_t, fd: uv_file, readable: c_int) c_int;
pub extern fn uv_tty_set_mode([*c]uv_tty_t, mode: uv_tty_mode_t) c_int;
pub extern fn uv_tty_reset_mode() c_int;
pub extern fn uv_tty_get_winsize([*c]uv_tty_t, width: [*c]c_int, height: [*c]c_int) c_int;
pub extern fn uv_tty_set_vterm_state(state: uv_tty_vtermstate_t) void;
pub extern fn uv_tty_get_vterm_state(state: [*c]uv_tty_vtermstate_t) c_int;
pub extern fn uv_guess_handle(file: uv_file) uv_handle_type;
pub extern fn uv_pipe_init([*c]uv_loop_t, handle: [*c]uv_pipe_t, ipc: c_int) c_int;
pub extern fn uv_pipe_open([*c]uv_pipe_t, file: uv_file) c_int;
pub extern fn uv_pipe_bind(handle: [*c]uv_pipe_t, name: [*c]const u8) c_int;
pub extern fn uv_pipe_connect(req: [*c]uv_connect_t, handle: [*c]uv_pipe_t, name: [*c]const u8, cb: uv_connect_cb) void;
pub extern fn uv_pipe_getsockname(handle: [*c]const uv_pipe_t, buffer: [*c]u8, size: [*c]usize) c_int;
pub extern fn uv_pipe_getpeername(handle: [*c]const uv_pipe_t, buffer: [*c]u8, size: [*c]usize) c_int;
pub extern fn uv_pipe_pending_instances(handle: [*c]uv_pipe_t, count: c_int) void;
pub extern fn uv_pipe_pending_count(handle: [*c]uv_pipe_t) c_int;
pub extern fn uv_pipe_pending_type(handle: [*c]uv_pipe_t) uv_handle_type;
pub extern fn uv_pipe_chmod(handle: [*c]uv_pipe_t, flags: c_int) c_int;
pub const UV_READABLE: c_int = 1;
pub const UV_WRITABLE: c_int = 2;
pub const UV_DISCONNECT: c_int = 4;
pub const UV_PRIORITIZED: c_int = 8;
pub const enum_uv_poll_event = c_uint;
pub extern fn uv_poll_init(loop: [*c]uv_loop_t, handle: [*c]uv_poll_t, fd: c_int) c_int;
pub extern fn uv_poll_init_socket(loop: [*c]uv_loop_t, handle: [*c]uv_poll_t, socket: uv_os_sock_t) c_int;
pub extern fn uv_poll_start(handle: [*c]uv_poll_t, events: c_int, cb: uv_poll_cb) c_int;
pub extern fn uv_poll_stop(handle: [*c]uv_poll_t) c_int;
pub extern fn uv_prepare_init([*c]uv_loop_t, prepare: [*c]uv_prepare_t) c_int;
pub extern fn uv_prepare_start(prepare: [*c]uv_prepare_t, cb: uv_prepare_cb) c_int;
pub extern fn uv_prepare_stop(prepare: [*c]uv_prepare_t) c_int;
pub extern fn uv_check_init([*c]uv_loop_t, check: [*c]uv_check_t) c_int;
pub extern fn uv_check_start(check: [*c]uv_check_t, cb: uv_check_cb) c_int;
pub extern fn uv_check_stop(check: [*c]uv_check_t) c_int;
pub extern fn uv_idle_init([*c]uv_loop_t, idle: [*c]uv_idle_t) c_int;
pub extern fn uv_idle_start(idle: [*c]uv_idle_t, cb: uv_idle_cb) c_int;
pub extern fn uv_idle_stop(idle: [*c]uv_idle_t) c_int;
pub extern fn uv_async_init([*c]uv_loop_t, @"async": [*c]uv_async_t, async_cb: uv_async_cb) c_int;
pub extern fn uv_async_send(@"async": [*c]uv_async_t) c_int;
pub extern fn uv_timer_init([*c]uv_loop_t, handle: [*c]uv_timer_t) c_int;
pub extern fn uv_timer_start(handle: [*c]uv_timer_t, cb: uv_timer_cb, timeout: u64, repeat: u64) c_int;
pub extern fn uv_timer_stop(handle: [*c]uv_timer_t) c_int;
pub extern fn uv_timer_again(handle: [*c]uv_timer_t) c_int;
pub extern fn uv_timer_set_repeat(handle: [*c]uv_timer_t, repeat: u64) void;
pub extern fn uv_timer_get_repeat(handle: [*c]const uv_timer_t) u64;
pub extern fn uv_timer_get_due_in(handle: [*c]const uv_timer_t) u64;
pub extern fn uv_getaddrinfo(loop: [*c]uv_loop_t, req: [*c]uv_getaddrinfo_t, getaddrinfo_cb: uv_getaddrinfo_cb, node: [*c]const u8, service: [*c]const u8, hints: [*c]const struct_addrinfo) c_int;
pub extern fn uv_freeaddrinfo(ai: [*c]struct_addrinfo) void;
pub extern fn uv_getnameinfo(loop: [*c]uv_loop_t, req: [*c]uv_getnameinfo_t, getnameinfo_cb: uv_getnameinfo_cb, addr: [*c]const struct_sockaddr, flags: c_int) c_int;
pub const UV_IGNORE: c_int = 0;
pub const UV_CREATE_PIPE: c_int = 1;
pub const UV_INHERIT_FD: c_int = 2;
pub const UV_INHERIT_STREAM: c_int = 4;
pub const UV_READABLE_PIPE: c_int = 16;
pub const UV_WRITABLE_PIPE: c_int = 32;
pub const UV_NONBLOCK_PIPE: c_int = 64;
pub const UV_OVERLAPPED_PIPE: c_int = 64;
pub const uv_stdio_flags = c_uint;
const union_unnamed_30 = extern union {
    stream: [*c]uv_stream_t,
    fd: c_int,
};
pub const struct_uv_stdio_container_s = extern struct {
    flags: uv_stdio_flags,
    data: union_unnamed_30,
};
pub const uv_stdio_container_t = struct_uv_stdio_container_s;
pub const struct_uv_process_options_s = extern struct {
    exit_cb: uv_exit_cb,
    file: [*c]const u8,
    args: [*c][*c]u8,
    env: [*c][*c]u8,
    cwd: [*c]const u8,
    flags: c_uint,
    stdio_count: c_int,
    stdio: [*c]uv_stdio_container_t,
    uid: uv_uid_t,
    gid: uv_gid_t,
};
pub const uv_process_options_t = struct_uv_process_options_s;
pub const UV_PROCESS_SETUID: c_int = 1;
pub const UV_PROCESS_SETGID: c_int = 2;
pub const UV_PROCESS_WINDOWS_VERBATIM_ARGUMENTS: c_int = 4;
pub const UV_PROCESS_DETACHED: c_int = 8;
pub const UV_PROCESS_WINDOWS_HIDE: c_int = 16;
pub const UV_PROCESS_WINDOWS_HIDE_CONSOLE: c_int = 32;
pub const UV_PROCESS_WINDOWS_HIDE_GUI: c_int = 64;
pub const enum_uv_process_flags = c_uint;
pub extern fn uv_spawn(loop: [*c]uv_loop_t, handle: [*c]uv_process_t, options: [*c]const uv_process_options_t) c_int;
pub extern fn uv_process_kill([*c]uv_process_t, signum: c_int) c_int;
pub extern fn uv_kill(pid: c_int, signum: c_int) c_int;
pub extern fn uv_process_get_pid([*c]const uv_process_t) uv_pid_t;
pub extern fn uv_queue_work(loop: [*c]uv_loop_t, req: [*c]uv_work_t, work_cb: uv_work_cb, after_work_cb: uv_after_work_cb) c_int;
pub extern fn uv_cancel(req: [*c]uv_req_t) c_int;
pub const UV_DIRENT_UNKNOWN: c_int = 0;
pub const UV_DIRENT_FILE: c_int = 1;
pub const UV_DIRENT_DIR: c_int = 2;
pub const UV_DIRENT_LINK: c_int = 3;
pub const UV_DIRENT_FIFO: c_int = 4;
pub const UV_DIRENT_SOCKET: c_int = 5;
pub const UV_DIRENT_CHAR: c_int = 6;
pub const UV_DIRENT_BLOCK: c_int = 7;
pub const uv_dirent_type_t = c_uint;
pub extern fn uv_setup_args(argc: c_int, argv: [*c][*c]u8) [*c][*c]u8;
pub extern fn uv_get_process_title(buffer: [*c]u8, size: usize) c_int;
pub extern fn uv_set_process_title(title: [*c]const u8) c_int;
pub extern fn uv_resident_set_memory(rss: [*c]usize) c_int;
pub extern fn uv_uptime(uptime: [*c]f64) c_int;
pub extern fn uv_get_osfhandle(fd: c_int) uv_os_fd_t;
pub extern fn uv_open_osfhandle(os_fd: uv_os_fd_t) c_int;
pub const uv_timeval_t = extern struct {
    tv_sec: c_long,
    tv_usec: c_long,
};
pub const uv_timeval64_t = extern struct {
    tv_sec: i64,
    tv_usec: i32,
};
pub const uv_rusage_t = extern struct {
    ru_utime: uv_timeval_t,
    ru_stime: uv_timeval_t,
    ru_maxrss: u64,
    ru_ixrss: u64,
    ru_idrss: u64,
    ru_isrss: u64,
    ru_minflt: u64,
    ru_majflt: u64,
    ru_nswap: u64,
    ru_inblock: u64,
    ru_oublock: u64,
    ru_msgsnd: u64,
    ru_msgrcv: u64,
    ru_nsignals: u64,
    ru_nvcsw: u64,
    ru_nivcsw: u64,
};
pub extern fn uv_getrusage(rusage: [*c]uv_rusage_t) c_int;
pub extern fn uv_os_homedir(buffer: [*c]u8, size: [*c]usize) c_int;
pub extern fn uv_os_tmpdir(buffer: [*c]u8, size: [*c]usize) c_int;
pub extern fn uv_os_get_passwd(pwd: [*c]uv_passwd_t) c_int;
pub extern fn uv_os_free_passwd(pwd: [*c]uv_passwd_t) void;
pub extern fn uv_os_getpid() uv_pid_t;
pub extern fn uv_os_getppid() uv_pid_t;
pub extern fn uv_os_getpriority(pid: uv_pid_t, priority: [*c]c_int) c_int;
pub extern fn uv_os_setpriority(pid: uv_pid_t, priority: c_int) c_int;
pub extern fn uv_available_parallelism() c_uint;
pub extern fn uv_cpu_info(cpu_infos: [*c][*c]uv_cpu_info_t, count: [*c]c_int) c_int;
pub extern fn uv_free_cpu_info(cpu_infos: [*c]uv_cpu_info_t, count: c_int) void;
pub extern fn uv_interface_addresses(addresses: [*c][*c]uv_interface_address_t, count: [*c]c_int) c_int;
pub extern fn uv_free_interface_addresses(addresses: [*c]uv_interface_address_t, count: c_int) void;
pub extern fn uv_os_environ(envitems: [*c][*c]uv_env_item_t, count: [*c]c_int) c_int;
pub extern fn uv_os_free_environ(envitems: [*c]uv_env_item_t, count: c_int) void;
pub extern fn uv_os_getenv(name: [*c]const u8, buffer: [*c]u8, size: [*c]usize) c_int;
pub extern fn uv_os_setenv(name: [*c]const u8, value: [*c]const u8) c_int;
pub extern fn uv_os_unsetenv(name: [*c]const u8) c_int;
pub extern fn uv_os_gethostname(buffer: [*c]u8, size: [*c]usize) c_int;
pub extern fn uv_os_uname(buffer: [*c]uv_utsname_t) c_int;
pub extern fn uv_metrics_idle_time(loop: [*c]uv_loop_t) u64;
pub const UV_FS_UNKNOWN: c_int = -1;
pub const UV_FS_CUSTOM: c_int = 0;
pub const UV_FS_OPEN: c_int = 1;
pub const UV_FS_CLOSE: c_int = 2;
pub const UV_FS_READ: c_int = 3;
pub const UV_FS_WRITE: c_int = 4;
pub const UV_FS_SENDFILE: c_int = 5;
pub const UV_FS_STAT: c_int = 6;
pub const UV_FS_LSTAT: c_int = 7;
pub const UV_FS_FSTAT: c_int = 8;
pub const UV_FS_FTRUNCATE: c_int = 9;
pub const UV_FS_UTIME: c_int = 10;
pub const UV_FS_FUTIME: c_int = 11;
pub const UV_FS_ACCESS: c_int = 12;
pub const UV_FS_CHMOD: c_int = 13;
pub const UV_FS_FCHMOD: c_int = 14;
pub const UV_FS_FSYNC: c_int = 15;
pub const UV_FS_FDATASYNC: c_int = 16;
pub const UV_FS_UNLINK: c_int = 17;
pub const UV_FS_RMDIR: c_int = 18;
pub const UV_FS_MKDIR: c_int = 19;
pub const UV_FS_MKDTEMP: c_int = 20;
pub const UV_FS_RENAME: c_int = 21;
pub const UV_FS_SCANDIR: c_int = 22;
pub const UV_FS_LINK: c_int = 23;
pub const UV_FS_SYMLINK: c_int = 24;
pub const UV_FS_READLINK: c_int = 25;
pub const UV_FS_CHOWN: c_int = 26;
pub const UV_FS_FCHOWN: c_int = 27;
pub const UV_FS_REALPATH: c_int = 28;
pub const UV_FS_COPYFILE: c_int = 29;
pub const UV_FS_LCHOWN: c_int = 30;
pub const UV_FS_OPENDIR: c_int = 31;
pub const UV_FS_READDIR: c_int = 32;
pub const UV_FS_CLOSEDIR: c_int = 33;
pub const UV_FS_STATFS: c_int = 34;
pub const UV_FS_MKSTEMP: c_int = 35;
pub const UV_FS_LUTIME: c_int = 36;
pub const uv_fs_type = c_int;
pub extern fn uv_fs_get_type([*c]const uv_fs_t) uv_fs_type;
pub extern fn uv_fs_get_result([*c]const uv_fs_t) isize;
pub extern fn uv_fs_get_system_error([*c]const uv_fs_t) c_int;
pub extern fn uv_fs_get_ptr([*c]const uv_fs_t) ?*anyopaque;
pub extern fn uv_fs_get_path([*c]const uv_fs_t) [*c]const u8;
pub extern fn uv_fs_get_statbuf([*c]uv_fs_t) [*c]uv_stat_t;
pub extern fn uv_fs_req_cleanup(req: [*c]uv_fs_t) void;
pub extern fn uv_fs_close(loop: [*c]uv_loop_t, req: [*c]uv_fs_t, file: uv_file, cb: uv_fs_cb) c_int;
pub extern fn uv_fs_open(loop: [*c]uv_loop_t, req: [*c]uv_fs_t, path: [*c]const u8, flags: c_int, mode: c_int, cb: uv_fs_cb) c_int;
pub extern fn uv_fs_read(loop: [*c]uv_loop_t, req: [*c]uv_fs_t, file: uv_file, bufs: [*c]const uv_buf_t, nbufs: c_uint, offset: i64, cb: uv_fs_cb) c_int;
pub extern fn uv_fs_unlink(loop: [*c]uv_loop_t, req: [*c]uv_fs_t, path: [*c]const u8, cb: uv_fs_cb) c_int;
pub extern fn uv_fs_write(loop: [*c]uv_loop_t, req: [*c]uv_fs_t, file: uv_file, bufs: [*c]const uv_buf_t, nbufs: c_uint, offset: i64, cb: uv_fs_cb) c_int;
pub extern fn uv_fs_copyfile(loop: [*c]uv_loop_t, req: [*c]uv_fs_t, path: [*c]const u8, new_path: [*c]const u8, flags: c_int, cb: uv_fs_cb) c_int;
pub extern fn uv_fs_mkdir(loop: [*c]uv_loop_t, req: [*c]uv_fs_t, path: [*c]const u8, mode: c_int, cb: uv_fs_cb) c_int;
pub extern fn uv_fs_mkdtemp(loop: [*c]uv_loop_t, req: [*c]uv_fs_t, tpl: [*c]const u8, cb: uv_fs_cb) c_int;
pub extern fn uv_fs_mkstemp(loop: [*c]uv_loop_t, req: [*c]uv_fs_t, tpl: [*c]const u8, cb: uv_fs_cb) c_int;
pub extern fn uv_fs_rmdir(loop: [*c]uv_loop_t, req: [*c]uv_fs_t, path: [*c]const u8, cb: uv_fs_cb) c_int;
pub extern fn uv_fs_scandir(loop: [*c]uv_loop_t, req: [*c]uv_fs_t, path: [*c]const u8, flags: c_int, cb: uv_fs_cb) c_int;
pub extern fn uv_fs_scandir_next(req: [*c]uv_fs_t, ent: [*c]uv_dirent_t) c_int;
pub extern fn uv_fs_opendir(loop: [*c]uv_loop_t, req: [*c]uv_fs_t, path: [*c]const u8, cb: uv_fs_cb) c_int;
pub extern fn uv_fs_readdir(loop: [*c]uv_loop_t, req: [*c]uv_fs_t, dir: [*c]uv_dir_t, cb: uv_fs_cb) c_int;
pub extern fn uv_fs_closedir(loop: [*c]uv_loop_t, req: [*c]uv_fs_t, dir: [*c]uv_dir_t, cb: uv_fs_cb) c_int;
pub extern fn uv_fs_stat(loop: [*c]uv_loop_t, req: [*c]uv_fs_t, path: [*c]const u8, cb: uv_fs_cb) c_int;
pub extern fn uv_fs_fstat(loop: [*c]uv_loop_t, req: [*c]uv_fs_t, file: uv_file, cb: uv_fs_cb) c_int;
pub extern fn uv_fs_rename(loop: [*c]uv_loop_t, req: [*c]uv_fs_t, path: [*c]const u8, new_path: [*c]const u8, cb: uv_fs_cb) c_int;
pub extern fn uv_fs_fsync(loop: [*c]uv_loop_t, req: [*c]uv_fs_t, file: uv_file, cb: uv_fs_cb) c_int;
pub extern fn uv_fs_fdatasync(loop: [*c]uv_loop_t, req: [*c]uv_fs_t, file: uv_file, cb: uv_fs_cb) c_int;
pub extern fn uv_fs_ftruncate(loop: [*c]uv_loop_t, req: [*c]uv_fs_t, file: uv_file, offset: i64, cb: uv_fs_cb) c_int;
pub extern fn uv_fs_sendfile(loop: [*c]uv_loop_t, req: [*c]uv_fs_t, out_fd: uv_file, in_fd: uv_file, in_offset: i64, length: usize, cb: uv_fs_cb) c_int;
pub extern fn uv_fs_access(loop: [*c]uv_loop_t, req: [*c]uv_fs_t, path: [*c]const u8, mode: c_int, cb: uv_fs_cb) c_int;
pub extern fn uv_fs_chmod(loop: [*c]uv_loop_t, req: [*c]uv_fs_t, path: [*c]const u8, mode: c_int, cb: uv_fs_cb) c_int;
pub extern fn uv_fs_utime(loop: [*c]uv_loop_t, req: [*c]uv_fs_t, path: [*c]const u8, atime: f64, mtime: f64, cb: uv_fs_cb) c_int;
pub extern fn uv_fs_futime(loop: [*c]uv_loop_t, req: [*c]uv_fs_t, file: uv_file, atime: f64, mtime: f64, cb: uv_fs_cb) c_int;
pub extern fn uv_fs_lutime(loop: [*c]uv_loop_t, req: [*c]uv_fs_t, path: [*c]const u8, atime: f64, mtime: f64, cb: uv_fs_cb) c_int;
pub extern fn uv_fs_lstat(loop: [*c]uv_loop_t, req: [*c]uv_fs_t, path: [*c]const u8, cb: uv_fs_cb) c_int;
pub extern fn uv_fs_link(loop: [*c]uv_loop_t, req: [*c]uv_fs_t, path: [*c]const u8, new_path: [*c]const u8, cb: uv_fs_cb) c_int;
pub extern fn uv_fs_symlink(loop: [*c]uv_loop_t, req: [*c]uv_fs_t, path: [*c]const u8, new_path: [*c]const u8, flags: c_int, cb: uv_fs_cb) c_int;
pub extern fn uv_fs_readlink(loop: [*c]uv_loop_t, req: [*c]uv_fs_t, path: [*c]const u8, cb: uv_fs_cb) c_int;
pub extern fn uv_fs_realpath(loop: [*c]uv_loop_t, req: [*c]uv_fs_t, path: [*c]const u8, cb: uv_fs_cb) c_int;
pub extern fn uv_fs_fchmod(loop: [*c]uv_loop_t, req: [*c]uv_fs_t, file: uv_file, mode: c_int, cb: uv_fs_cb) c_int;
pub extern fn uv_fs_chown(loop: [*c]uv_loop_t, req: [*c]uv_fs_t, path: [*c]const u8, uid: uv_uid_t, gid: uv_gid_t, cb: uv_fs_cb) c_int;
pub extern fn uv_fs_fchown(loop: [*c]uv_loop_t, req: [*c]uv_fs_t, file: uv_file, uid: uv_uid_t, gid: uv_gid_t, cb: uv_fs_cb) c_int;
pub extern fn uv_fs_lchown(loop: [*c]uv_loop_t, req: [*c]uv_fs_t, path: [*c]const u8, uid: uv_uid_t, gid: uv_gid_t, cb: uv_fs_cb) c_int;
pub extern fn uv_fs_statfs(loop: [*c]uv_loop_t, req: [*c]uv_fs_t, path: [*c]const u8, cb: uv_fs_cb) c_int;
pub const UV_RENAME: c_int = 1;
pub const UV_CHANGE: c_int = 2;
pub const enum_uv_fs_event = c_uint;
pub extern fn uv_fs_poll_init(loop: [*c]uv_loop_t, handle: [*c]uv_fs_poll_t) c_int;
pub extern fn uv_fs_poll_start(handle: [*c]uv_fs_poll_t, poll_cb: uv_fs_poll_cb, path: [*c]const u8, interval: c_uint) c_int;
pub extern fn uv_fs_poll_stop(handle: [*c]uv_fs_poll_t) c_int;
pub extern fn uv_fs_poll_getpath(handle: [*c]uv_fs_poll_t, buffer: [*c]u8, size: [*c]usize) c_int;
pub extern fn uv_signal_init(loop: [*c]uv_loop_t, handle: [*c]uv_signal_t) c_int;
pub extern fn uv_signal_start(handle: [*c]uv_signal_t, signal_cb: uv_signal_cb, signum: c_int) c_int;
pub extern fn uv_signal_start_oneshot(handle: [*c]uv_signal_t, signal_cb: uv_signal_cb, signum: c_int) c_int;
pub extern fn uv_signal_stop(handle: [*c]uv_signal_t) c_int;
pub extern fn uv_loadavg(avg: [*c]f64) void;
pub const UV_FS_EVENT_WATCH_ENTRY: c_int = 1;
pub const UV_FS_EVENT_STAT: c_int = 2;
pub const UV_FS_EVENT_RECURSIVE: c_int = 4;
pub const enum_uv_fs_event_flags = c_uint;
pub extern fn uv_fs_event_init(loop: [*c]uv_loop_t, handle: [*c]uv_fs_event_t) c_int;
pub extern fn uv_fs_event_start(handle: [*c]uv_fs_event_t, cb: uv_fs_event_cb, path: [*c]const u8, flags: c_uint) c_int;
pub extern fn uv_fs_event_stop(handle: [*c]uv_fs_event_t) c_int;
pub extern fn uv_fs_event_getpath(handle: [*c]uv_fs_event_t, buffer: [*c]u8, size: [*c]usize) c_int;
pub extern fn uv_ip4_addr(ip: [*c]const u8, port: c_int, addr: [*c]struct_sockaddr_in) c_int;
pub extern fn uv_ip6_addr(ip: [*c]const u8, port: c_int, addr: [*c]struct_sockaddr_in6) c_int;
pub extern fn uv_ip4_name(src: [*c]const struct_sockaddr_in, dst: [*c]u8, size: usize) c_int;
pub extern fn uv_ip6_name(src: [*c]const struct_sockaddr_in6, dst: [*c]u8, size: usize) c_int;
pub extern fn uv_ip_name(src: [*c]const struct_sockaddr, dst: [*c]u8, size: usize) c_int;
pub extern fn uv_inet_ntop(af: c_int, src: ?*const anyopaque, dst: [*c]u8, size: usize) c_int;
pub extern fn uv_inet_pton(af: c_int, src: [*c]const u8, dst: ?*anyopaque) c_int;
pub extern fn uv_random(loop: [*c]uv_loop_t, req: [*c]uv_random_t, buf: ?*anyopaque, buflen: usize, flags: c_uint, cb: uv_random_cb) c_int;
pub extern fn uv_if_indextoname(ifindex: c_uint, buffer: [*c]u8, size: [*c]usize) c_int;
pub extern fn uv_if_indextoiid(ifindex: c_uint, buffer: [*c]u8, size: [*c]usize) c_int;
pub extern fn uv_exepath(buffer: [*c]u8, size: [*c]usize) c_int;
pub extern fn uv_cwd(buffer: [*c]u8, size: [*c]usize) c_int;
pub extern fn uv_chdir(dir: [*c]const u8) c_int;
pub extern fn uv_get_free_memory() u64;
pub extern fn uv_get_total_memory() u64;
pub extern fn uv_get_constrained_memory() u64;
pub extern fn uv_hrtime() u64;
pub extern fn uv_sleep(msec: c_uint) void;
pub extern fn uv_disable_stdio_inheritance() void;
pub extern fn uv_dlopen(filename: [*c]const u8, lib: [*c]uv_lib_t) c_int;
pub extern fn uv_dlclose(lib: [*c]uv_lib_t) void;
pub extern fn uv_dlsym(lib: [*c]uv_lib_t, name: [*c]const u8, ptr: [*c]?*anyopaque) c_int;
pub extern fn uv_dlerror(lib: [*c]const uv_lib_t) [*c]const u8;
pub extern fn uv_mutex_init(handle: [*c]uv_mutex_t) c_int;
pub extern fn uv_mutex_init_recursive(handle: [*c]uv_mutex_t) c_int;
pub extern fn uv_mutex_destroy(handle: [*c]uv_mutex_t) void;
pub extern fn uv_mutex_lock(handle: [*c]uv_mutex_t) void;
pub extern fn uv_mutex_trylock(handle: [*c]uv_mutex_t) c_int;
pub extern fn uv_mutex_unlock(handle: [*c]uv_mutex_t) void;
pub extern fn uv_rwlock_init(rwlock: [*c]uv_rwlock_t) c_int;
pub extern fn uv_rwlock_destroy(rwlock: [*c]uv_rwlock_t) void;
pub extern fn uv_rwlock_rdlock(rwlock: [*c]uv_rwlock_t) void;
pub extern fn uv_rwlock_tryrdlock(rwlock: [*c]uv_rwlock_t) c_int;
pub extern fn uv_rwlock_rdunlock(rwlock: [*c]uv_rwlock_t) void;
pub extern fn uv_rwlock_wrlock(rwlock: [*c]uv_rwlock_t) void;
pub extern fn uv_rwlock_trywrlock(rwlock: [*c]uv_rwlock_t) c_int;
pub extern fn uv_rwlock_wrunlock(rwlock: [*c]uv_rwlock_t) void;
pub extern fn uv_sem_init(sem: [*c]uv_sem_t, value: c_uint) c_int;
pub extern fn uv_sem_destroy(sem: [*c]uv_sem_t) void;
pub extern fn uv_sem_post(sem: [*c]uv_sem_t) void;
pub extern fn uv_sem_wait(sem: [*c]uv_sem_t) void;
pub extern fn uv_sem_trywait(sem: [*c]uv_sem_t) c_int;
pub extern fn uv_cond_init(cond: [*c]uv_cond_t) c_int;
pub extern fn uv_cond_destroy(cond: [*c]uv_cond_t) void;
pub extern fn uv_cond_signal(cond: [*c]uv_cond_t) void;
pub extern fn uv_cond_broadcast(cond: [*c]uv_cond_t) void;
pub extern fn uv_barrier_init(barrier: [*c]uv_barrier_t, count: c_uint) c_int;
pub extern fn uv_barrier_destroy(barrier: [*c]uv_barrier_t) void;
pub extern fn uv_barrier_wait(barrier: [*c]uv_barrier_t) c_int;
pub extern fn uv_cond_wait(cond: [*c]uv_cond_t, mutex: [*c]uv_mutex_t) void;
pub extern fn uv_cond_timedwait(cond: [*c]uv_cond_t, mutex: [*c]uv_mutex_t, timeout: u64) c_int;
pub extern fn uv_once(guard: [*c]uv_once_t, callback: ?*const fn () callconv(.C) void) void;
pub extern fn uv_key_create(key: [*c]uv_key_t) c_int;
pub extern fn uv_key_delete(key: [*c]uv_key_t) void;
pub extern fn uv_key_get(key: [*c]uv_key_t) ?*anyopaque;
pub extern fn uv_key_set(key: [*c]uv_key_t, value: ?*anyopaque) void;
pub extern fn uv_gettimeofday(tv: [*c]uv_timeval64_t) c_int;
pub const uv_thread_cb = ?*const fn (?*anyopaque) callconv(.C) void;
pub extern fn uv_thread_create(tid: [*c]uv_thread_t, entry: uv_thread_cb, arg: ?*anyopaque) c_int;
pub const UV_THREAD_NO_FLAGS: c_int = 0;
pub const UV_THREAD_HAS_STACK_SIZE: c_int = 1;
pub const uv_thread_create_flags = c_uint;
pub const struct_uv_thread_options_s = extern struct {
    flags: c_uint,
    stack_size: usize,
};
pub const uv_thread_options_t = struct_uv_thread_options_s;
pub extern fn uv_thread_create_ex(tid: [*c]uv_thread_t, params: [*c]const uv_thread_options_t, entry: uv_thread_cb, arg: ?*anyopaque) c_int;
pub extern fn uv_thread_self() uv_thread_t;
pub extern fn uv_thread_join(tid: [*c]uv_thread_t) c_int;
pub extern fn uv_thread_equal(t1: [*c]const uv_thread_t, t2: [*c]const uv_thread_t) c_int;
pub const union_uv_any_handle = extern union {
    @"async": uv_async_t,
    check: uv_check_t,
    fs_event: uv_fs_event_t,
    fs_poll: uv_fs_poll_t,
    handle: uv_handle_t,
    idle: uv_idle_t,
    pipe: uv_pipe_t,
    poll: uv_poll_t,
    prepare: uv_prepare_t,
    process: uv_process_t,
    stream: uv_stream_t,
    tcp: uv_tcp_t,
    timer: uv_timer_t,
    tty: uv_tty_t,
    udp: uv_udp_t,
    signal: uv_signal_t,
};
pub const union_uv_any_req = extern union {
    req: uv_req_t,
    connect: uv_connect_t,
    write: uv_write_t,
    shutdown: uv_shutdown_t,
    udp_send: uv_udp_send_t,
    fs: uv_fs_t,
    work: uv_work_t,
    getaddrinfo: uv_getaddrinfo_t,
    getnameinfo: uv_getnameinfo_t,
    random: uv_random_t,
};
pub extern fn uv_loop_get_data([*c]const uv_loop_t) ?*anyopaque;
pub extern fn uv_loop_set_data([*c]uv_loop_t, data: ?*anyopaque) void;
pub extern fn init_tcp(loop: [*c]uv_loop_t, tcp: [*c]uv_tcp_t) c_int;
pub const __INTMAX_C_SUFFIX__ = @compileError("unable to translate macro: undefined identifier `LL`"); // (no file):80:9
pub const __UINTMAX_C_SUFFIX__ = @compileError("unable to translate macro: undefined identifier `ULL`"); // (no file):86:9
pub const __FLT16_DENORM_MIN__ = @compileError("unable to translate C expr: unexpected token 'IntegerLiteral'"); // (no file):109:9
pub const __FLT16_EPSILON__ = @compileError("unable to translate C expr: unexpected token 'IntegerLiteral'"); // (no file):113:9
pub const __FLT16_MAX__ = @compileError("unable to translate C expr: unexpected token 'IntegerLiteral'"); // (no file):119:9
pub const __FLT16_MIN__ = @compileError("unable to translate C expr: unexpected token 'IntegerLiteral'"); // (no file):122:9
pub const __INT64_C_SUFFIX__ = @compileError("unable to translate macro: undefined identifier `LL`"); // (no file):182:9
pub const __UINT32_C_SUFFIX__ = @compileError("unable to translate macro: undefined identifier `U`"); // (no file):204:9
pub const __UINT64_C_SUFFIX__ = @compileError("unable to translate macro: undefined identifier `ULL`"); // (no file):212:9
pub const __seg_gs = @compileError("unable to translate macro: undefined identifier `__attribute__`"); // (no file):341:9
pub const __seg_fs = @compileError("unable to translate macro: undefined identifier `__attribute__`"); // (no file):342:9
pub const UV_EXTERN = @compileError("unable to translate macro: undefined identifier `__attribute__`"); // /usr/local/include/uv.h:47:10
pub const __strong_alias = @compileError("unable to translate macro: undefined identifier `__asm__`"); // /usr/include/machine/cdefs.h:11:9
pub const __weak_alias = @compileError("unable to translate macro: undefined identifier `__asm__`"); // /usr/include/machine/cdefs.h:14:9
pub const __warn_references = @compileError("unable to translate macro: undefined identifier `__asm__`"); // /usr/include/machine/cdefs.h:17:9
pub const __CONCAT = @compileError("unable to translate C expr: unexpected token '##'"); // /usr/include/sys/cdefs.h:63:9
pub const __STRING = @compileError("unable to translate C expr: unexpected token '#'"); // /usr/include/sys/cdefs.h:64:9
pub const __const = @compileError("unable to translate C expr: unexpected token 'const'"); // /usr/include/sys/cdefs.h:66:9
pub const __volatile = @compileError("unable to translate C expr: unexpected token 'volatile'"); // /usr/include/sys/cdefs.h:68:9
pub const __dead = @compileError("unable to translate macro: undefined identifier `__attribute__`"); // /usr/include/sys/cdefs.h:106:9
pub const __pure = @compileError("unable to translate macro: undefined identifier `__attribute__`"); // /usr/include/sys/cdefs.h:107:9
pub const __unused = @compileError("unable to translate macro: undefined identifier `__attribute__`"); // /usr/include/sys/cdefs.h:111:9
pub const __used = @compileError("unable to translate macro: undefined identifier `__attribute__`"); // /usr/include/sys/cdefs.h:117:9
pub const __warn_unused_result = @compileError("unable to translate macro: undefined identifier `__attribute__`"); // /usr/include/sys/cdefs.h:123:10
pub const __bounded = @compileError("unable to translate C expr: unexpected token 'Eof'"); // /usr/include/sys/cdefs.h:131:10
pub const __returns_twice = @compileError("unable to translate macro: undefined identifier `__attribute__`"); // /usr/include/sys/cdefs.h:141:9
pub const __only_inline = @compileError("unable to translate macro: undefined identifier `__inline`"); // /usr/include/sys/cdefs.h:155:9
pub const __packed = @compileError("unable to translate macro: undefined identifier `__attribute__`"); // /usr/include/sys/cdefs.h:218:9
pub const __aligned = @compileError("unable to translate macro: undefined identifier `__attribute__`"); // /usr/include/sys/cdefs.h:219:9
pub const __malloc = @compileError("unable to translate macro: undefined identifier `__attribute__`"); // /usr/include/sys/cdefs.h:227:9
pub const __dso_public = @compileError("unable to translate macro: undefined identifier `__attribute__`"); // /usr/include/sys/cdefs.h:241:9
pub const __dso_hidden = @compileError("unable to translate macro: undefined identifier `__attribute__`"); // /usr/include/sys/cdefs.h:242:9
pub const __BEGIN_PUBLIC_DECLS = @compileError("unable to translate macro: undefined identifier `_Pragma`"); // /usr/include/sys/cdefs.h:243:9
pub const __END_PUBLIC_DECLS = @compileError("unable to translate macro: undefined identifier `_Pragma`"); // /usr/include/sys/cdefs.h:245:9
pub const __BEGIN_HIDDEN_DECLS = @compileError("unable to translate macro: undefined identifier `_Pragma`"); // /usr/include/sys/cdefs.h:246:9
pub const __END_HIDDEN_DECLS = @compileError("unable to translate macro: undefined identifier `_Pragma`"); // /usr/include/sys/cdefs.h:248:9
pub const offsetof = @compileError("unable to translate macro: undefined identifier `__builtin_offsetof`"); // /usr/local/lib/zig/include/stddef.h:111:9
pub const swap16_multi = @compileError("unable to translate macro: undefined identifier `__swap16_multi_n`"); // /usr/include/sys/endian.h:74:9
pub const NTOHL = @compileError("unable to translate C expr: unexpected token '='"); // /usr/include/sys/endian.h:102:9
pub const NTOHS = @compileError("unable to translate C expr: unexpected token '='"); // /usr/include/sys/endian.h:103:9
pub const HTONL = @compileError("unable to translate C expr: unexpected token '='"); // /usr/include/sys/endian.h:104:9
pub const HTONS = @compileError("unable to translate C expr: unexpected token '='"); // /usr/include/sys/endian.h:105:9
pub const __sgetc = @compileError("TODO unary inc/dec expr"); // /usr/include/stdio.h:390:9
pub const __sclearerr = @compileError("unable to translate C expr: expected ')' instead got '&='"); // /usr/include/stdio.h:400:9
pub const INT64_C = @compileError("unable to translate macro: undefined identifier `LL`"); // /usr/include/stdint.h:220:9
pub const UINT32_C = @compileError("unable to translate macro: undefined identifier `U`"); // /usr/include/stdint.h:224:9
pub const UINT64_C = @compileError("unable to translate macro: undefined identifier `ULL`"); // /usr/include/stdint.h:225:9
pub const INTMAX_C = @compileError("unable to translate macro: undefined identifier `LL`"); // /usr/include/stdint.h:228:9
pub const UINTMAX_C = @compileError("unable to translate macro: undefined identifier `ULL`"); // /usr/include/stdint.h:229:9
pub const FD_COPY = @compileError("unable to translate C expr: expected ')' instead got '='"); // /usr/include/sys/select.h:100:9
pub const FD_ZERO = @compileError("unable to translate macro: undefined identifier `_p`"); // /usr/include/sys/select.h:102:9
pub const TIMEVAL_TO_TIMESPEC = @compileError("unable to translate C expr: unexpected token 'do'"); // /usr/include/sys/time.h:63:9
pub const TIMESPEC_TO_TIMEVAL = @compileError("unable to translate C expr: unexpected token 'do'"); // /usr/include/sys/time.h:67:9
pub const timerclear = @compileError("unable to translate C expr: unexpected token '='"); // /usr/include/sys/time.h:85:9
pub const timercmp = @compileError("unable to translate C expr: expected ')' instead got 'Identifier'"); // /usr/include/sys/time.h:89:9
pub const timeradd = @compileError("unable to translate C expr: unexpected token 'do'"); // /usr/include/sys/time.h:93:9
pub const timersub = @compileError("unable to translate C expr: unexpected token 'do'"); // /usr/include/sys/time.h:102:9
pub const timespecclear = @compileError("unable to translate C expr: unexpected token '='"); // /usr/include/sys/time.h:113:9
pub const timespeccmp = @compileError("unable to translate C expr: expected ')' instead got 'Identifier'"); // /usr/include/sys/time.h:117:9
pub const timespecadd = @compileError("unable to translate C expr: unexpected token 'do'"); // /usr/include/sys/time.h:121:9
pub const timespecsub = @compileError("unable to translate C expr: unexpected token 'do'"); // /usr/include/sys/time.h:130:9
pub const st_atime = @compileError("unable to translate macro: undefined identifier `st_atim`"); // /usr/include/sys/stat.h:78:9
pub const st_mtime = @compileError("unable to translate macro: undefined identifier `st_mtim`"); // /usr/include/sys/stat.h:79:9
pub const st_ctime = @compileError("unable to translate macro: undefined identifier `st_ctim`"); // /usr/include/sys/stat.h:80:9
pub const __st_birthtime = @compileError("unable to translate macro: undefined identifier `__st_birthtim`"); // /usr/include/sys/stat.h:81:9
pub const st_atimespec = @compileError("unable to translate macro: undefined identifier `st_atim`"); // /usr/include/sys/stat.h:84:9
pub const st_atimensec = @compileError("unable to translate macro: undefined identifier `st_atim`"); // /usr/include/sys/stat.h:85:9
pub const st_mtimespec = @compileError("unable to translate macro: undefined identifier `st_mtim`"); // /usr/include/sys/stat.h:86:9
pub const st_mtimensec = @compileError("unable to translate macro: undefined identifier `st_mtim`"); // /usr/include/sys/stat.h:87:9
pub const st_ctimespec = @compileError("unable to translate macro: undefined identifier `st_ctim`"); // /usr/include/sys/stat.h:88:9
pub const st_ctimensec = @compileError("unable to translate macro: undefined identifier `st_ctim`"); // /usr/include/sys/stat.h:89:9
pub const __st_birthtimespec = @compileError("unable to translate macro: undefined identifier `__st_birthtim`"); // /usr/include/sys/stat.h:90:9
pub const __st_birthtimensec = @compileError("unable to translate macro: undefined identifier `__st_birthtim`"); // /usr/include/sys/stat.h:91:9
pub const d_ino = @compileError("unable to translate macro: undefined identifier `d_fileno`"); // /usr/include/dirent.h:56:9
pub const CTL_NET_NAMES = @compileError("unable to translate macro: undefined identifier `CTLTYPE_NODE`"); // /usr/include/sys/socket.h:316:9
pub const CTL_NET_RT_NAMES = @compileError("unable to translate macro: undefined identifier `CTLTYPE_STRUCT`"); // /usr/include/sys/socket.h:374:9
pub const CTL_NET_UNIX_NAMES = @compileError("unable to translate macro: undefined identifier `CTLTYPE_NODE`"); // /usr/include/sys/socket.h:392:9
pub const CTL_NET_UNIX_PROTO_NAMES = @compileError("unable to translate macro: undefined identifier `CTLTYPE_INT`"); // /usr/include/sys/socket.h:407:9
pub const CTL_NET_LINK_NAMES = @compileError("unable to translate macro: undefined identifier `CTLTYPE_NODE`"); // /usr/include/sys/socket.h:419:9
pub const CTL_NET_LINK_IFRXQ_NAMES = @compileError("unable to translate macro: undefined identifier `CTLTYPE_INT`"); // /usr/include/sys/socket.h:430:9
pub const CTL_NET_KEY_NAMES = @compileError("unable to translate macro: undefined identifier `CTLTYPE_STRUCT`"); // /usr/include/sys/socket.h:443:9
pub const CTL_NET_BPF_NAMES = @compileError("unable to translate macro: undefined identifier `CTLTYPE_INT`"); // /usr/include/sys/socket.h:456:9
pub const CTL_NET_PFLOW_NAMES = @compileError("unable to translate macro: undefined identifier `CTLTYPE_STRUCT`"); // /usr/include/sys/socket.h:468:9
pub const CTL_IPPROTO_NAMES = @compileError("unable to translate macro: undefined identifier `CTLTYPE_NODE`"); // /usr/include/netinet/in.h:395:9
pub const IPCTL_NAMES = @compileError("unable to translate macro: undefined identifier `CTLTYPE_INT`"); // /usr/include/netinet/in.h:702:9
pub const s6_addr = @compileError("unable to translate macro: undefined identifier `__u6_addr`"); // /usr/include/netinet6/in6.h:89:9
pub const IN6ADDR_ANY_INIT = @compileError("unable to translate C expr: unexpected token '{'"); // /usr/include/netinet6/in6.h:159:9
pub const IN6ADDR_LOOPBACK_INIT = @compileError("unable to translate C expr: unexpected token '{'"); // /usr/include/netinet6/in6.h:162:9
pub const IN6ADDR_NODELOCAL_ALLNODES_INIT = @compileError("unable to translate C expr: unexpected token '{'"); // /usr/include/netinet6/in6.h:165:9
pub const IN6ADDR_INTFACELOCAL_ALLNODES_INIT = @compileError("unable to translate C expr: unexpected token '{'"); // /usr/include/netinet6/in6.h:168:9
pub const IN6ADDR_LINKLOCAL_ALLNODES_INIT = @compileError("unable to translate C expr: unexpected token '{'"); // /usr/include/netinet6/in6.h:171:9
pub const IN6ADDR_LINKLOCAL_ALLROUTERS_INIT = @compileError("unable to translate C expr: unexpected token '{'"); // /usr/include/netinet6/in6.h:174:9
pub const IN6_ARE_ADDR_EQUAL = @compileError("unable to translate macro: undefined identifier `memcmp`"); // /usr/include/netinet6/in6.h:178:9
pub const IN6_IS_ADDR_UNSPECIFIED = @compileError("unable to translate C expr: unexpected token 'const'"); // /usr/include/netinet6/in6.h:198:9
pub const IN6_IS_ADDR_LOOPBACK = @compileError("unable to translate C expr: unexpected token 'const'"); // /usr/include/netinet6/in6.h:207:9
pub const IN6_IS_ADDR_V4COMPAT = @compileError("unable to translate C expr: unexpected token 'const'"); // /usr/include/netinet6/in6.h:216:9
pub const IN6_IS_ADDR_V4MAPPED = @compileError("unable to translate C expr: unexpected token 'const'"); // /usr/include/netinet6/in6.h:226:9
pub const CTL_IPV6PROTO_NAMES = @compileError("unable to translate macro: undefined identifier `CTLTYPE_NODE`"); // /usr/include/netinet6/in6.h:472:9
pub const IPV6CTL_NAMES = @compileError("unable to translate macro: undefined identifier `CTLTYPE_INT`"); // /usr/include/netinet6/in6.h:600:9
pub const th_reseqlen = @compileError("unable to translate macro: undefined identifier `th_urp`"); // /usr/include/netinet/tcp.h:74:9
pub const h_addr = @compileError("unable to translate macro: undefined identifier `h_addr_list`"); // /usr/include/netdb.h:114:9
pub const SIG_DFL = @compileError("unable to translate C expr: expected ')' instead got '('"); // /usr/include/sys/signal.h:97:9
pub const SIG_IGN = @compileError("unable to translate C expr: expected ')' instead got '('"); // /usr/include/sys/signal.h:98:9
pub const SIG_ERR = @compileError("unable to translate C expr: expected ')' instead got '('"); // /usr/include/sys/signal.h:99:9
pub const si_pid = @compileError("unable to translate macro: undefined identifier `_data`"); // /usr/include/sys/siginfo.h:175:9
pub const si_uid = @compileError("unable to translate macro: undefined identifier `_data`"); // /usr/include/sys/siginfo.h:176:9
pub const si_status = @compileError("unable to translate macro: undefined identifier `_data`"); // /usr/include/sys/siginfo.h:178:9
pub const si_stime = @compileError("unable to translate macro: undefined identifier `_data`"); // /usr/include/sys/siginfo.h:179:9
pub const si_utime = @compileError("unable to translate macro: undefined identifier `_data`"); // /usr/include/sys/siginfo.h:180:9
pub const si_value = @compileError("unable to translate macro: undefined identifier `_data`"); // /usr/include/sys/siginfo.h:181:9
pub const si_addr = @compileError("unable to translate macro: undefined identifier `_data`"); // /usr/include/sys/siginfo.h:182:9
pub const si_trapno = @compileError("unable to translate macro: undefined identifier `_data`"); // /usr/include/sys/siginfo.h:183:9
pub const si_fd = @compileError("unable to translate macro: undefined identifier `_data`"); // /usr/include/sys/siginfo.h:184:9
pub const si_band = @compileError("unable to translate macro: undefined identifier `_data`"); // /usr/include/sys/siginfo.h:185:9
pub const si_tstamp = @compileError("unable to translate macro: undefined identifier `_data`"); // /usr/include/sys/siginfo.h:187:9
pub const si_syscall = @compileError("unable to translate macro: undefined identifier `_data`"); // /usr/include/sys/siginfo.h:188:9
pub const si_nsysarg = @compileError("unable to translate macro: undefined identifier `_data`"); // /usr/include/sys/siginfo.h:189:9
pub const si_sysarg = @compileError("unable to translate macro: undefined identifier `_data`"); // /usr/include/sys/siginfo.h:190:9
pub const si_fault = @compileError("unable to translate macro: undefined identifier `_data`"); // /usr/include/sys/siginfo.h:191:9
pub const si_faddr = @compileError("unable to translate macro: undefined identifier `_data`"); // /usr/include/sys/siginfo.h:192:9
pub const si_mstate = @compileError("unable to translate macro: undefined identifier `_data`"); // /usr/include/sys/siginfo.h:193:9
pub const sa_handler = @compileError("unable to translate macro: undefined identifier `__sigaction_u`"); // /usr/include/sys/signal.h:122:9
pub const sa_sigaction = @compileError("unable to translate macro: undefined identifier `__sigaction_u`"); // /usr/include/sys/signal.h:123:9
pub const sv_onstack = @compileError("unable to translate macro: undefined identifier `sv_flags`"); // /usr/include/sys/signal.h:160:9
pub const _MACHINE = @compileError("unable to translate macro: undefined identifier `amd64`"); // /usr/include/machine/param.h:46:9
pub const _MACHINE_ARCH = @compileError("unable to translate macro: undefined identifier `amd64`"); // /usr/include/machine/param.h:48:9
pub const MID_MACHINE = @compileError("unable to translate macro: undefined identifier `MID_AMD64`"); // /usr/include/machine/param.h:50:9
pub const setbit = @compileError("unable to translate C expr: expected ')' instead got '|='"); // /usr/include/sys/param.h:179:9
pub const clrbit = @compileError("unable to translate C expr: expected ')' instead got '&='"); // /usr/include/sys/param.h:180:9
pub const nitems = @compileError("unable to translate C expr: unexpected token '('"); // /usr/include/sys/param.h:204:9
pub const PTHREAD_ONCE_INIT = @compileError("unable to translate C expr: unexpected token '{'"); // /usr/include/pthread.h:152:9
pub const UV_PLATFORM_FS_EVENT_FIELDS = @compileError("unable to translate macro: undefined identifier `event_watcher`"); // /usr/local/include/uv/bsd.h:25:9
pub const UV_IO_PRIVATE_PLATFORM_FIELDS = @compileError("unable to translate macro: undefined identifier `rcount`"); // /usr/local/include/uv/bsd.h:28:9
pub const UV_DIR_PRIVATE_FIELDS = @compileError("unable to translate macro: undefined identifier `dir`"); // /usr/local/include/uv/unix.h:171:9
pub const UV_LOOP_PRIVATE_FIELDS = @compileError("unable to translate macro: undefined identifier `flags`"); // /usr/local/include/uv/unix.h:221:9
pub const UV_WRITE_PRIVATE_FIELDS = @compileError("unable to translate macro: undefined identifier `queue`"); // /usr/local/include/uv/unix.h:260:9
pub const UV_CONNECT_PRIVATE_FIELDS = @compileError("unable to translate macro: undefined identifier `queue`"); // /usr/local/include/uv/unix.h:268:9
pub const UV_UDP_SEND_PRIVATE_FIELDS = @compileError("unable to translate macro: undefined identifier `queue`"); // /usr/local/include/uv/unix.h:273:9
pub const UV_HANDLE_PRIVATE_FIELDS = @compileError("unable to translate macro: undefined identifier `next_closing`"); // /usr/local/include/uv/unix.h:282:9
pub const UV_STREAM_PRIVATE_FIELDS = @compileError("unable to translate macro: undefined identifier `connect_req`"); // /usr/local/include/uv/unix.h:286:9
pub const UV_UDP_PRIVATE_FIELDS = @compileError("unable to translate macro: undefined identifier `alloc_cb`"); // /usr/local/include/uv/unix.h:300:9
pub const UV_PIPE_PRIVATE_FIELDS = @compileError("unable to translate macro: undefined identifier `pipe_fname`"); // /usr/local/include/uv/unix.h:307:9
pub const UV_POLL_PRIVATE_FIELDS = @compileError("unable to translate macro: undefined identifier `io_watcher`"); // /usr/local/include/uv/unix.h:310:9
pub const UV_PREPARE_PRIVATE_FIELDS = @compileError("unable to translate macro: undefined identifier `prepare_cb`"); // /usr/local/include/uv/unix.h:313:9
pub const UV_CHECK_PRIVATE_FIELDS = @compileError("unable to translate macro: undefined identifier `check_cb`"); // /usr/local/include/uv/unix.h:317:9
pub const UV_IDLE_PRIVATE_FIELDS = @compileError("unable to translate macro: undefined identifier `idle_cb`"); // /usr/local/include/uv/unix.h:321:9
pub const UV_ASYNC_PRIVATE_FIELDS = @compileError("unable to translate macro: undefined identifier `async_cb`"); // /usr/local/include/uv/unix.h:325:9
pub const UV_TIMER_PRIVATE_FIELDS = @compileError("unable to translate macro: undefined identifier `timer_cb`"); // /usr/local/include/uv/unix.h:330:9
pub const UV_GETADDRINFO_PRIVATE_FIELDS = @compileError("unable to translate macro: undefined identifier `work_req`"); // /usr/local/include/uv/unix.h:337:9
pub const UV_GETNAMEINFO_PRIVATE_FIELDS = @compileError("unable to translate macro: undefined identifier `work_req`"); // /usr/local/include/uv/unix.h:346:9
pub const UV_PROCESS_PRIVATE_FIELDS = @compileError("unable to translate macro: undefined identifier `queue`"); // /usr/local/include/uv/unix.h:355:9
pub const UV_FS_PRIVATE_FIELDS = @compileError("unable to translate macro: undefined identifier `new_path`"); // /usr/local/include/uv/unix.h:359:9
pub const UV_WORK_PRIVATE_FIELDS = @compileError("unable to translate macro: undefined identifier `work_req`"); // /usr/local/include/uv/unix.h:374:9
pub const UV_TTY_PRIVATE_FIELDS = @compileError("unable to translate macro: undefined identifier `orig_termios`"); // /usr/local/include/uv/unix.h:377:9
pub const UV_SIGNAL_PRIVATE_FIELDS = @compileError("unable to translate macro: undefined identifier `rbe_left`"); // /usr/local/include/uv/unix.h:381:9
pub const UV_FS_EVENT_PRIVATE_FIELDS = @compileError("unable to translate macro: undefined identifier `cb`"); // /usr/local/include/uv/unix.h:393:9
pub const UV_ERRNO_MAP = @compileError("unable to translate macro: undefined identifier `EAI_CANCELED`"); // /usr/local/include/uv.h:72:9
pub const UV_HANDLE_TYPE_MAP = @compileError("unable to translate macro: undefined identifier `ASYNC`"); // /usr/local/include/uv.h:156:9
pub const UV_REQ_TYPE_MAP = @compileError("unable to translate macro: undefined identifier `REQ`"); // /usr/local/include/uv.h:174:9
pub const XX = @compileError("unable to translate macro: undefined identifier `UV_`"); // /usr/local/include/uv.h:187:9
pub const UV_REQ_FIELDS = @compileError("unable to translate macro: undefined identifier `data`"); // /usr/local/include/uv.h:401:9
pub const UV_HANDLE_FIELDS = @compileError("unable to translate macro: undefined identifier `data`"); // /usr/local/include/uv.h:432:9
pub const UV_STREAM_FIELDS = @compileError("unable to translate macro: undefined identifier `write_queue_size`"); // /usr/local/include/uv.h:489:9
pub const __llvm__ = @as(c_int, 1);
pub const __clang__ = @as(c_int, 1);
pub const __clang_major__ = @as(c_int, 16);
pub const __clang_minor__ = @as(c_int, 0);
pub const __clang_patchlevel__ = @as(c_int, 6);
pub const __clang_version__ = "16.0.6 ";
pub const __GNUC__ = @as(c_int, 4);
pub const __GNUC_MINOR__ = @as(c_int, 2);
pub const __GNUC_PATCHLEVEL__ = @as(c_int, 1);
pub const __GXX_ABI_VERSION = @as(c_int, 1002);
pub const __ATOMIC_RELAXED = @as(c_int, 0);
pub const __ATOMIC_CONSUME = @as(c_int, 1);
pub const __ATOMIC_ACQUIRE = @as(c_int, 2);
pub const __ATOMIC_RELEASE = @as(c_int, 3);
pub const __ATOMIC_ACQ_REL = @as(c_int, 4);
pub const __ATOMIC_SEQ_CST = @as(c_int, 5);
pub const __OPENCL_MEMORY_SCOPE_WORK_ITEM = @as(c_int, 0);
pub const __OPENCL_MEMORY_SCOPE_WORK_GROUP = @as(c_int, 1);
pub const __OPENCL_MEMORY_SCOPE_DEVICE = @as(c_int, 2);
pub const __OPENCL_MEMORY_SCOPE_ALL_SVM_DEVICES = @as(c_int, 3);
pub const __OPENCL_MEMORY_SCOPE_SUB_GROUP = @as(c_int, 4);
pub const __PRAGMA_REDEFINE_EXTNAME = @as(c_int, 1);
pub const __VERSION__ = "Clang 16.0.6";
pub const __OBJC_BOOL_IS_BOOL = @as(c_int, 0);
pub const __CONSTANT_CFSTRINGS__ = @as(c_int, 1);
pub const __clang_literal_encoding__ = "UTF-8";
pub const __clang_wide_literal_encoding__ = "UTF-32";
pub const __ORDER_LITTLE_ENDIAN__ = @as(c_int, 1234);
pub const __ORDER_BIG_ENDIAN__ = @as(c_int, 4321);
pub const __ORDER_PDP_ENDIAN__ = @as(c_int, 3412);
pub const __BYTE_ORDER__ = __ORDER_LITTLE_ENDIAN__;
pub const __LITTLE_ENDIAN__ = @as(c_int, 1);
pub const _LP64 = @as(c_int, 1);
pub const __LP64__ = @as(c_int, 1);
pub const __CHAR_BIT__ = @as(c_int, 8);
pub const __BOOL_WIDTH__ = @as(c_int, 8);
pub const __SHRT_WIDTH__ = @as(c_int, 16);
pub const __INT_WIDTH__ = @as(c_int, 32);
pub const __LONG_WIDTH__ = @as(c_int, 64);
pub const __LLONG_WIDTH__ = @as(c_int, 64);
pub const __BITINT_MAXWIDTH__ = @import("std").zig.c_translation.promoteIntLiteral(c_int, 8388608, .decimal);
pub const __SCHAR_MAX__ = @as(c_int, 127);
pub const __SHRT_MAX__ = @as(c_int, 32767);
pub const __INT_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const __LONG_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_long, 9223372036854775807, .decimal);
pub const __LONG_LONG_MAX__ = @as(c_longlong, 9223372036854775807);
pub const __WCHAR_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const __WCHAR_WIDTH__ = @as(c_int, 32);
pub const __WINT_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const __WINT_WIDTH__ = @as(c_int, 32);
pub const __INTMAX_MAX__ = @as(c_longlong, 9223372036854775807);
pub const __INTMAX_WIDTH__ = @as(c_int, 64);
pub const __SIZE_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_ulong, 18446744073709551615, .decimal);
pub const __SIZE_WIDTH__ = @as(c_int, 64);
pub const __UINTMAX_MAX__ = @as(c_ulonglong, 18446744073709551615);
pub const __UINTMAX_WIDTH__ = @as(c_int, 64);
pub const __PTRDIFF_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_long, 9223372036854775807, .decimal);
pub const __PTRDIFF_WIDTH__ = @as(c_int, 64);
pub const __INTPTR_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_long, 9223372036854775807, .decimal);
pub const __INTPTR_WIDTH__ = @as(c_int, 64);
pub const __UINTPTR_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_ulong, 18446744073709551615, .decimal);
pub const __UINTPTR_WIDTH__ = @as(c_int, 64);
pub const __SIZEOF_DOUBLE__ = @as(c_int, 8);
pub const __SIZEOF_FLOAT__ = @as(c_int, 4);
pub const __SIZEOF_INT__ = @as(c_int, 4);
pub const __SIZEOF_LONG__ = @as(c_int, 8);
pub const __SIZEOF_LONG_DOUBLE__ = @as(c_int, 16);
pub const __SIZEOF_LONG_LONG__ = @as(c_int, 8);
pub const __SIZEOF_POINTER__ = @as(c_int, 8);
pub const __SIZEOF_SHORT__ = @as(c_int, 2);
pub const __SIZEOF_PTRDIFF_T__ = @as(c_int, 8);
pub const __SIZEOF_SIZE_T__ = @as(c_int, 8);
pub const __SIZEOF_WCHAR_T__ = @as(c_int, 4);
pub const __SIZEOF_WINT_T__ = @as(c_int, 4);
pub const __SIZEOF_INT128__ = @as(c_int, 16);
pub const __INTMAX_TYPE__ = c_longlong;
pub const __INTMAX_FMTd__ = "lld";
pub const __INTMAX_FMTi__ = "lli";
pub const __UINTMAX_TYPE__ = c_ulonglong;
pub const __UINTMAX_FMTo__ = "llo";
pub const __UINTMAX_FMTu__ = "llu";
pub const __UINTMAX_FMTx__ = "llx";
pub const __UINTMAX_FMTX__ = "llX";
pub const __PTRDIFF_TYPE__ = c_long;
pub const __PTRDIFF_FMTd__ = "ld";
pub const __PTRDIFF_FMTi__ = "li";
pub const __INTPTR_TYPE__ = c_long;
pub const __INTPTR_FMTd__ = "ld";
pub const __INTPTR_FMTi__ = "li";
pub const __SIZE_TYPE__ = c_ulong;
pub const __SIZE_FMTo__ = "lo";
pub const __SIZE_FMTu__ = "lu";
pub const __SIZE_FMTx__ = "lx";
pub const __SIZE_FMTX__ = "lX";
pub const __WCHAR_TYPE__ = c_int;
pub const __WINT_TYPE__ = c_int;
pub const __SIG_ATOMIC_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const __SIG_ATOMIC_WIDTH__ = @as(c_int, 32);
pub const __CHAR16_TYPE__ = c_ushort;
pub const __CHAR32_TYPE__ = c_uint;
pub const __UINTPTR_TYPE__ = c_ulong;
pub const __UINTPTR_FMTo__ = "lo";
pub const __UINTPTR_FMTu__ = "lu";
pub const __UINTPTR_FMTx__ = "lx";
pub const __UINTPTR_FMTX__ = "lX";
pub const __FLT16_HAS_DENORM__ = @as(c_int, 1);
pub const __FLT16_DIG__ = @as(c_int, 3);
pub const __FLT16_DECIMAL_DIG__ = @as(c_int, 5);
pub const __FLT16_HAS_INFINITY__ = @as(c_int, 1);
pub const __FLT16_HAS_QUIET_NAN__ = @as(c_int, 1);
pub const __FLT16_MANT_DIG__ = @as(c_int, 11);
pub const __FLT16_MAX_10_EXP__ = @as(c_int, 4);
pub const __FLT16_MAX_EXP__ = @as(c_int, 16);
pub const __FLT16_MIN_10_EXP__ = -@as(c_int, 4);
pub const __FLT16_MIN_EXP__ = -@as(c_int, 13);
pub const __FLT_DENORM_MIN__ = @as(f32, 1.40129846e-45);
pub const __FLT_HAS_DENORM__ = @as(c_int, 1);
pub const __FLT_DIG__ = @as(c_int, 6);
pub const __FLT_DECIMAL_DIG__ = @as(c_int, 9);
pub const __FLT_EPSILON__ = @as(f32, 1.19209290e-7);
pub const __FLT_HAS_INFINITY__ = @as(c_int, 1);
pub const __FLT_HAS_QUIET_NAN__ = @as(c_int, 1);
pub const __FLT_MANT_DIG__ = @as(c_int, 24);
pub const __FLT_MAX_10_EXP__ = @as(c_int, 38);
pub const __FLT_MAX_EXP__ = @as(c_int, 128);
pub const __FLT_MAX__ = @as(f32, 3.40282347e+38);
pub const __FLT_MIN_10_EXP__ = -@as(c_int, 37);
pub const __FLT_MIN_EXP__ = -@as(c_int, 125);
pub const __FLT_MIN__ = @as(f32, 1.17549435e-38);
pub const __DBL_DENORM_MIN__ = @as(f64, 4.9406564584124654e-324);
pub const __DBL_HAS_DENORM__ = @as(c_int, 1);
pub const __DBL_DIG__ = @as(c_int, 15);
pub const __DBL_DECIMAL_DIG__ = @as(c_int, 17);
pub const __DBL_EPSILON__ = @as(f64, 2.2204460492503131e-16);
pub const __DBL_HAS_INFINITY__ = @as(c_int, 1);
pub const __DBL_HAS_QUIET_NAN__ = @as(c_int, 1);
pub const __DBL_MANT_DIG__ = @as(c_int, 53);
pub const __DBL_MAX_10_EXP__ = @as(c_int, 308);
pub const __DBL_MAX_EXP__ = @as(c_int, 1024);
pub const __DBL_MAX__ = @as(f64, 1.7976931348623157e+308);
pub const __DBL_MIN_10_EXP__ = -@as(c_int, 307);
pub const __DBL_MIN_EXP__ = -@as(c_int, 1021);
pub const __DBL_MIN__ = @as(f64, 2.2250738585072014e-308);
pub const __LDBL_DENORM_MIN__ = @as(c_longdouble, 3.64519953188247460253e-4951);
pub const __LDBL_HAS_DENORM__ = @as(c_int, 1);
pub const __LDBL_DIG__ = @as(c_int, 18);
pub const __LDBL_DECIMAL_DIG__ = @as(c_int, 21);
pub const __LDBL_EPSILON__ = @as(c_longdouble, 1.08420217248550443401e-19);
pub const __LDBL_HAS_INFINITY__ = @as(c_int, 1);
pub const __LDBL_HAS_QUIET_NAN__ = @as(c_int, 1);
pub const __LDBL_MANT_DIG__ = @as(c_int, 64);
pub const __LDBL_MAX_10_EXP__ = @as(c_int, 4932);
pub const __LDBL_MAX_EXP__ = @as(c_int, 16384);
pub const __LDBL_MAX__ = @as(c_longdouble, 1.18973149535723176502e+4932);
pub const __LDBL_MIN_10_EXP__ = -@as(c_int, 4931);
pub const __LDBL_MIN_EXP__ = -@as(c_int, 16381);
pub const __LDBL_MIN__ = @as(c_longdouble, 3.36210314311209350626e-4932);
pub const __POINTER_WIDTH__ = @as(c_int, 64);
pub const __BIGGEST_ALIGNMENT__ = @as(c_int, 16);
pub const __INT8_TYPE__ = i8;
pub const __INT8_FMTd__ = "hhd";
pub const __INT8_FMTi__ = "hhi";
pub const __INT8_C_SUFFIX__ = "";
pub const __INT16_TYPE__ = c_short;
pub const __INT16_FMTd__ = "hd";
pub const __INT16_FMTi__ = "hi";
pub const __INT16_C_SUFFIX__ = "";
pub const __INT32_TYPE__ = c_int;
pub const __INT32_FMTd__ = "d";
pub const __INT32_FMTi__ = "i";
pub const __INT32_C_SUFFIX__ = "";
pub const __INT64_TYPE__ = c_longlong;
pub const __INT64_FMTd__ = "lld";
pub const __INT64_FMTi__ = "lli";
pub const __UINT8_TYPE__ = u8;
pub const __UINT8_FMTo__ = "hho";
pub const __UINT8_FMTu__ = "hhu";
pub const __UINT8_FMTx__ = "hhx";
pub const __UINT8_FMTX__ = "hhX";
pub const __UINT8_C_SUFFIX__ = "";
pub const __UINT8_MAX__ = @as(c_int, 255);
pub const __INT8_MAX__ = @as(c_int, 127);
pub const __UINT16_TYPE__ = c_ushort;
pub const __UINT16_FMTo__ = "ho";
pub const __UINT16_FMTu__ = "hu";
pub const __UINT16_FMTx__ = "hx";
pub const __UINT16_FMTX__ = "hX";
pub const __UINT16_C_SUFFIX__ = "";
pub const __UINT16_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_int, 65535, .decimal);
pub const __INT16_MAX__ = @as(c_int, 32767);
pub const __UINT32_TYPE__ = c_uint;
pub const __UINT32_FMTo__ = "o";
pub const __UINT32_FMTu__ = "u";
pub const __UINT32_FMTx__ = "x";
pub const __UINT32_FMTX__ = "X";
pub const __UINT32_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_uint, 4294967295, .decimal);
pub const __INT32_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const __UINT64_TYPE__ = c_ulonglong;
pub const __UINT64_FMTo__ = "llo";
pub const __UINT64_FMTu__ = "llu";
pub const __UINT64_FMTx__ = "llx";
pub const __UINT64_FMTX__ = "llX";
pub const __UINT64_MAX__ = @as(c_ulonglong, 18446744073709551615);
pub const __INT64_MAX__ = @as(c_longlong, 9223372036854775807);
pub const __INT_LEAST8_TYPE__ = i8;
pub const __INT_LEAST8_MAX__ = @as(c_int, 127);
pub const __INT_LEAST8_WIDTH__ = @as(c_int, 8);
pub const __INT_LEAST8_FMTd__ = "hhd";
pub const __INT_LEAST8_FMTi__ = "hhi";
pub const __UINT_LEAST8_TYPE__ = u8;
pub const __UINT_LEAST8_MAX__ = @as(c_int, 255);
pub const __UINT_LEAST8_FMTo__ = "hho";
pub const __UINT_LEAST8_FMTu__ = "hhu";
pub const __UINT_LEAST8_FMTx__ = "hhx";
pub const __UINT_LEAST8_FMTX__ = "hhX";
pub const __INT_LEAST16_TYPE__ = c_short;
pub const __INT_LEAST16_MAX__ = @as(c_int, 32767);
pub const __INT_LEAST16_WIDTH__ = @as(c_int, 16);
pub const __INT_LEAST16_FMTd__ = "hd";
pub const __INT_LEAST16_FMTi__ = "hi";
pub const __UINT_LEAST16_TYPE__ = c_ushort;
pub const __UINT_LEAST16_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_int, 65535, .decimal);
pub const __UINT_LEAST16_FMTo__ = "ho";
pub const __UINT_LEAST16_FMTu__ = "hu";
pub const __UINT_LEAST16_FMTx__ = "hx";
pub const __UINT_LEAST16_FMTX__ = "hX";
pub const __INT_LEAST32_TYPE__ = c_int;
pub const __INT_LEAST32_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const __INT_LEAST32_WIDTH__ = @as(c_int, 32);
pub const __INT_LEAST32_FMTd__ = "d";
pub const __INT_LEAST32_FMTi__ = "i";
pub const __UINT_LEAST32_TYPE__ = c_uint;
pub const __UINT_LEAST32_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_uint, 4294967295, .decimal);
pub const __UINT_LEAST32_FMTo__ = "o";
pub const __UINT_LEAST32_FMTu__ = "u";
pub const __UINT_LEAST32_FMTx__ = "x";
pub const __UINT_LEAST32_FMTX__ = "X";
pub const __INT_LEAST64_TYPE__ = c_long;
pub const __INT_LEAST64_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_long, 9223372036854775807, .decimal);
pub const __INT_LEAST64_WIDTH__ = @as(c_int, 64);
pub const __INT_LEAST64_FMTd__ = "ld";
pub const __INT_LEAST64_FMTi__ = "li";
pub const __UINT_LEAST64_TYPE__ = c_ulong;
pub const __UINT_LEAST64_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_ulong, 18446744073709551615, .decimal);
pub const __UINT_LEAST64_FMTo__ = "lo";
pub const __UINT_LEAST64_FMTu__ = "lu";
pub const __UINT_LEAST64_FMTx__ = "lx";
pub const __UINT_LEAST64_FMTX__ = "lX";
pub const __INT_FAST8_TYPE__ = i8;
pub const __INT_FAST8_MAX__ = @as(c_int, 127);
pub const __INT_FAST8_WIDTH__ = @as(c_int, 8);
pub const __INT_FAST8_FMTd__ = "hhd";
pub const __INT_FAST8_FMTi__ = "hhi";
pub const __UINT_FAST8_TYPE__ = u8;
pub const __UINT_FAST8_MAX__ = @as(c_int, 255);
pub const __UINT_FAST8_FMTo__ = "hho";
pub const __UINT_FAST8_FMTu__ = "hhu";
pub const __UINT_FAST8_FMTx__ = "hhx";
pub const __UINT_FAST8_FMTX__ = "hhX";
pub const __INT_FAST16_TYPE__ = c_short;
pub const __INT_FAST16_MAX__ = @as(c_int, 32767);
pub const __INT_FAST16_WIDTH__ = @as(c_int, 16);
pub const __INT_FAST16_FMTd__ = "hd";
pub const __INT_FAST16_FMTi__ = "hi";
pub const __UINT_FAST16_TYPE__ = c_ushort;
pub const __UINT_FAST16_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_int, 65535, .decimal);
pub const __UINT_FAST16_FMTo__ = "ho";
pub const __UINT_FAST16_FMTu__ = "hu";
pub const __UINT_FAST16_FMTx__ = "hx";
pub const __UINT_FAST16_FMTX__ = "hX";
pub const __INT_FAST32_TYPE__ = c_int;
pub const __INT_FAST32_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const __INT_FAST32_WIDTH__ = @as(c_int, 32);
pub const __INT_FAST32_FMTd__ = "d";
pub const __INT_FAST32_FMTi__ = "i";
pub const __UINT_FAST32_TYPE__ = c_uint;
pub const __UINT_FAST32_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_uint, 4294967295, .decimal);
pub const __UINT_FAST32_FMTo__ = "o";
pub const __UINT_FAST32_FMTu__ = "u";
pub const __UINT_FAST32_FMTx__ = "x";
pub const __UINT_FAST32_FMTX__ = "X";
pub const __INT_FAST64_TYPE__ = c_long;
pub const __INT_FAST64_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_long, 9223372036854775807, .decimal);
pub const __INT_FAST64_WIDTH__ = @as(c_int, 64);
pub const __INT_FAST64_FMTd__ = "ld";
pub const __INT_FAST64_FMTi__ = "li";
pub const __UINT_FAST64_TYPE__ = c_ulong;
pub const __UINT_FAST64_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_ulong, 18446744073709551615, .decimal);
pub const __UINT_FAST64_FMTo__ = "lo";
pub const __UINT_FAST64_FMTu__ = "lu";
pub const __UINT_FAST64_FMTx__ = "lx";
pub const __UINT_FAST64_FMTX__ = "lX";
pub const __USER_LABEL_PREFIX__ = "";
pub const __NO_MATH_ERRNO__ = @as(c_int, 1);
pub const __FINITE_MATH_ONLY__ = @as(c_int, 0);
pub const __GNUC_STDC_INLINE__ = @as(c_int, 1);
pub const __GCC_ATOMIC_TEST_AND_SET_TRUEVAL = @as(c_int, 1);
pub const __CLANG_ATOMIC_BOOL_LOCK_FREE = @as(c_int, 2);
pub const __CLANG_ATOMIC_CHAR_LOCK_FREE = @as(c_int, 2);
pub const __CLANG_ATOMIC_CHAR16_T_LOCK_FREE = @as(c_int, 2);
pub const __CLANG_ATOMIC_CHAR32_T_LOCK_FREE = @as(c_int, 2);
pub const __CLANG_ATOMIC_WCHAR_T_LOCK_FREE = @as(c_int, 2);
pub const __CLANG_ATOMIC_SHORT_LOCK_FREE = @as(c_int, 2);
pub const __CLANG_ATOMIC_INT_LOCK_FREE = @as(c_int, 2);
pub const __CLANG_ATOMIC_LONG_LOCK_FREE = @as(c_int, 2);
pub const __CLANG_ATOMIC_LLONG_LOCK_FREE = @as(c_int, 2);
pub const __CLANG_ATOMIC_POINTER_LOCK_FREE = @as(c_int, 2);
pub const __GCC_ATOMIC_BOOL_LOCK_FREE = @as(c_int, 2);
pub const __GCC_ATOMIC_CHAR_LOCK_FREE = @as(c_int, 2);
pub const __GCC_ATOMIC_CHAR16_T_LOCK_FREE = @as(c_int, 2);
pub const __GCC_ATOMIC_CHAR32_T_LOCK_FREE = @as(c_int, 2);
pub const __GCC_ATOMIC_WCHAR_T_LOCK_FREE = @as(c_int, 2);
pub const __GCC_ATOMIC_SHORT_LOCK_FREE = @as(c_int, 2);
pub const __GCC_ATOMIC_INT_LOCK_FREE = @as(c_int, 2);
pub const __GCC_ATOMIC_LONG_LOCK_FREE = @as(c_int, 2);
pub const __GCC_ATOMIC_LLONG_LOCK_FREE = @as(c_int, 2);
pub const __GCC_ATOMIC_POINTER_LOCK_FREE = @as(c_int, 2);
pub const __NO_INLINE__ = @as(c_int, 1);
pub const __PIC__ = @as(c_int, 2);
pub const __pic__ = @as(c_int, 2);
pub const __FLT_RADIX__ = @as(c_int, 2);
pub const __DECIMAL_DIG__ = __LDBL_DECIMAL_DIG__;
pub const __GCC_ASM_FLAG_OUTPUTS__ = @as(c_int, 1);
pub const __code_model_small__ = @as(c_int, 1);
pub const __amd64__ = @as(c_int, 1);
pub const __amd64 = @as(c_int, 1);
pub const __x86_64 = @as(c_int, 1);
pub const __x86_64__ = @as(c_int, 1);
pub const __SEG_GS = @as(c_int, 1);
pub const __SEG_FS = @as(c_int, 1);
pub const __znver1 = @as(c_int, 1);
pub const __znver1__ = @as(c_int, 1);
pub const __tune_znver1__ = @as(c_int, 1);
pub const __REGISTER_PREFIX__ = "";
pub const __NO_MATH_INLINES = @as(c_int, 1);
pub const __AES__ = @as(c_int, 1);
pub const __PCLMUL__ = @as(c_int, 1);
pub const __LAHF_SAHF__ = @as(c_int, 1);
pub const __LZCNT__ = @as(c_int, 1);
pub const __RDRND__ = @as(c_int, 1);
pub const __FSGSBASE__ = @as(c_int, 1);
pub const __BMI__ = @as(c_int, 1);
pub const __BMI2__ = @as(c_int, 1);
pub const __POPCNT__ = @as(c_int, 1);
pub const __PRFCHW__ = @as(c_int, 1);
pub const __RDSEED__ = @as(c_int, 1);
pub const __ADX__ = @as(c_int, 1);
pub const __MWAITX__ = @as(c_int, 1);
pub const __MOVBE__ = @as(c_int, 1);
pub const __SSE4A__ = @as(c_int, 1);
pub const __FMA__ = @as(c_int, 1);
pub const __F16C__ = @as(c_int, 1);
pub const __SHA__ = @as(c_int, 1);
pub const __FXSR__ = @as(c_int, 1);
pub const __XSAVE__ = @as(c_int, 1);
pub const __XSAVEOPT__ = @as(c_int, 1);
pub const __XSAVEC__ = @as(c_int, 1);
pub const __XSAVES__ = @as(c_int, 1);
pub const __CLFLUSHOPT__ = @as(c_int, 1);
pub const __CLWB__ = @as(c_int, 1);
pub const __WBNOINVD__ = @as(c_int, 1);
pub const __CLZERO__ = @as(c_int, 1);
pub const __RDPID__ = @as(c_int, 1);
pub const __CRC32__ = @as(c_int, 1);
pub const __AVX2__ = @as(c_int, 1);
pub const __AVX__ = @as(c_int, 1);
pub const __SSE4_2__ = @as(c_int, 1);
pub const __SSE4_1__ = @as(c_int, 1);
pub const __SSSE3__ = @as(c_int, 1);
pub const __SSE3__ = @as(c_int, 1);
pub const __SSE2__ = @as(c_int, 1);
pub const __SSE2_MATH__ = @as(c_int, 1);
pub const __SSE__ = @as(c_int, 1);
pub const __SSE_MATH__ = @as(c_int, 1);
pub const __MMX__ = @as(c_int, 1);
pub const __GCC_HAVE_SYNC_COMPARE_AND_SWAP_1 = @as(c_int, 1);
pub const __GCC_HAVE_SYNC_COMPARE_AND_SWAP_2 = @as(c_int, 1);
pub const __GCC_HAVE_SYNC_COMPARE_AND_SWAP_4 = @as(c_int, 1);
pub const __GCC_HAVE_SYNC_COMPARE_AND_SWAP_8 = @as(c_int, 1);
pub const __GCC_HAVE_SYNC_COMPARE_AND_SWAP_16 = @as(c_int, 1);
pub const __SIZEOF_FLOAT128__ = @as(c_int, 16);
pub const __OpenBSD__ = @as(c_int, 1);
pub const unix = @as(c_int, 1);
pub const __unix = @as(c_int, 1);
pub const __unix__ = @as(c_int, 1);
pub const __ELF__ = @as(c_int, 1);
pub const __FLOAT128__ = @as(c_int, 1);
pub const __STDC_NO_THREADS__ = @as(c_int, 1);
pub const __STDC__ = @as(c_int, 1);
pub const __STDC_HOSTED__ = @as(c_int, 1);
pub const __STDC_VERSION__ = @as(c_long, 201710);
pub const __STDC_UTF_16__ = @as(c_int, 1);
pub const __STDC_UTF_32__ = @as(c_int, 1);
pub const __CET__ = @as(c_int, 1);
pub const _DEBUG = @as(c_int, 1);
pub const _RET_PROTECTOR = @as(c_int, 1);
pub const __GCC_HAVE_DWARF2_CFI_ASM = @as(c_int, 1);
pub const UV_H = "";
pub const UV_ERRNO_H_ = "";
pub const _ERRNO_H_ = "";
pub const _SYS_CDEFS_H_ = "";
pub const _MACHINE_CDEFS_H_ = "";
pub inline fn __GNUC_PREREQ__(ma: anytype, mi: anytype) @TypeOf((__GNUC__ > ma) or ((__GNUC__ == ma) and (__GNUC_MINOR__ >= mi))) {
    return (__GNUC__ > ma) or ((__GNUC__ == ma) and (__GNUC_MINOR__ >= mi));
}
pub inline fn __P(protos: anytype) @TypeOf(protos) {
    return protos;
}
pub const __signed = c_int;
pub inline fn __predict_true(exp: anytype) @TypeOf(__builtin_expect(exp != @as(c_int, 0), @as(c_int, 1))) {
    return __builtin_expect(exp != @as(c_int, 0), @as(c_int, 1));
}
pub inline fn __predict_false(exp: anytype) @TypeOf(__builtin_expect(exp != @as(c_int, 0), @as(c_int, 0))) {
    return __builtin_expect(exp != @as(c_int, 0), @as(c_int, 0));
}
pub const __BEGIN_EXTERN_C = "";
pub const __END_EXTERN_C = "";
pub const __BEGIN_DECLS = __BEGIN_EXTERN_C;
pub const __END_DECLS = __END_EXTERN_C;
pub const __ISO_C_VISIBLE = @as(c_int, 2011);
pub const __XPG_VISIBLE = @as(c_int, 700);
pub const __POSIX_VISIBLE = @import("std").zig.c_translation.promoteIntLiteral(c_int, 200809, .decimal);
pub const __BSD_VISIBLE = @as(c_int, 1);
pub const EPERM = @as(c_int, 1);
pub const ENOENT = @as(c_int, 2);
pub const ESRCH = @as(c_int, 3);
pub const EINTR = @as(c_int, 4);
pub const EIO = @as(c_int, 5);
pub const ENXIO = @as(c_int, 6);
pub const E2BIG = @as(c_int, 7);
pub const ENOEXEC = @as(c_int, 8);
pub const EBADF = @as(c_int, 9);
pub const ECHILD = @as(c_int, 10);
pub const EDEADLK = @as(c_int, 11);
pub const ENOMEM = @as(c_int, 12);
pub const EACCES = @as(c_int, 13);
pub const EFAULT = @as(c_int, 14);
pub const ENOTBLK = @as(c_int, 15);
pub const EBUSY = @as(c_int, 16);
pub const EEXIST = @as(c_int, 17);
pub const EXDEV = @as(c_int, 18);
pub const ENODEV = @as(c_int, 19);
pub const ENOTDIR = @as(c_int, 20);
pub const EISDIR = @as(c_int, 21);
pub const EINVAL = @as(c_int, 22);
pub const ENFILE = @as(c_int, 23);
pub const EMFILE = @as(c_int, 24);
pub const ENOTTY = @as(c_int, 25);
pub const ETXTBSY = @as(c_int, 26);
pub const EFBIG = @as(c_int, 27);
pub const ENOSPC = @as(c_int, 28);
pub const ESPIPE = @as(c_int, 29);
pub const EROFS = @as(c_int, 30);
pub const EMLINK = @as(c_int, 31);
pub const EPIPE = @as(c_int, 32);
pub const EDOM = @as(c_int, 33);
pub const ERANGE = @as(c_int, 34);
pub const EAGAIN = @as(c_int, 35);
pub const EWOULDBLOCK = EAGAIN;
pub const EINPROGRESS = @as(c_int, 36);
pub const EALREADY = @as(c_int, 37);
pub const ENOTSOCK = @as(c_int, 38);
pub const EDESTADDRREQ = @as(c_int, 39);
pub const EMSGSIZE = @as(c_int, 40);
pub const EPROTOTYPE = @as(c_int, 41);
pub const ENOPROTOOPT = @as(c_int, 42);
pub const EPROTONOSUPPORT = @as(c_int, 43);
pub const ESOCKTNOSUPPORT = @as(c_int, 44);
pub const EOPNOTSUPP = @as(c_int, 45);
pub const EPFNOSUPPORT = @as(c_int, 46);
pub const EAFNOSUPPORT = @as(c_int, 47);
pub const EADDRINUSE = @as(c_int, 48);
pub const EADDRNOTAVAIL = @as(c_int, 49);
pub const ENETDOWN = @as(c_int, 50);
pub const ENETUNREACH = @as(c_int, 51);
pub const ENETRESET = @as(c_int, 52);
pub const ECONNABORTED = @as(c_int, 53);
pub const ECONNRESET = @as(c_int, 54);
pub const ENOBUFS = @as(c_int, 55);
pub const EISCONN = @as(c_int, 56);
pub const ENOTCONN = @as(c_int, 57);
pub const ESHUTDOWN = @as(c_int, 58);
pub const ETOOMANYREFS = @as(c_int, 59);
pub const ETIMEDOUT = @as(c_int, 60);
pub const ECONNREFUSED = @as(c_int, 61);
pub const ELOOP = @as(c_int, 62);
pub const ENAMETOOLONG = @as(c_int, 63);
pub const EHOSTDOWN = @as(c_int, 64);
pub const EHOSTUNREACH = @as(c_int, 65);
pub const ENOTEMPTY = @as(c_int, 66);
pub const EPROCLIM = @as(c_int, 67);
pub const EUSERS = @as(c_int, 68);
pub const EDQUOT = @as(c_int, 69);
pub const ESTALE = @as(c_int, 70);
pub const EREMOTE = @as(c_int, 71);
pub const EBADRPC = @as(c_int, 72);
pub const ERPCMISMATCH = @as(c_int, 73);
pub const EPROGUNAVAIL = @as(c_int, 74);
pub const EPROGMISMATCH = @as(c_int, 75);
pub const EPROCUNAVAIL = @as(c_int, 76);
pub const ENOLCK = @as(c_int, 77);
pub const ENOSYS = @as(c_int, 78);
pub const EFTYPE = @as(c_int, 79);
pub const EAUTH = @as(c_int, 80);
pub const ENEEDAUTH = @as(c_int, 81);
pub const EIPSEC = @as(c_int, 82);
pub const ENOATTR = @as(c_int, 83);
pub const EILSEQ = @as(c_int, 84);
pub const ENOMEDIUM = @as(c_int, 85);
pub const EMEDIUMTYPE = @as(c_int, 86);
pub const EOVERFLOW = @as(c_int, 87);
pub const ECANCELED = @as(c_int, 88);
pub const EIDRM = @as(c_int, 89);
pub const ENOMSG = @as(c_int, 90);
pub const ENOTSUP = @as(c_int, 91);
pub const EBADMSG = @as(c_int, 92);
pub const ENOTRECOVERABLE = @as(c_int, 93);
pub const EOWNERDEAD = @as(c_int, 94);
pub const EPROTO = @as(c_int, 95);
pub const ELAST = @as(c_int, 95);
pub const __SYS_ERRLIST = "";
pub const errno = __errno().*;
pub inline fn UV__ERR(x: anytype) @TypeOf(-x) {
    return -x;
}
pub const UV__EOF = -@as(c_int, 4095);
pub const UV__UNKNOWN = -@as(c_int, 4094);
pub const UV__EAI_ADDRFAMILY = -@as(c_int, 3000);
pub const UV__EAI_AGAIN = -@as(c_int, 3001);
pub const UV__EAI_BADFLAGS = -@as(c_int, 3002);
pub const UV__EAI_CANCELED = -@as(c_int, 3003);
pub const UV__EAI_FAIL = -@as(c_int, 3004);
pub const UV__EAI_FAMILY = -@as(c_int, 3005);
pub const UV__EAI_MEMORY = -@as(c_int, 3006);
pub const UV__EAI_NODATA = -@as(c_int, 3007);
pub const UV__EAI_NONAME = -@as(c_int, 3008);
pub const UV__EAI_OVERFLOW = -@as(c_int, 3009);
pub const UV__EAI_SERVICE = -@as(c_int, 3010);
pub const UV__EAI_SOCKTYPE = -@as(c_int, 3011);
pub const UV__EAI_BADHINTS = -@as(c_int, 3013);
pub const UV__EAI_PROTOCOL = -@as(c_int, 3014);
pub const UV__E2BIG = UV__ERR(E2BIG);
pub const UV__EACCES = UV__ERR(EACCES);
pub const UV__EADDRINUSE = UV__ERR(EADDRINUSE);
pub const UV__EADDRNOTAVAIL = UV__ERR(EADDRNOTAVAIL);
pub const UV__EAFNOSUPPORT = UV__ERR(EAFNOSUPPORT);
pub const UV__EAGAIN = UV__ERR(EAGAIN);
pub const UV__EALREADY = UV__ERR(EALREADY);
pub const UV__EBADF = UV__ERR(EBADF);
pub const UV__EBUSY = UV__ERR(EBUSY);
pub const UV__ECANCELED = UV__ERR(ECANCELED);
pub const UV__ECHARSET = -@as(c_int, 4080);
pub const UV__ECONNABORTED = UV__ERR(ECONNABORTED);
pub const UV__ECONNREFUSED = UV__ERR(ECONNREFUSED);
pub const UV__ECONNRESET = UV__ERR(ECONNRESET);
pub const UV__EDESTADDRREQ = UV__ERR(EDESTADDRREQ);
pub const UV__EEXIST = UV__ERR(EEXIST);
pub const UV__EFAULT = UV__ERR(EFAULT);
pub const UV__EHOSTUNREACH = UV__ERR(EHOSTUNREACH);
pub const UV__EINTR = UV__ERR(EINTR);
pub const UV__EINVAL = UV__ERR(EINVAL);
pub const UV__EIO = UV__ERR(EIO);
pub const UV__EISCONN = UV__ERR(EISCONN);
pub const UV__EISDIR = UV__ERR(EISDIR);
pub const UV__ELOOP = UV__ERR(ELOOP);
pub const UV__EMFILE = UV__ERR(EMFILE);
pub const UV__EMSGSIZE = UV__ERR(EMSGSIZE);
pub const UV__ENAMETOOLONG = UV__ERR(ENAMETOOLONG);
pub const UV__ENETDOWN = UV__ERR(ENETDOWN);
pub const UV__ENETUNREACH = UV__ERR(ENETUNREACH);
pub const UV__ENFILE = UV__ERR(ENFILE);
pub const UV__ENOBUFS = UV__ERR(ENOBUFS);
pub const UV__ENODEV = UV__ERR(ENODEV);
pub const UV__ENOENT = UV__ERR(ENOENT);
pub const UV__ENOMEM = UV__ERR(ENOMEM);
pub const UV__ENONET = -@as(c_int, 4056);
pub const UV__ENOSPC = UV__ERR(ENOSPC);
pub const UV__ENOSYS = UV__ERR(ENOSYS);
pub const UV__ENOTCONN = UV__ERR(ENOTCONN);
pub const UV__ENOTDIR = UV__ERR(ENOTDIR);
pub const UV__ENOTEMPTY = UV__ERR(ENOTEMPTY);
pub const UV__ENOTSOCK = UV__ERR(ENOTSOCK);
pub const UV__ENOTSUP = UV__ERR(ENOTSUP);
pub const UV__EPERM = UV__ERR(EPERM);
pub const UV__EPIPE = UV__ERR(EPIPE);
pub const UV__EPROTO = UV__ERR(EPROTO);
pub const UV__EPROTONOSUPPORT = UV__ERR(EPROTONOSUPPORT);
pub const UV__EPROTOTYPE = UV__ERR(EPROTOTYPE);
pub const UV__EROFS = UV__ERR(EROFS);
pub const UV__ESHUTDOWN = UV__ERR(ESHUTDOWN);
pub const UV__ESPIPE = UV__ERR(ESPIPE);
pub const UV__ESRCH = UV__ERR(ESRCH);
pub const UV__ETIMEDOUT = UV__ERR(ETIMEDOUT);
pub const UV__ETXTBSY = UV__ERR(ETXTBSY);
pub const UV__EXDEV = UV__ERR(EXDEV);
pub const UV__EFBIG = UV__ERR(EFBIG);
pub const UV__ENOPROTOOPT = UV__ERR(ENOPROTOOPT);
pub const UV__ERANGE = UV__ERR(ERANGE);
pub const UV__ENXIO = UV__ERR(ENXIO);
pub const UV__EMLINK = UV__ERR(EMLINK);
pub const UV__EHOSTDOWN = UV__ERR(EHOSTDOWN);
pub const UV__EREMOTEIO = -@as(c_int, 4030);
pub const UV__ENOTTY = UV__ERR(ENOTTY);
pub const UV__EFTYPE = UV__ERR(EFTYPE);
pub const UV__EILSEQ = UV__ERR(EILSEQ);
pub const UV__EOVERFLOW = UV__ERR(EOVERFLOW);
pub const UV__ESOCKTNOSUPPORT = UV__ERR(ESOCKTNOSUPPORT);
pub const UV_VERSION_H = "";
pub const UV_VERSION_MAJOR = @as(c_int, 1);
pub const UV_VERSION_MINOR = @as(c_int, 44);
pub const UV_VERSION_PATCH = @as(c_int, 2);
pub const UV_VERSION_IS_RELEASE = @as(c_int, 1);
pub const UV_VERSION_SUFFIX = "";
pub const UV_VERSION_HEX = ((UV_VERSION_MAJOR << @as(c_int, 16)) | (UV_VERSION_MINOR << @as(c_int, 8))) | UV_VERSION_PATCH;
pub const __STDDEF_H = "";
pub const __need_ptrdiff_t = "";
pub const __need_size_t = "";
pub const __need_wchar_t = "";
pub const __need_NULL = "";
pub const __need_STDDEF_H_misc = "";
pub const _PTRDIFF_T = "";
pub const _SIZE_T = "";
pub const _WCHAR_T = "";
pub const NULL = @import("std").zig.c_translation.cast(?*anyopaque, @as(c_int, 0));
pub const __CLANG_MAX_ALIGN_T_DEFINED = "";
pub const _STDIO_H_ = "";
pub const _SYS__TYPES_H_ = "";
pub const _MACHINE__TYPES_H_ = "";
pub const _ALIGNBYTES = @import("std").zig.c_translation.sizeof(c_long) - @as(c_int, 1);
pub const _STACKALIGNBYTES = @as(c_int, 15);
pub inline fn _ALIGN(p: anytype) @TypeOf((@import("std").zig.c_translation.cast(c_ulong, p) + _ALIGNBYTES) & ~_ALIGNBYTES) {
    return (@import("std").zig.c_translation.cast(c_ulong, p) + _ALIGNBYTES) & ~_ALIGNBYTES;
}
pub inline fn _ALIGNED_POINTER(p: anytype, t: anytype) @TypeOf(@as(c_int, 1)) {
    _ = @TypeOf(p);
    _ = @TypeOf(t);
    return @as(c_int, 1);
}
pub const _MAX_PAGE_SHIFT = @as(c_int, 12);
pub const __INT_FAST8_MIN = INT32_MIN;
pub const __INT_FAST16_MIN = INT32_MIN;
pub const __INT_FAST32_MIN = INT32_MIN;
pub const __INT_FAST64_MIN = INT64_MIN;
pub const __INT_FAST8_MAX = INT32_MAX;
pub const __INT_FAST16_MAX = INT32_MAX;
pub const __INT_FAST32_MAX = INT32_MAX;
pub const __INT_FAST64_MAX = INT64_MAX;
pub const __UINT_FAST8_MAX = UINT32_MAX;
pub const __UINT_FAST16_MAX = UINT32_MAX;
pub const __UINT_FAST32_MAX = UINT32_MAX;
pub const __UINT_FAST64_MAX = UINT64_MAX;
pub const _SYS_TYPES_H_ = "";
pub const _SYS_ENDIAN_H_ = "";
pub const _SYS__ENDIAN_H_ = "";
pub const __FROM_SYS__ENDIAN = "";
pub const _MACHINE_ENDIAN_H_ = "";
pub const __HAVE_MD_SWAP = "";
pub const _BYTE_ORDER = _LITTLE_ENDIAN;
pub const _LITTLE_ENDIAN = @as(c_int, 1234);
pub const _BIG_ENDIAN = @as(c_int, 4321);
pub const _PDP_ENDIAN = @as(c_int, 3412);
pub inline fn __swap16gen(x: anytype) __uint16_t {
    return @import("std").zig.c_translation.cast(__uint16_t, ((@import("std").zig.c_translation.cast(__uint16_t, x) & @as(c_uint, 0xff)) << @as(c_int, 8)) | ((@import("std").zig.c_translation.cast(__uint16_t, x) & @as(c_uint, 0xff00)) >> @as(c_int, 8)));
}
pub inline fn __swap32gen(x: anytype) __uint32_t {
    return @import("std").zig.c_translation.cast(__uint32_t, ((((@import("std").zig.c_translation.cast(__uint32_t, x) & @as(c_int, 0xff)) << @as(c_int, 24)) | ((@import("std").zig.c_translation.cast(__uint32_t, x) & @import("std").zig.c_translation.promoteIntLiteral(c_int, 0xff00, .hexadecimal)) << @as(c_int, 8))) | ((@import("std").zig.c_translation.cast(__uint32_t, x) & @import("std").zig.c_translation.promoteIntLiteral(c_int, 0xff0000, .hexadecimal)) >> @as(c_int, 8))) | ((@import("std").zig.c_translation.cast(__uint32_t, x) & @import("std").zig.c_translation.promoteIntLiteral(c_int, 0xff000000, .hexadecimal)) >> @as(c_int, 24)));
}
pub inline fn __swap64gen(x: anytype) __uint64_t {
    return @import("std").zig.c_translation.cast(__uint64_t, ((((((((@import("std").zig.c_translation.cast(__uint64_t, x) & @as(c_int, 0xff)) << @as(c_int, 56)) | ((@import("std").zig.c_translation.cast(__uint64_t, x) & @as(c_ulonglong, 0xff00)) << @as(c_int, 40))) | ((@import("std").zig.c_translation.cast(__uint64_t, x) & @as(c_ulonglong, 0xff0000)) << @as(c_int, 24))) | ((@import("std").zig.c_translation.cast(__uint64_t, x) & @as(c_ulonglong, 0xff000000)) << @as(c_int, 8))) | ((@import("std").zig.c_translation.cast(__uint64_t, x) & @as(c_ulonglong, 0xff00000000)) >> @as(c_int, 8))) | ((@import("std").zig.c_translation.cast(__uint64_t, x) & @as(c_ulonglong, 0xff0000000000)) >> @as(c_int, 24))) | ((@import("std").zig.c_translation.cast(__uint64_t, x) & @as(c_ulonglong, 0xff000000000000)) >> @as(c_int, 40))) | ((@import("std").zig.c_translation.cast(__uint64_t, x) & @as(c_ulonglong, 0xff00000000000000)) >> @as(c_int, 56)));
}
pub inline fn __swap16(x: anytype) __uint16_t {
    return @import("std").zig.c_translation.cast(__uint16_t, if (__builtin_constant_p(x)) __swap16gen(x) else __swap16md(x));
}
pub inline fn __swap32(x: anytype) __uint32_t {
    return @import("std").zig.c_translation.cast(__uint32_t, if (__builtin_constant_p(x)) __swap32gen(x) else __swap32md(x));
}
pub inline fn __swap64(x: anytype) __uint64_t {
    return @import("std").zig.c_translation.cast(__uint64_t, if (__builtin_constant_p(x)) __swap64gen(x) else __swap64md(x));
}
pub const _QUAD_HIGHWORD = @as(c_int, 1);
pub const _QUAD_LOWWORD = @as(c_int, 0);
pub const __htobe16 = __swap16;
pub const __htobe32 = __swap32;
pub const __htobe64 = __swap64;
pub inline fn __htole16(x: anytype) __uint16_t {
    return @import("std").zig.c_translation.cast(__uint16_t, x);
}
pub inline fn __htole32(x: anytype) __uint32_t {
    return @import("std").zig.c_translation.cast(__uint32_t, x);
}
pub inline fn __htole64(x: anytype) __uint64_t {
    return @import("std").zig.c_translation.cast(__uint64_t, x);
}
pub const LITTLE_ENDIAN = _LITTLE_ENDIAN;
pub const BIG_ENDIAN = _BIG_ENDIAN;
pub const PDP_ENDIAN = _PDP_ENDIAN;
pub const BYTE_ORDER = _BYTE_ORDER;
pub inline fn htobe16(x: anytype) @TypeOf(__htobe16(x)) {
    return __htobe16(x);
}
pub inline fn htobe32(x: anytype) @TypeOf(__htobe32(x)) {
    return __htobe32(x);
}
pub inline fn htobe64(x: anytype) @TypeOf(__htobe64(x)) {
    return __htobe64(x);
}
pub inline fn htole16(x: anytype) @TypeOf(__htole16(x)) {
    return __htole16(x);
}
pub inline fn htole32(x: anytype) @TypeOf(__htole32(x)) {
    return __htole32(x);
}
pub inline fn htole64(x: anytype) @TypeOf(__htole64(x)) {
    return __htole64(x);
}
pub inline fn be16toh(x: anytype) @TypeOf(__htobe16(x)) {
    return __htobe16(x);
}
pub inline fn be32toh(x: anytype) @TypeOf(__htobe32(x)) {
    return __htobe32(x);
}
pub inline fn be64toh(x: anytype) @TypeOf(__htobe64(x)) {
    return __htobe64(x);
}
pub inline fn le16toh(x: anytype) @TypeOf(__htole16(x)) {
    return __htole16(x);
}
pub inline fn le32toh(x: anytype) @TypeOf(__htole32(x)) {
    return __htole32(x);
}
pub inline fn le64toh(x: anytype) @TypeOf(__htole64(x)) {
    return __htole64(x);
}
pub inline fn swap16(x: anytype) @TypeOf(__swap16(x)) {
    return __swap16(x);
}
pub inline fn swap32(x: anytype) @TypeOf(__swap32(x)) {
    return __swap32(x);
}
pub inline fn swap64(x: anytype) @TypeOf(__swap64(x)) {
    return __swap64(x);
}
pub inline fn betoh16(x: anytype) @TypeOf(__htobe16(x)) {
    return __htobe16(x);
}
pub inline fn betoh32(x: anytype) @TypeOf(__htobe32(x)) {
    return __htobe32(x);
}
pub inline fn betoh64(x: anytype) @TypeOf(__htobe64(x)) {
    return __htobe64(x);
}
pub inline fn letoh16(x: anytype) @TypeOf(__htole16(x)) {
    return __htole16(x);
}
pub inline fn letoh32(x: anytype) @TypeOf(__htole32(x)) {
    return __htole32(x);
}
pub inline fn letoh64(x: anytype) @TypeOf(__htole64(x)) {
    return __htole64(x);
}
pub inline fn htons(x: anytype) @TypeOf(__htobe16(x)) {
    return __htobe16(x);
}
pub inline fn htonl(x: anytype) @TypeOf(__htobe32(x)) {
    return __htobe32(x);
}
pub inline fn ntohs(x: anytype) @TypeOf(__htobe16(x)) {
    return __htobe16(x);
}
pub inline fn ntohl(x: anytype) @TypeOf(__htobe32(x)) {
    return __htobe32(x);
}
pub const __BIT_TYPES_DEFINED__ = "";
pub const _INT8_T_DEFINED_ = "";
pub const _UINT8_T_DEFINED_ = "";
pub const _INT16_T_DEFINED_ = "";
pub const _UINT16_T_DEFINED_ = "";
pub const _INT32_T_DEFINED_ = "";
pub const _UINT32_T_DEFINED_ = "";
pub const _INT64_T_DEFINED_ = "";
pub const _UINT64_T_DEFINED_ = "";
pub const _CLOCK_T_DEFINED_ = "";
pub const _CLOCKID_T_DEFINED_ = "";
pub const _PID_T_DEFINED_ = "";
pub const _SIZE_T_DEFINED_ = "";
pub const _SSIZE_T_DEFINED_ = "";
pub const _TIME_T_DEFINED_ = "";
pub const _TIMER_T_DEFINED_ = "";
pub const _OFF_T_DEFINED_ = "";
pub inline fn major(x: anytype) @TypeOf((@import("std").zig.c_translation.cast(c_uint, x) >> @as(c_int, 8)) & @as(c_int, 0xff)) {
    return (@import("std").zig.c_translation.cast(c_uint, x) >> @as(c_int, 8)) & @as(c_int, 0xff);
}
pub inline fn minor(x: anytype) @TypeOf(@import("std").zig.c_translation.cast(c_uint, x & @as(c_int, 0xff)) | ((x & @import("std").zig.c_translation.promoteIntLiteral(c_int, 0xffff0000, .hexadecimal)) >> @as(c_int, 8))) {
    return @import("std").zig.c_translation.cast(c_uint, x & @as(c_int, 0xff)) | ((x & @import("std").zig.c_translation.promoteIntLiteral(c_int, 0xffff0000, .hexadecimal)) >> @as(c_int, 8));
}
pub inline fn makedev(x: anytype, y: anytype) dev_t {
    return @import("std").zig.c_translation.cast(dev_t, (((x & @as(c_int, 0xff)) << @as(c_int, 8)) | (y & @as(c_int, 0xff))) | ((y & @import("std").zig.c_translation.promoteIntLiteral(c_int, 0xffff00, .hexadecimal)) << @as(c_int, 8)));
}
pub const _FSTDIO = "";
pub const __SLBF = @as(c_int, 0x0001);
pub const __SNBF = @as(c_int, 0x0002);
pub const __SRD = @as(c_int, 0x0004);
pub const __SWR = @as(c_int, 0x0008);
pub const __SRW = @as(c_int, 0x0010);
pub const __SEOF = @as(c_int, 0x0020);
pub const __SERR = @as(c_int, 0x0040);
pub const __SMBF = @as(c_int, 0x0080);
pub const __SAPP = @as(c_int, 0x0100);
pub const __SSTR = @as(c_int, 0x0200);
pub const __SOPT = @as(c_int, 0x0400);
pub const __SNPT = @as(c_int, 0x0800);
pub const __SOFF = @as(c_int, 0x1000);
pub const __SMOD = @as(c_int, 0x2000);
pub const __SALC = @as(c_int, 0x4000);
pub const __SIGN = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x8000, .hexadecimal);
pub const _IOFBF = @as(c_int, 0);
pub const _IOLBF = @as(c_int, 1);
pub const _IONBF = @as(c_int, 2);
pub const BUFSIZ = @as(c_int, 1024);
pub const EOF = -@as(c_int, 1);
pub const FOPEN_MAX = @as(c_int, 20);
pub const FILENAME_MAX = @as(c_int, 1024);
pub const P_tmpdir = "/tmp/";
pub const L_tmpnam = @as(c_int, 1024);
pub const TMP_MAX = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x7fffffff, .hexadecimal);
pub const SEEK_SET = @as(c_int, 0);
pub const SEEK_CUR = @as(c_int, 1);
pub const SEEK_END = @as(c_int, 2);
pub const stdin = &__sF[@as(usize, @intCast(@as(c_int, 0)))];
pub const stdout = &__sF[@as(usize, @intCast(@as(c_int, 1)))];
pub const stderr = &__sF[@as(usize, @intCast(@as(c_int, 2)))];
pub const L_ctermid = @as(c_int, 1024);
pub inline fn fropen(cookie: anytype, @"fn": anytype) @TypeOf(funopen(cookie, @"fn", @as(c_int, 0), @as(c_int, 0), @as(c_int, 0))) {
    return funopen(cookie, @"fn", @as(c_int, 0), @as(c_int, 0), @as(c_int, 0));
}
pub inline fn fwopen(cookie: anytype, @"fn": anytype) @TypeOf(funopen(cookie, @as(c_int, 0), @"fn", @as(c_int, 0), @as(c_int, 0))) {
    return funopen(cookie, @as(c_int, 0), @"fn", @as(c_int, 0), @as(c_int, 0));
}
pub inline fn __sfeof(p: anytype) @TypeOf((p.*._flags & __SEOF) != @as(c_int, 0)) {
    return (p.*._flags & __SEOF) != @as(c_int, 0);
}
pub inline fn __sferror(p: anytype) @TypeOf((p.*._flags & __SERR) != @as(c_int, 0)) {
    return (p.*._flags & __SERR) != @as(c_int, 0);
}
pub inline fn __sfileno(p: anytype) @TypeOf(p.*._file) {
    return p.*._file;
}
pub const __CLANG_STDINT_H = "";
pub const _SYS_STDINT_H_ = "";
pub const _INTPTR_T_DEFINED_ = "";
pub const INT8_MIN = -@as(c_int, 0x7f) - @as(c_int, 1);
pub const INT16_MIN = -@as(c_int, 0x7fff) - @as(c_int, 1);
pub const INT32_MIN = -@import("std").zig.c_translation.promoteIntLiteral(c_int, 0x7fffffff, .hexadecimal) - @as(c_int, 1);
pub const INT64_MIN = -@as(c_longlong, 0x7fffffffffffffff) - @as(c_int, 1);
pub const INT8_MAX = @as(c_int, 0x7f);
pub const INT16_MAX = @as(c_int, 0x7fff);
pub const INT32_MAX = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x7fffffff, .hexadecimal);
pub const INT64_MAX = @as(c_longlong, 0x7fffffffffffffff);
pub const UINT8_MAX = @as(c_int, 0xff);
pub const UINT16_MAX = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0xffff, .hexadecimal);
pub const UINT32_MAX = @import("std").zig.c_translation.promoteIntLiteral(c_uint, 0xffffffff, .hexadecimal);
pub const UINT64_MAX = @as(c_ulonglong, 0xffffffffffffffff);
pub const INT_LEAST8_MIN = INT8_MIN;
pub const INT_LEAST16_MIN = INT16_MIN;
pub const INT_LEAST32_MIN = INT32_MIN;
pub const INT_LEAST64_MIN = INT64_MIN;
pub const INT_LEAST8_MAX = INT8_MAX;
pub const INT_LEAST16_MAX = INT16_MAX;
pub const INT_LEAST32_MAX = INT32_MAX;
pub const INT_LEAST64_MAX = INT64_MAX;
pub const UINT_LEAST8_MAX = UINT8_MAX;
pub const UINT_LEAST16_MAX = UINT16_MAX;
pub const UINT_LEAST32_MAX = UINT32_MAX;
pub const UINT_LEAST64_MAX = UINT64_MAX;
pub const INT_FAST8_MIN = __INT_FAST8_MIN;
pub const INT_FAST16_MIN = __INT_FAST16_MIN;
pub const INT_FAST32_MIN = __INT_FAST32_MIN;
pub const INT_FAST64_MIN = __INT_FAST64_MIN;
pub const INT_FAST8_MAX = __INT_FAST8_MAX;
pub const INT_FAST16_MAX = __INT_FAST16_MAX;
pub const INT_FAST32_MAX = __INT_FAST32_MAX;
pub const INT_FAST64_MAX = __INT_FAST64_MAX;
pub const UINT_FAST8_MAX = __UINT_FAST8_MAX;
pub const UINT_FAST16_MAX = __UINT_FAST16_MAX;
pub const UINT_FAST32_MAX = __UINT_FAST32_MAX;
pub const UINT_FAST64_MAX = __UINT_FAST64_MAX;
pub const INTPTR_MIN = -@import("std").zig.c_translation.promoteIntLiteral(c_long, 0x7fffffffffffffff, .hexadecimal) - @as(c_int, 1);
pub const INTPTR_MAX = @import("std").zig.c_translation.promoteIntLiteral(c_long, 0x7fffffffffffffff, .hexadecimal);
pub const UINTPTR_MAX = @import("std").zig.c_translation.promoteIntLiteral(c_ulong, 0xffffffffffffffff, .hexadecimal);
pub const INTMAX_MIN = INT64_MIN;
pub const INTMAX_MAX = INT64_MAX;
pub const UINTMAX_MAX = UINT64_MAX;
pub const PTRDIFF_MIN = INTPTR_MIN;
pub const PTRDIFF_MAX = INTPTR_MAX;
pub const SIG_ATOMIC_MIN = INT32_MIN;
pub const SIG_ATOMIC_MAX = INT32_MAX;
pub const SIZE_MAX = UINTPTR_MAX;
pub const WCHAR_MIN = INT32_MIN;
pub const WCHAR_MAX = INT32_MAX;
pub const WINT_MIN = INT32_MIN;
pub const WINT_MAX = INT32_MAX;
pub inline fn INT8_C(_c: anytype) @TypeOf(_c) {
    return _c;
}
pub inline fn INT16_C(_c: anytype) @TypeOf(_c) {
    return _c;
}
pub inline fn INT32_C(_c: anytype) @TypeOf(_c) {
    return _c;
}
pub inline fn UINT8_C(_c: anytype) @TypeOf(_c) {
    return _c;
}
pub inline fn UINT16_C(_c: anytype) @TypeOf(_c) {
    return _c;
}
pub const UV_UNIX_H = "";
pub const _SYS_STAT_H_ = "";
pub const _SYS_TIME_H_ = "";
pub const _SYS_SELECT_H_ = "";
pub const _TIMEVAL_DECLARED = "";
pub const _TIMESPEC_DECLARED = "";
pub const FD_SETSIZE = @as(c_int, 1024);
pub const __NBBY = @as(c_int, 8);
pub const __NFDBITS = @import("std").zig.c_translation.cast(c_uint, @import("std").zig.c_translation.sizeof(__fd_mask) * __NBBY);
pub inline fn __howmany(x: anytype, y: anytype) @TypeOf(@import("std").zig.c_translation.MacroArithmetic.div(x + (y - @as(c_int, 1)), y)) {
    return @import("std").zig.c_translation.MacroArithmetic.div(x + (y - @as(c_int, 1)), y);
}
pub inline fn FD_SET(n: anytype, p: anytype) @TypeOf(__fd_set(n, p)) {
    return __fd_set(n, p);
}
pub inline fn FD_CLR(n: anytype, p: anytype) @TypeOf(__fd_clr(n, p)) {
    return __fd_clr(n, p);
}
pub inline fn FD_ISSET(n: anytype, p: anytype) @TypeOf(__fd_isset(n, p)) {
    return __fd_isset(n, p);
}
pub const NBBY = __NBBY;
pub const fd_mask = __fd_mask;
pub const NFDBITS = __NFDBITS;
pub inline fn howmany(x: anytype, y: anytype) @TypeOf(__howmany(x, y)) {
    return __howmany(x, y);
}
pub const _SIGSET_T_DEFINED_ = "";
pub const _SELECT_DEFINED_ = "";
pub const DST_NONE = @as(c_int, 0);
pub const DST_USA = @as(c_int, 1);
pub const DST_AUST = @as(c_int, 2);
pub const DST_WET = @as(c_int, 3);
pub const DST_MET = @as(c_int, 4);
pub const DST_EET = @as(c_int, 5);
pub const DST_CAN = @as(c_int, 6);
pub inline fn timerisset(tvp: anytype) @TypeOf((tvp.*.tv_sec != 0) or (tvp.*.tv_usec != 0)) {
    return (tvp.*.tv_sec != 0) or (tvp.*.tv_usec != 0);
}
pub inline fn timerisvalid(tvp: anytype) @TypeOf((tvp.*.tv_usec >= @as(c_int, 0)) and (tvp.*.tv_usec < @import("std").zig.c_translation.promoteIntLiteral(c_int, 1000000, .decimal))) {
    return (tvp.*.tv_usec >= @as(c_int, 0)) and (tvp.*.tv_usec < @import("std").zig.c_translation.promoteIntLiteral(c_int, 1000000, .decimal));
}
pub inline fn timespecisset(tsp: anytype) @TypeOf((tsp.*.tv_sec != 0) or (tsp.*.tv_nsec != 0)) {
    return (tsp.*.tv_sec != 0) or (tsp.*.tv_nsec != 0);
}
pub inline fn timespecisvalid(tsp: anytype) @TypeOf((tsp.*.tv_nsec >= @as(c_int, 0)) and (tsp.*.tv_nsec < @as(c_long, 1000000000))) {
    return (tsp.*.tv_nsec >= @as(c_int, 0)) and (tsp.*.tv_nsec < @as(c_long, 1000000000));
}
pub const ITIMER_REAL = @as(c_int, 0);
pub const ITIMER_VIRTUAL = @as(c_int, 1);
pub const ITIMER_PROF = @as(c_int, 2);
pub const _TIME_H_ = "";
pub const _SYS__TIME_H_ = "";
pub const CLOCKS_PER_SEC = @as(c_int, 100);
pub inline fn __CLOCK_ENCODE(@"type": anytype, id: anytype) @TypeOf(@"type" | (id << @as(c_int, 12))) {
    return @"type" | (id << @as(c_int, 12));
}
pub inline fn __CLOCK_TYPE(c: anytype) @TypeOf(c & @as(c_int, 0xfff)) {
    return c & @as(c_int, 0xfff);
}
pub inline fn __CLOCK_PTID(c: anytype) @TypeOf((c >> @as(c_int, 12)) & @import("std").zig.c_translation.promoteIntLiteral(c_int, 0xfffff, .hexadecimal)) {
    return (c >> @as(c_int, 12)) & @import("std").zig.c_translation.promoteIntLiteral(c_int, 0xfffff, .hexadecimal);
}
pub const CLOCK_REALTIME = @as(c_int, 0);
pub const CLOCK_PROCESS_CPUTIME_ID = @as(c_int, 2);
pub const CLOCK_MONOTONIC = @as(c_int, 3);
pub const CLOCK_THREAD_CPUTIME_ID = @as(c_int, 4);
pub const CLOCK_UPTIME = @as(c_int, 5);
pub const CLOCK_BOOTTIME = @as(c_int, 6);
pub const TIMER_RELTIME = @as(c_int, 0x0);
pub const TIMER_ABSTIME = @as(c_int, 0x1);
pub const CLK_TCK = @as(c_int, 100);
pub const _LOCALE_T_DEFINED_ = "";
pub const TIME_UTC = @as(c_int, 1);
pub const S_ISUID = @as(c_int, 0o004000);
pub const S_ISGID = @as(c_int, 0o002000);
pub const S_ISTXT = @as(c_int, 0o001000);
pub const S_IRWXU = @as(c_int, 0o000700);
pub const S_IRUSR = @as(c_int, 0o000400);
pub const S_IWUSR = @as(c_int, 0o000200);
pub const S_IXUSR = @as(c_int, 0o000100);
pub const S_IREAD = S_IRUSR;
pub const S_IWRITE = S_IWUSR;
pub const S_IEXEC = S_IXUSR;
pub const S_IRWXG = @as(c_int, 0o000070);
pub const S_IRGRP = @as(c_int, 0o000040);
pub const S_IWGRP = @as(c_int, 0o000020);
pub const S_IXGRP = @as(c_int, 0o000010);
pub const S_IRWXO = @as(c_int, 0o000007);
pub const S_IROTH = @as(c_int, 0o000004);
pub const S_IWOTH = @as(c_int, 0o000002);
pub const S_IXOTH = @as(c_int, 0o000001);
pub const S_IFMT = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0o170000, .octal);
pub const S_IFIFO = @as(c_int, 0o010000);
pub const S_IFCHR = @as(c_int, 0o020000);
pub const S_IFDIR = @as(c_int, 0o040000);
pub const S_IFBLK = @as(c_int, 0o060000);
pub const S_IFREG = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0o100000, .octal);
pub const S_IFLNK = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0o120000, .octal);
pub const S_IFSOCK = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0o140000, .octal);
pub const S_ISVTX = @as(c_int, 0o001000);
pub inline fn S_ISDIR(m: anytype) @TypeOf((m & @import("std").zig.c_translation.promoteIntLiteral(c_int, 0o170000, .octal)) == @as(c_int, 0o040000)) {
    return (m & @import("std").zig.c_translation.promoteIntLiteral(c_int, 0o170000, .octal)) == @as(c_int, 0o040000);
}
pub inline fn S_ISCHR(m: anytype) @TypeOf((m & @import("std").zig.c_translation.promoteIntLiteral(c_int, 0o170000, .octal)) == @as(c_int, 0o020000)) {
    return (m & @import("std").zig.c_translation.promoteIntLiteral(c_int, 0o170000, .octal)) == @as(c_int, 0o020000);
}
pub inline fn S_ISBLK(m: anytype) @TypeOf((m & @import("std").zig.c_translation.promoteIntLiteral(c_int, 0o170000, .octal)) == @as(c_int, 0o060000)) {
    return (m & @import("std").zig.c_translation.promoteIntLiteral(c_int, 0o170000, .octal)) == @as(c_int, 0o060000);
}
pub inline fn S_ISREG(m: anytype) @TypeOf((m & @import("std").zig.c_translation.promoteIntLiteral(c_int, 0o170000, .octal)) == @import("std").zig.c_translation.promoteIntLiteral(c_int, 0o100000, .octal)) {
    return (m & @import("std").zig.c_translation.promoteIntLiteral(c_int, 0o170000, .octal)) == @import("std").zig.c_translation.promoteIntLiteral(c_int, 0o100000, .octal);
}
pub inline fn S_ISFIFO(m: anytype) @TypeOf((m & @import("std").zig.c_translation.promoteIntLiteral(c_int, 0o170000, .octal)) == @as(c_int, 0o010000)) {
    return (m & @import("std").zig.c_translation.promoteIntLiteral(c_int, 0o170000, .octal)) == @as(c_int, 0o010000);
}
pub inline fn S_ISLNK(m: anytype) @TypeOf((m & @import("std").zig.c_translation.promoteIntLiteral(c_int, 0o170000, .octal)) == @import("std").zig.c_translation.promoteIntLiteral(c_int, 0o120000, .octal)) {
    return (m & @import("std").zig.c_translation.promoteIntLiteral(c_int, 0o170000, .octal)) == @import("std").zig.c_translation.promoteIntLiteral(c_int, 0o120000, .octal);
}
pub inline fn S_ISSOCK(m: anytype) @TypeOf((m & @import("std").zig.c_translation.promoteIntLiteral(c_int, 0o170000, .octal)) == @import("std").zig.c_translation.promoteIntLiteral(c_int, 0o140000, .octal)) {
    return (m & @import("std").zig.c_translation.promoteIntLiteral(c_int, 0o170000, .octal)) == @import("std").zig.c_translation.promoteIntLiteral(c_int, 0o140000, .octal);
}
pub inline fn S_TYPEISMQ(m: anytype) @TypeOf(@as(c_int, 0)) {
    _ = @TypeOf(m);
    return @as(c_int, 0);
}
pub inline fn S_TYPEISSEM(m: anytype) @TypeOf(@as(c_int, 0)) {
    _ = @TypeOf(m);
    return @as(c_int, 0);
}
pub inline fn S_TYPEISSHM(m: anytype) @TypeOf(@as(c_int, 0)) {
    _ = @TypeOf(m);
    return @as(c_int, 0);
}
pub const ACCESSPERMS = (S_IRWXU | S_IRWXG) | S_IRWXO;
pub const ALLPERMS = ((((S_ISUID | S_ISGID) | S_ISTXT) | S_IRWXU) | S_IRWXG) | S_IRWXO;
pub const DEFFILEMODE = ((((S_IRUSR | S_IWUSR) | S_IRGRP) | S_IWGRP) | S_IROTH) | S_IWOTH;
pub const S_BLKSIZE = @as(c_int, 512);
pub const UF_SETTABLE = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x0000ffff, .hexadecimal);
pub const UF_NODUMP = @as(c_int, 0x00000001);
pub const UF_IMMUTABLE = @as(c_int, 0x00000002);
pub const UF_APPEND = @as(c_int, 0x00000004);
pub const UF_OPAQUE = @as(c_int, 0x00000008);
pub const SF_SETTABLE = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0xffff0000, .hexadecimal);
pub const SF_ARCHIVED = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x00010000, .hexadecimal);
pub const SF_IMMUTABLE = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x00020000, .hexadecimal);
pub const SF_APPEND = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x00040000, .hexadecimal);
pub const UTIME_NOW = -@as(c_long, 2);
pub const UTIME_OMIT = -@as(c_long, 1);
pub const _SYS_FCNTL_H_ = "";
pub const O_RDONLY = @as(c_int, 0x0000);
pub const O_WRONLY = @as(c_int, 0x0001);
pub const O_RDWR = @as(c_int, 0x0002);
pub const O_ACCMODE = @as(c_int, 0x0003);
pub const FREAD = @as(c_int, 0x0001);
pub const FWRITE = @as(c_int, 0x0002);
pub const O_NONBLOCK = @as(c_int, 0x0004);
pub const O_APPEND = @as(c_int, 0x0008);
pub const O_SHLOCK = @as(c_int, 0x0010);
pub const O_EXLOCK = @as(c_int, 0x0020);
pub const O_ASYNC = @as(c_int, 0x0040);
pub const O_FSYNC = @as(c_int, 0x0080);
pub const O_NOFOLLOW = @as(c_int, 0x0100);
pub const O_SYNC = @as(c_int, 0x0080);
pub const O_CREAT = @as(c_int, 0x0200);
pub const O_TRUNC = @as(c_int, 0x0400);
pub const O_EXCL = @as(c_int, 0x0800);
pub const O_DSYNC = O_SYNC;
pub const O_RSYNC = O_SYNC;
pub const O_NOCTTY = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x8000, .hexadecimal);
pub const O_CLOEXEC = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x10000, .hexadecimal);
pub const O_DIRECTORY = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x20000, .hexadecimal);
pub const FAPPEND = O_APPEND;
pub const FASYNC = O_ASYNC;
pub const FFSYNC = O_SYNC;
pub const FNONBLOCK = O_NONBLOCK;
pub const FNDELAY = O_NONBLOCK;
pub const O_NDELAY = O_NONBLOCK;
pub const F_DUPFD = @as(c_int, 0);
pub const F_GETFD = @as(c_int, 1);
pub const F_SETFD = @as(c_int, 2);
pub const F_GETFL = @as(c_int, 3);
pub const F_SETFL = @as(c_int, 4);
pub const F_GETOWN = @as(c_int, 5);
pub const F_SETOWN = @as(c_int, 6);
pub const F_GETLK = @as(c_int, 7);
pub const F_SETLK = @as(c_int, 8);
pub const F_SETLKW = @as(c_int, 9);
pub const F_DUPFD_CLOEXEC = @as(c_int, 10);
pub const F_ISATTY = @as(c_int, 11);
pub const FD_CLOEXEC = @as(c_int, 1);
pub const F_RDLCK = @as(c_int, 1);
pub const F_UNLCK = @as(c_int, 2);
pub const F_WRLCK = @as(c_int, 3);
pub const LOCK_SH = @as(c_int, 0x01);
pub const LOCK_EX = @as(c_int, 0x02);
pub const LOCK_NB = @as(c_int, 0x04);
pub const LOCK_UN = @as(c_int, 0x08);
pub const AT_FDCWD = -@as(c_int, 100);
pub const AT_EACCESS = @as(c_int, 0x01);
pub const AT_SYMLINK_NOFOLLOW = @as(c_int, 0x02);
pub const AT_SYMLINK_FOLLOW = @as(c_int, 0x04);
pub const AT_REMOVEDIR = @as(c_int, 0x08);
pub const _DIRENT_H_ = "";
pub const _SYS_DIRENT_H_ = "";
pub const MAXNAMLEN = @as(c_int, 255);
pub const DT_UNKNOWN = @as(c_int, 0);
pub const DT_FIFO = @as(c_int, 1);
pub const DT_CHR = @as(c_int, 2);
pub const DT_DIR = @as(c_int, 4);
pub const DT_BLK = @as(c_int, 6);
pub const DT_REG = @as(c_int, 8);
pub const DT_LNK = @as(c_int, 10);
pub const DT_SOCK = @as(c_int, 12);
pub inline fn IFTODT(mode: anytype) @TypeOf((mode & @import("std").zig.c_translation.promoteIntLiteral(c_int, 0o170000, .octal)) >> @as(c_int, 12)) {
    return (mode & @import("std").zig.c_translation.promoteIntLiteral(c_int, 0o170000, .octal)) >> @as(c_int, 12);
}
pub inline fn DTTOIF(dirtype: anytype) @TypeOf(dirtype << @as(c_int, 12)) {
    return dirtype << @as(c_int, 12);
}
pub const DIRBLKSIZ = @as(c_int, 1024);
pub const _SYS_SOCKET_H_ = "";
pub const _SYS_UIO_H_ = "";
pub const UIO_MAXIOV = @as(c_int, 1024);
pub const _SOCKLEN_T_DEFINED_ = "";
pub const _SA_FAMILY_T_DEFINED_ = "";
pub const SOCK_STREAM = @as(c_int, 1);
pub const SOCK_DGRAM = @as(c_int, 2);
pub const SOCK_RAW = @as(c_int, 3);
pub const SOCK_RDM = @as(c_int, 4);
pub const SOCK_SEQPACKET = @as(c_int, 5);
pub const SOCK_CLOEXEC = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x8000, .hexadecimal);
pub const SOCK_NONBLOCK = @as(c_int, 0x4000);
pub const SOCK_DNS = @as(c_int, 0x1000);
pub const SO_DEBUG = @as(c_int, 0x0001);
pub const SO_ACCEPTCONN = @as(c_int, 0x0002);
pub const SO_REUSEADDR = @as(c_int, 0x0004);
pub const SO_KEEPALIVE = @as(c_int, 0x0008);
pub const SO_DONTROUTE = @as(c_int, 0x0010);
pub const SO_BROADCAST = @as(c_int, 0x0020);
pub const SO_USELOOPBACK = @as(c_int, 0x0040);
pub const SO_LINGER = @as(c_int, 0x0080);
pub const SO_OOBINLINE = @as(c_int, 0x0100);
pub const SO_REUSEPORT = @as(c_int, 0x0200);
pub const SO_TIMESTAMP = @as(c_int, 0x0800);
pub const SO_BINDANY = @as(c_int, 0x1000);
pub const SO_ZEROIZE = @as(c_int, 0x2000);
pub const SO_SNDBUF = @as(c_int, 0x1001);
pub const SO_RCVBUF = @as(c_int, 0x1002);
pub const SO_SNDLOWAT = @as(c_int, 0x1003);
pub const SO_RCVLOWAT = @as(c_int, 0x1004);
pub const SO_SNDTIMEO = @as(c_int, 0x1005);
pub const SO_RCVTIMEO = @as(c_int, 0x1006);
pub const SO_ERROR = @as(c_int, 0x1007);
pub const SO_TYPE = @as(c_int, 0x1008);
pub const SO_NETPROC = @as(c_int, 0x1020);
pub const SO_RTABLE = @as(c_int, 0x1021);
pub const SO_PEERCRED = @as(c_int, 0x1022);
pub const SO_SPLICE = @as(c_int, 0x1023);
pub const SO_DOMAIN = @as(c_int, 0x1024);
pub const SO_PROTOCOL = @as(c_int, 0x1025);
pub const RT_TABLEID_MAX = @as(c_int, 255);
pub const RT_TABLEID_BITS = @as(c_int, 8);
pub const RT_TABLEID_MASK = @as(c_int, 0xff);
pub const SOL_SOCKET = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0xffff, .hexadecimal);
pub const AF_UNSPEC = @as(c_int, 0);
pub const AF_UNIX = @as(c_int, 1);
pub const AF_LOCAL = AF_UNIX;
pub const AF_INET = @as(c_int, 2);
pub const AF_IMPLINK = @as(c_int, 3);
pub const AF_PUP = @as(c_int, 4);
pub const AF_CHAOS = @as(c_int, 5);
pub const AF_NS = @as(c_int, 6);
pub const AF_ISO = @as(c_int, 7);
pub const AF_OSI = AF_ISO;
pub const AF_ECMA = @as(c_int, 8);
pub const AF_DATAKIT = @as(c_int, 9);
pub const AF_CCITT = @as(c_int, 10);
pub const AF_SNA = @as(c_int, 11);
pub const AF_DECnet = @as(c_int, 12);
pub const AF_DLI = @as(c_int, 13);
pub const AF_LAT = @as(c_int, 14);
pub const AF_HYLINK = @as(c_int, 15);
pub const AF_APPLETALK = @as(c_int, 16);
pub const AF_ROUTE = @as(c_int, 17);
pub const AF_LINK = @as(c_int, 18);
pub const pseudo_AF_XTP = @as(c_int, 19);
pub const AF_COIP = @as(c_int, 20);
pub const AF_CNT = @as(c_int, 21);
pub const pseudo_AF_RTIP = @as(c_int, 22);
pub const AF_IPX = @as(c_int, 23);
pub const AF_INET6 = @as(c_int, 24);
pub const pseudo_AF_PIP = @as(c_int, 25);
pub const AF_ISDN = @as(c_int, 26);
pub const AF_E164 = AF_ISDN;
pub const AF_NATM = @as(c_int, 27);
pub const AF_ENCAP = @as(c_int, 28);
pub const AF_SIP = @as(c_int, 29);
pub const AF_KEY = @as(c_int, 30);
pub const pseudo_AF_HDRCMPLT = @as(c_int, 31);
pub const AF_BLUETOOTH = @as(c_int, 32);
pub const AF_MPLS = @as(c_int, 33);
pub const pseudo_AF_PFLOW = @as(c_int, 34);
pub const pseudo_AF_PIPEX = @as(c_int, 35);
pub const AF_MAX = @as(c_int, 36);
pub const PF_UNSPEC = AF_UNSPEC;
pub const PF_LOCAL = AF_LOCAL;
pub const PF_UNIX = AF_UNIX;
pub const PF_INET = AF_INET;
pub const PF_IMPLINK = AF_IMPLINK;
pub const PF_PUP = AF_PUP;
pub const PF_CHAOS = AF_CHAOS;
pub const PF_NS = AF_NS;
pub const PF_ISO = AF_ISO;
pub const PF_OSI = AF_ISO;
pub const PF_ECMA = AF_ECMA;
pub const PF_DATAKIT = AF_DATAKIT;
pub const PF_CCITT = AF_CCITT;
pub const PF_SNA = AF_SNA;
pub const PF_DECnet = AF_DECnet;
pub const PF_DLI = AF_DLI;
pub const PF_LAT = AF_LAT;
pub const PF_HYLINK = AF_HYLINK;
pub const PF_APPLETALK = AF_APPLETALK;
pub const PF_ROUTE = AF_ROUTE;
pub const PF_LINK = AF_LINK;
pub const PF_XTP = pseudo_AF_XTP;
pub const PF_COIP = AF_COIP;
pub const PF_CNT = AF_CNT;
pub const PF_IPX = AF_IPX;
pub const PF_INET6 = AF_INET6;
pub const PF_RTIP = pseudo_AF_RTIP;
pub const PF_PIP = pseudo_AF_PIP;
pub const PF_ISDN = AF_ISDN;
pub const PF_NATM = AF_NATM;
pub const PF_ENCAP = AF_ENCAP;
pub const PF_SIP = AF_SIP;
pub const PF_KEY = AF_KEY;
pub const PF_BPF = pseudo_AF_HDRCMPLT;
pub const PF_BLUETOOTH = AF_BLUETOOTH;
pub const PF_MPLS = AF_MPLS;
pub const PF_PFLOW = pseudo_AF_PFLOW;
pub const PF_PIPEX = pseudo_AF_PIPEX;
pub const PF_MAX = AF_MAX;
pub const SHUT_RD = @as(c_int, 0);
pub const SHUT_WR = @as(c_int, 1);
pub const SHUT_RDWR = @as(c_int, 2);
pub inline fn SA_LEN(x: anytype) @TypeOf(x.*.sa_len) {
    return x.*.sa_len;
}
pub const NET_MAXID = AF_MAX;
pub const NET_RT_DUMP = @as(c_int, 1);
pub const NET_RT_FLAGS = @as(c_int, 2);
pub const NET_RT_IFLIST = @as(c_int, 3);
pub const NET_RT_STATS = @as(c_int, 4);
pub const NET_RT_TABLE = @as(c_int, 5);
pub const NET_RT_IFNAMES = @as(c_int, 6);
pub const NET_RT_SOURCE = @as(c_int, 7);
pub const NET_RT_MAXID = @as(c_int, 8);
pub const NET_UNIX_INFLIGHT = @as(c_int, 6);
pub const NET_UNIX_DEFERRED = @as(c_int, 7);
pub const NET_UNIX_MAXID = @as(c_int, 8);
pub const UNPCTL_RECVSPACE = @as(c_int, 1);
pub const UNPCTL_SENDSPACE = @as(c_int, 2);
pub const NET_UNIX_PROTO_MAXID = @as(c_int, 3);
pub const NET_LINK_IFRXQ = @as(c_int, 1);
pub const NET_LINK_MAXID = @as(c_int, 2);
pub const NET_LINK_IFRXQ_PRESSURE_RETURN = @as(c_int, 1);
pub const NET_LINK_IFRXQ_PRESSURE_DROP = @as(c_int, 2);
pub const NET_LINK_IFRXQ_MAXID = @as(c_int, 3);
pub const NET_KEY_SADB_DUMP = @as(c_int, 1);
pub const NET_KEY_SPD_DUMP = @as(c_int, 2);
pub const NET_KEY_MAXID = @as(c_int, 3);
pub const NET_BPF_BUFSIZE = @as(c_int, 1);
pub const NET_BPF_MAXBUFSIZE = @as(c_int, 2);
pub const NET_BPF_MAXID = @as(c_int, 3);
pub const NET_PFLOW_STATS = @as(c_int, 1);
pub const NET_PFLOW_MAXID = @as(c_int, 2);
pub const SOMAXCONN = @as(c_int, 128);
pub const MSG_OOB = @as(c_int, 0x1);
pub const MSG_PEEK = @as(c_int, 0x2);
pub const MSG_DONTROUTE = @as(c_int, 0x4);
pub const MSG_EOR = @as(c_int, 0x8);
pub const MSG_TRUNC = @as(c_int, 0x10);
pub const MSG_CTRUNC = @as(c_int, 0x20);
pub const MSG_WAITALL = @as(c_int, 0x40);
pub const MSG_DONTWAIT = @as(c_int, 0x80);
pub const MSG_BCAST = @as(c_int, 0x100);
pub const MSG_MCAST = @as(c_int, 0x200);
pub const MSG_NOSIGNAL = @as(c_int, 0x400);
pub const MSG_CMSG_CLOEXEC = @as(c_int, 0x800);
pub const MSG_WAITFORONE = @as(c_int, 0x1000);
pub inline fn CMSG_DATA(cmsg: anytype) @TypeOf(@import("std").zig.c_translation.cast([*c]u8, cmsg) + _ALIGN(@import("std").zig.c_translation.sizeof(struct_cmsghdr))) {
    return @import("std").zig.c_translation.cast([*c]u8, cmsg) + _ALIGN(@import("std").zig.c_translation.sizeof(struct_cmsghdr));
}
pub inline fn CMSG_NXTHDR(mhdr: anytype, cmsg: anytype) @TypeOf(if (((@import("std").zig.c_translation.cast([*c]u8, cmsg) + _ALIGN(cmsg.*.cmsg_len)) + _ALIGN(@import("std").zig.c_translation.sizeof(struct_cmsghdr))) > (@import("std").zig.c_translation.cast([*c]u8, mhdr.*.msg_control) + mhdr.*.msg_controllen)) @import("std").zig.c_translation.cast([*c]struct_cmsghdr, NULL) else @import("std").zig.c_translation.cast([*c]struct_cmsghdr, @import("std").zig.c_translation.cast([*c]u8, cmsg) + _ALIGN(cmsg.*.cmsg_len))) {
    return if (((@import("std").zig.c_translation.cast([*c]u8, cmsg) + _ALIGN(cmsg.*.cmsg_len)) + _ALIGN(@import("std").zig.c_translation.sizeof(struct_cmsghdr))) > (@import("std").zig.c_translation.cast([*c]u8, mhdr.*.msg_control) + mhdr.*.msg_controllen)) @import("std").zig.c_translation.cast([*c]struct_cmsghdr, NULL) else @import("std").zig.c_translation.cast([*c]struct_cmsghdr, @import("std").zig.c_translation.cast([*c]u8, cmsg) + _ALIGN(cmsg.*.cmsg_len));
}
pub inline fn CMSG_FIRSTHDR(mhdr: anytype) @TypeOf(if (mhdr.*.msg_controllen >= @import("std").zig.c_translation.sizeof(struct_cmsghdr)) @import("std").zig.c_translation.cast([*c]struct_cmsghdr, mhdr.*.msg_control) else @import("std").zig.c_translation.cast([*c]struct_cmsghdr, NULL)) {
    return if (mhdr.*.msg_controllen >= @import("std").zig.c_translation.sizeof(struct_cmsghdr)) @import("std").zig.c_translation.cast([*c]struct_cmsghdr, mhdr.*.msg_control) else @import("std").zig.c_translation.cast([*c]struct_cmsghdr, NULL);
}
pub inline fn CMSG_LEN(len: anytype) @TypeOf(_ALIGN(@import("std").zig.c_translation.sizeof(struct_cmsghdr)) + len) {
    return _ALIGN(@import("std").zig.c_translation.sizeof(struct_cmsghdr)) + len;
}
pub inline fn CMSG_SPACE(len: anytype) @TypeOf(_ALIGN(@import("std").zig.c_translation.sizeof(struct_cmsghdr)) + _ALIGN(len)) {
    return _ALIGN(@import("std").zig.c_translation.sizeof(struct_cmsghdr)) + _ALIGN(len);
}
pub const SCM_RIGHTS = @as(c_int, 0x01);
pub const SCM_TIMESTAMP = @as(c_int, 0x04);
pub const _NETINET_IN_H_ = "";
pub const _IN_TYPES_DEFINED_ = "";
pub const IPPROTO_IP = @as(c_int, 0);
pub const IPPROTO_HOPOPTS = IPPROTO_IP;
pub const IPPROTO_ICMP = @as(c_int, 1);
pub const IPPROTO_IGMP = @as(c_int, 2);
pub const IPPROTO_GGP = @as(c_int, 3);
pub const IPPROTO_IPIP = @as(c_int, 4);
pub const IPPROTO_IPV4 = IPPROTO_IPIP;
pub const IPPROTO_TCP = @as(c_int, 6);
pub const IPPROTO_EGP = @as(c_int, 8);
pub const IPPROTO_PUP = @as(c_int, 12);
pub const IPPROTO_UDP = @as(c_int, 17);
pub const IPPROTO_IDP = @as(c_int, 22);
pub const IPPROTO_TP = @as(c_int, 29);
pub const IPPROTO_IPV6 = @as(c_int, 41);
pub const IPPROTO_ROUTING = @as(c_int, 43);
pub const IPPROTO_FRAGMENT = @as(c_int, 44);
pub const IPPROTO_RSVP = @as(c_int, 46);
pub const IPPROTO_GRE = @as(c_int, 47);
pub const IPPROTO_ESP = @as(c_int, 50);
pub const IPPROTO_AH = @as(c_int, 51);
pub const IPPROTO_MOBILE = @as(c_int, 55);
pub const IPPROTO_ICMPV6 = @as(c_int, 58);
pub const IPPROTO_NONE = @as(c_int, 59);
pub const IPPROTO_DSTOPTS = @as(c_int, 60);
pub const IPPROTO_EON = @as(c_int, 80);
pub const IPPROTO_ETHERIP = @as(c_int, 97);
pub const IPPROTO_ENCAP = @as(c_int, 98);
pub const IPPROTO_PIM = @as(c_int, 103);
pub const IPPROTO_IPCOMP = @as(c_int, 108);
pub const IPPROTO_CARP = @as(c_int, 112);
pub const IPPROTO_SCTP = @as(c_int, 132);
pub const IPPROTO_UDPLITE = @as(c_int, 136);
pub const IPPROTO_MPLS = @as(c_int, 137);
pub const IPPROTO_PFSYNC = @as(c_int, 240);
pub const IPPROTO_RAW = @as(c_int, 255);
pub const IPPROTO_MAX = @as(c_int, 256);
pub const IPPROTO_DIVERT = @as(c_int, 258);
pub const IPPORT_RESERVED = @as(c_int, 1024);
pub const IPPORT_USERRESERVED = @import("std").zig.c_translation.promoteIntLiteral(c_int, 49151, .decimal);
pub const IPPORT_HIFIRSTAUTO = @import("std").zig.c_translation.promoteIntLiteral(c_int, 49152, .decimal);
pub const IPPORT_HILASTAUTO = @import("std").zig.c_translation.promoteIntLiteral(c_int, 65535, .decimal);
pub const _IN_ADDR_DECLARED = "";
pub const IPPROTO_DONE = @as(c_int, 257);
pub inline fn __IPADDR(x: anytype) u_int32_t {
    return @import("std").zig.c_translation.cast(u_int32_t, x);
}
pub inline fn IN_CLASSA(i: anytype) @TypeOf((@import("std").zig.c_translation.cast(u_int32_t, i) & __IPADDR(@import("std").zig.c_translation.promoteIntLiteral(c_int, 0x80000000, .hexadecimal))) == __IPADDR(@as(c_int, 0x00000000))) {
    return (@import("std").zig.c_translation.cast(u_int32_t, i) & __IPADDR(@import("std").zig.c_translation.promoteIntLiteral(c_int, 0x80000000, .hexadecimal))) == __IPADDR(@as(c_int, 0x00000000));
}
pub const IN_CLASSA_NET = __IPADDR(@import("std").zig.c_translation.promoteIntLiteral(c_int, 0xff000000, .hexadecimal));
pub const IN_CLASSA_NSHIFT = @as(c_int, 24);
pub const IN_CLASSA_HOST = __IPADDR(@import("std").zig.c_translation.promoteIntLiteral(c_int, 0x00ffffff, .hexadecimal));
pub const IN_CLASSA_MAX = @as(c_int, 128);
pub inline fn IN_CLASSB(i: anytype) @TypeOf((@import("std").zig.c_translation.cast(u_int32_t, i) & __IPADDR(@import("std").zig.c_translation.promoteIntLiteral(c_int, 0xc0000000, .hexadecimal))) == __IPADDR(@import("std").zig.c_translation.promoteIntLiteral(c_int, 0x80000000, .hexadecimal))) {
    return (@import("std").zig.c_translation.cast(u_int32_t, i) & __IPADDR(@import("std").zig.c_translation.promoteIntLiteral(c_int, 0xc0000000, .hexadecimal))) == __IPADDR(@import("std").zig.c_translation.promoteIntLiteral(c_int, 0x80000000, .hexadecimal));
}
pub const IN_CLASSB_NET = __IPADDR(@import("std").zig.c_translation.promoteIntLiteral(c_int, 0xffff0000, .hexadecimal));
pub const IN_CLASSB_NSHIFT = @as(c_int, 16);
pub const IN_CLASSB_HOST = __IPADDR(@import("std").zig.c_translation.promoteIntLiteral(c_int, 0x0000ffff, .hexadecimal));
pub const IN_CLASSB_MAX = @import("std").zig.c_translation.promoteIntLiteral(c_int, 65536, .decimal);
pub inline fn IN_CLASSC(i: anytype) @TypeOf((@import("std").zig.c_translation.cast(u_int32_t, i) & __IPADDR(@import("std").zig.c_translation.promoteIntLiteral(c_int, 0xe0000000, .hexadecimal))) == __IPADDR(@import("std").zig.c_translation.promoteIntLiteral(c_int, 0xc0000000, .hexadecimal))) {
    return (@import("std").zig.c_translation.cast(u_int32_t, i) & __IPADDR(@import("std").zig.c_translation.promoteIntLiteral(c_int, 0xe0000000, .hexadecimal))) == __IPADDR(@import("std").zig.c_translation.promoteIntLiteral(c_int, 0xc0000000, .hexadecimal));
}
pub const IN_CLASSC_NET = __IPADDR(@import("std").zig.c_translation.promoteIntLiteral(c_int, 0xffffff00, .hexadecimal));
pub const IN_CLASSC_NSHIFT = @as(c_int, 8);
pub const IN_CLASSC_HOST = __IPADDR(@as(c_int, 0x000000ff));
pub inline fn IN_CLASSD(i: anytype) @TypeOf((@import("std").zig.c_translation.cast(u_int32_t, i) & __IPADDR(@import("std").zig.c_translation.promoteIntLiteral(c_int, 0xf0000000, .hexadecimal))) == __IPADDR(@import("std").zig.c_translation.promoteIntLiteral(c_int, 0xe0000000, .hexadecimal))) {
    return (@import("std").zig.c_translation.cast(u_int32_t, i) & __IPADDR(@import("std").zig.c_translation.promoteIntLiteral(c_int, 0xf0000000, .hexadecimal))) == __IPADDR(@import("std").zig.c_translation.promoteIntLiteral(c_int, 0xe0000000, .hexadecimal));
}
pub const IN_CLASSD_NET = __IPADDR(@import("std").zig.c_translation.promoteIntLiteral(c_int, 0xf0000000, .hexadecimal));
pub const IN_CLASSD_NSHIFT = @as(c_int, 28);
pub const IN_CLASSD_HOST = __IPADDR(@import("std").zig.c_translation.promoteIntLiteral(c_int, 0x0fffffff, .hexadecimal));
pub inline fn IN_MULTICAST(i: anytype) @TypeOf(IN_CLASSD(i)) {
    return IN_CLASSD(i);
}
pub const IN_RFC3021_NET = __IPADDR(@import("std").zig.c_translation.promoteIntLiteral(c_int, 0xfffffffe, .hexadecimal));
pub const IN_RFC3021_NSHIFT = @as(c_int, 31);
pub const IN_RFC3021_HOST = __IPADDR(@as(c_int, 0x00000001));
pub inline fn IN_RFC3021_SUBNET(n: anytype) @TypeOf((@import("std").zig.c_translation.cast(u_int32_t, n) & IN_RFC3021_NET) == IN_RFC3021_NET) {
    return (@import("std").zig.c_translation.cast(u_int32_t, n) & IN_RFC3021_NET) == IN_RFC3021_NET;
}
pub inline fn IN_EXPERIMENTAL(i: anytype) @TypeOf((@import("std").zig.c_translation.cast(u_int32_t, i) & __IPADDR(@import("std").zig.c_translation.promoteIntLiteral(c_int, 0xf0000000, .hexadecimal))) == __IPADDR(@import("std").zig.c_translation.promoteIntLiteral(c_int, 0xf0000000, .hexadecimal))) {
    return (@import("std").zig.c_translation.cast(u_int32_t, i) & __IPADDR(@import("std").zig.c_translation.promoteIntLiteral(c_int, 0xf0000000, .hexadecimal))) == __IPADDR(@import("std").zig.c_translation.promoteIntLiteral(c_int, 0xf0000000, .hexadecimal));
}
pub inline fn IN_BADCLASS(i: anytype) @TypeOf((@import("std").zig.c_translation.cast(u_int32_t, i) & __IPADDR(@import("std").zig.c_translation.promoteIntLiteral(c_int, 0xf0000000, .hexadecimal))) == __IPADDR(@import("std").zig.c_translation.promoteIntLiteral(c_int, 0xf0000000, .hexadecimal))) {
    return (@import("std").zig.c_translation.cast(u_int32_t, i) & __IPADDR(@import("std").zig.c_translation.promoteIntLiteral(c_int, 0xf0000000, .hexadecimal))) == __IPADDR(@import("std").zig.c_translation.promoteIntLiteral(c_int, 0xf0000000, .hexadecimal));
}
pub inline fn IN_LOCAL_GROUP(i: anytype) @TypeOf((@import("std").zig.c_translation.cast(u_int32_t, i) & __IPADDR(@import("std").zig.c_translation.promoteIntLiteral(c_int, 0xffffff00, .hexadecimal))) == __IPADDR(@import("std").zig.c_translation.promoteIntLiteral(c_int, 0xe0000000, .hexadecimal))) {
    return (@import("std").zig.c_translation.cast(u_int32_t, i) & __IPADDR(@import("std").zig.c_translation.promoteIntLiteral(c_int, 0xffffff00, .hexadecimal))) == __IPADDR(@import("std").zig.c_translation.promoteIntLiteral(c_int, 0xe0000000, .hexadecimal));
}
pub const INADDR_ANY = __IPADDR(@as(c_int, 0x00000000));
pub const INADDR_LOOPBACK = __IPADDR(@import("std").zig.c_translation.promoteIntLiteral(c_int, 0x7f000001, .hexadecimal));
pub const INADDR_BROADCAST = __IPADDR(@import("std").zig.c_translation.promoteIntLiteral(c_int, 0xffffffff, .hexadecimal));
pub const INADDR_NONE = __IPADDR(@import("std").zig.c_translation.promoteIntLiteral(c_int, 0xffffffff, .hexadecimal));
pub const INADDR_UNSPEC_GROUP = __IPADDR(@import("std").zig.c_translation.promoteIntLiteral(c_int, 0xe0000000, .hexadecimal));
pub const INADDR_ALLHOSTS_GROUP = __IPADDR(@import("std").zig.c_translation.promoteIntLiteral(c_int, 0xe0000001, .hexadecimal));
pub const INADDR_ALLROUTERS_GROUP = __IPADDR(@import("std").zig.c_translation.promoteIntLiteral(c_int, 0xe0000002, .hexadecimal));
pub const INADDR_CARP_GROUP = __IPADDR(@import("std").zig.c_translation.promoteIntLiteral(c_int, 0xe0000012, .hexadecimal));
pub const INADDR_PFSYNC_GROUP = __IPADDR(@import("std").zig.c_translation.promoteIntLiteral(c_int, 0xe00000f0, .hexadecimal));
pub const INADDR_MAX_LOCAL_GROUP = __IPADDR(@import("std").zig.c_translation.promoteIntLiteral(c_int, 0xe00000ff, .hexadecimal));
pub const IN_LOOPBACKNET = @as(c_int, 127);
pub const IP_OPTIONS = @as(c_int, 1);
pub const IP_HDRINCL = @as(c_int, 2);
pub const IP_TOS = @as(c_int, 3);
pub const IP_TTL = @as(c_int, 4);
pub const IP_RECVOPTS = @as(c_int, 5);
pub const IP_RECVRETOPTS = @as(c_int, 6);
pub const IP_RECVDSTADDR = @as(c_int, 7);
pub const IP_RETOPTS = @as(c_int, 8);
pub const IP_MULTICAST_IF = @as(c_int, 9);
pub const IP_MULTICAST_TTL = @as(c_int, 10);
pub const IP_MULTICAST_LOOP = @as(c_int, 11);
pub const IP_ADD_MEMBERSHIP = @as(c_int, 12);
pub const IP_DROP_MEMBERSHIP = @as(c_int, 13);
pub const IP_PORTRANGE = @as(c_int, 19);
pub const IP_AUTH_LEVEL = @as(c_int, 20);
pub const IP_ESP_TRANS_LEVEL = @as(c_int, 21);
pub const IP_ESP_NETWORK_LEVEL = @as(c_int, 22);
pub const IP_IPSEC_LOCAL_ID = @as(c_int, 23);
pub const IP_IPSEC_REMOTE_ID = @as(c_int, 24);
pub const IP_IPSEC_LOCAL_CRED = @as(c_int, 25);
pub const IP_IPSEC_REMOTE_CRED = @as(c_int, 26);
pub const IP_IPSEC_LOCAL_AUTH = @as(c_int, 27);
pub const IP_IPSEC_REMOTE_AUTH = @as(c_int, 28);
pub const IP_IPCOMP_LEVEL = @as(c_int, 29);
pub const IP_RECVIF = @as(c_int, 30);
pub const IP_RECVTTL = @as(c_int, 31);
pub const IP_MINTTL = @as(c_int, 32);
pub const IP_RECVDSTPORT = @as(c_int, 33);
pub const IP_PIPEX = @as(c_int, 34);
pub const IP_RECVRTABLE = @as(c_int, 35);
pub const IP_IPSECFLOWINFO = @as(c_int, 36);
pub const IP_IPDEFTTL = @as(c_int, 37);
pub const IP_SENDSRCADDR = IP_RECVDSTADDR;
pub const IP_RTABLE = @as(c_int, 0x1021);
pub const IPSEC_LEVEL_BYPASS = @as(c_int, 0x00);
pub const IPSEC_LEVEL_NONE = @as(c_int, 0x00);
pub const IPSEC_LEVEL_AVAIL = @as(c_int, 0x01);
pub const IPSEC_LEVEL_USE = @as(c_int, 0x02);
pub const IPSEC_LEVEL_REQUIRE = @as(c_int, 0x03);
pub const IPSEC_LEVEL_UNIQUE = @as(c_int, 0x04);
pub const IPSEC_LEVEL_DEFAULT = IPSEC_LEVEL_AVAIL;
pub const IPSEC_AUTH_LEVEL_DEFAULT = IPSEC_LEVEL_DEFAULT;
pub const IPSEC_ESP_TRANS_LEVEL_DEFAULT = IPSEC_LEVEL_DEFAULT;
pub const IPSEC_ESP_NETWORK_LEVEL_DEFAULT = IPSEC_LEVEL_DEFAULT;
pub const IPSEC_IPCOMP_LEVEL_DEFAULT = IPSEC_LEVEL_DEFAULT;
pub const IP_DEFAULT_MULTICAST_TTL = @as(c_int, 1);
pub const IP_DEFAULT_MULTICAST_LOOP = @as(c_int, 1);
pub const IP_MIN_MEMBERSHIPS = @as(c_int, 15);
pub const IP_MAX_MEMBERSHIPS = @as(c_int, 4095);
pub const IP_PORTRANGE_DEFAULT = @as(c_int, 0);
pub const IP_PORTRANGE_HIGH = @as(c_int, 1);
pub const IP_PORTRANGE_LOW = @as(c_int, 2);
pub const INET_ADDRSTRLEN = @as(c_int, 16);
pub const IPPROTO_MAXID = IPPROTO_DIVERT + @as(c_int, 1);
pub const IPCTL_FORWARDING = @as(c_int, 1);
pub const IPCTL_SENDREDIRECTS = @as(c_int, 2);
pub const IPCTL_DEFTTL = @as(c_int, 3);
pub const IPCTL_SOURCEROUTE = @as(c_int, 5);
pub const IPCTL_DIRECTEDBCAST = @as(c_int, 6);
pub const IPCTL_IPPORT_FIRSTAUTO = @as(c_int, 7);
pub const IPCTL_IPPORT_LASTAUTO = @as(c_int, 8);
pub const IPCTL_IPPORT_HIFIRSTAUTO = @as(c_int, 9);
pub const IPCTL_IPPORT_HILASTAUTO = @as(c_int, 10);
pub const IPCTL_IPPORT_MAXQUEUE = @as(c_int, 11);
pub const IPCTL_ENCDEBUG = @as(c_int, 12);
pub const IPCTL_IPSEC_STATS = @as(c_int, 13);
pub const IPCTL_IPSEC_EXPIRE_ACQUIRE = @as(c_int, 14);
pub const IPCTL_IPSEC_EMBRYONIC_SA_TIMEOUT = @as(c_int, 15);
pub const IPCTL_IPSEC_REQUIRE_PFS = @as(c_int, 16);
pub const IPCTL_IPSEC_SOFT_ALLOCATIONS = @as(c_int, 17);
pub const IPCTL_IPSEC_ALLOCATIONS = @as(c_int, 18);
pub const IPCTL_IPSEC_SOFT_BYTES = @as(c_int, 19);
pub const IPCTL_IPSEC_BYTES = @as(c_int, 20);
pub const IPCTL_IPSEC_TIMEOUT = @as(c_int, 21);
pub const IPCTL_IPSEC_SOFT_TIMEOUT = @as(c_int, 22);
pub const IPCTL_IPSEC_SOFT_FIRSTUSE = @as(c_int, 23);
pub const IPCTL_IPSEC_FIRSTUSE = @as(c_int, 24);
pub const IPCTL_IPSEC_ENC_ALGORITHM = @as(c_int, 25);
pub const IPCTL_IPSEC_AUTH_ALGORITHM = @as(c_int, 26);
pub const IPCTL_MTUDISC = @as(c_int, 27);
pub const IPCTL_MTUDISCTIMEOUT = @as(c_int, 28);
pub const IPCTL_IPSEC_IPCOMP_ALGORITHM = @as(c_int, 29);
pub const IPCTL_IFQUEUE = @as(c_int, 30);
pub const IPCTL_MFORWARDING = @as(c_int, 31);
pub const IPCTL_MULTIPATH = @as(c_int, 32);
pub const IPCTL_STATS = @as(c_int, 33);
pub const IPCTL_MRTPROTO = @as(c_int, 34);
pub const IPCTL_MRTSTATS = @as(c_int, 35);
pub const IPCTL_ARPQUEUED = @as(c_int, 36);
pub const IPCTL_MRTMFC = @as(c_int, 37);
pub const IPCTL_MRTVIF = @as(c_int, 38);
pub const IPCTL_ARPTIMEOUT = @as(c_int, 39);
pub const IPCTL_ARPDOWN = @as(c_int, 40);
pub const IPCTL_ARPQUEUE = @as(c_int, 41);
pub const IPCTL_MAXID = @as(c_int, 42);
pub const __KAME_NETINET_IN_H_INCLUDED_ = "";
pub const _NETINET6_IN6_H_ = "";
pub const __KAME__ = "";
pub const INET6_ADDRSTRLEN = @as(c_int, 46);
pub const SIN6_LEN = "";
pub const __IPV6_ADDR_INT32_ONE = htonl(@as(c_int, 1));
pub const __IPV6_ADDR_INT32_TWO = htonl(@as(c_int, 2));
pub const __IPV6_ADDR_INT32_MNL = htonl(@import("std").zig.c_translation.promoteIntLiteral(c_int, 0xff010000, .hexadecimal));
pub const __IPV6_ADDR_INT32_MLL = htonl(@import("std").zig.c_translation.promoteIntLiteral(c_int, 0xff020000, .hexadecimal));
pub const __IPV6_ADDR_INT32_SMP = htonl(@import("std").zig.c_translation.promoteIntLiteral(c_int, 0x0000ffff, .hexadecimal));
pub const __IPV6_ADDR_INT16_ULL = htons(@import("std").zig.c_translation.promoteIntLiteral(c_int, 0xfe80, .hexadecimal));
pub const __IPV6_ADDR_INT16_USL = htons(@import("std").zig.c_translation.promoteIntLiteral(c_int, 0xfec0, .hexadecimal));
pub const __IPV6_ADDR_INT16_MLL = htons(@import("std").zig.c_translation.promoteIntLiteral(c_int, 0xff02, .hexadecimal));
pub inline fn IN6_IS_ADDR_LINKLOCAL(a: anytype) @TypeOf((a.*.s6_addr[@as(usize, @intCast(@as(c_int, 0)))] == @as(c_int, 0xfe)) and ((a.*.s6_addr[@as(usize, @intCast(@as(c_int, 1)))] & @as(c_int, 0xc0)) == @as(c_int, 0x80))) {
    return (a.*.s6_addr[@as(usize, @intCast(@as(c_int, 0)))] == @as(c_int, 0xfe)) and ((a.*.s6_addr[@as(usize, @intCast(@as(c_int, 1)))] & @as(c_int, 0xc0)) == @as(c_int, 0x80));
}
pub inline fn IN6_IS_ADDR_SITELOCAL(a: anytype) @TypeOf((a.*.s6_addr[@as(usize, @intCast(@as(c_int, 0)))] == @as(c_int, 0xfe)) and ((a.*.s6_addr[@as(usize, @intCast(@as(c_int, 1)))] & @as(c_int, 0xc0)) == @as(c_int, 0xc0))) {
    return (a.*.s6_addr[@as(usize, @intCast(@as(c_int, 0)))] == @as(c_int, 0xfe)) and ((a.*.s6_addr[@as(usize, @intCast(@as(c_int, 1)))] & @as(c_int, 0xc0)) == @as(c_int, 0xc0));
}
pub inline fn __IPV6_ADDR_MC_SCOPE(a: anytype) @TypeOf(a.*.s6_addr[@as(usize, @intCast(@as(c_int, 1)))] & @as(c_int, 0x0f)) {
    return a.*.s6_addr[@as(usize, @intCast(@as(c_int, 1)))] & @as(c_int, 0x0f);
}
pub inline fn IN6_IS_ADDR_MULTICAST(a: anytype) @TypeOf(a.*.s6_addr[@as(usize, @intCast(@as(c_int, 0)))] == @as(c_int, 0xff)) {
    return a.*.s6_addr[@as(usize, @intCast(@as(c_int, 0)))] == @as(c_int, 0xff);
}
pub const __IPV6_ADDR_SCOPE_NODELOCAL = @as(c_int, 0x01);
pub const __IPV6_ADDR_SCOPE_INTFACELOCAL = @as(c_int, 0x01);
pub const __IPV6_ADDR_SCOPE_LINKLOCAL = @as(c_int, 0x02);
pub const __IPV6_ADDR_SCOPE_SITELOCAL = @as(c_int, 0x05);
pub const __IPV6_ADDR_SCOPE_ORGLOCAL = @as(c_int, 0x08);
pub const __IPV6_ADDR_SCOPE_GLOBAL = @as(c_int, 0x0e);
pub inline fn IN6_IS_ADDR_MC_NODELOCAL(a: anytype) @TypeOf((IN6_IS_ADDR_MULTICAST(a) != 0) and (__IPV6_ADDR_MC_SCOPE(a) == __IPV6_ADDR_SCOPE_NODELOCAL)) {
    return (IN6_IS_ADDR_MULTICAST(a) != 0) and (__IPV6_ADDR_MC_SCOPE(a) == __IPV6_ADDR_SCOPE_NODELOCAL);
}
pub inline fn IN6_IS_ADDR_MC_INTFACELOCAL(a: anytype) @TypeOf((IN6_IS_ADDR_MULTICAST(a) != 0) and (__IPV6_ADDR_MC_SCOPE(a) == __IPV6_ADDR_SCOPE_INTFACELOCAL)) {
    return (IN6_IS_ADDR_MULTICAST(a) != 0) and (__IPV6_ADDR_MC_SCOPE(a) == __IPV6_ADDR_SCOPE_INTFACELOCAL);
}
pub inline fn IN6_IS_ADDR_MC_LINKLOCAL(a: anytype) @TypeOf((IN6_IS_ADDR_MULTICAST(a) != 0) and (__IPV6_ADDR_MC_SCOPE(a) == __IPV6_ADDR_SCOPE_LINKLOCAL)) {
    return (IN6_IS_ADDR_MULTICAST(a) != 0) and (__IPV6_ADDR_MC_SCOPE(a) == __IPV6_ADDR_SCOPE_LINKLOCAL);
}
pub inline fn IN6_IS_ADDR_MC_SITELOCAL(a: anytype) @TypeOf((IN6_IS_ADDR_MULTICAST(a) != 0) and (__IPV6_ADDR_MC_SCOPE(a) == __IPV6_ADDR_SCOPE_SITELOCAL)) {
    return (IN6_IS_ADDR_MULTICAST(a) != 0) and (__IPV6_ADDR_MC_SCOPE(a) == __IPV6_ADDR_SCOPE_SITELOCAL);
}
pub inline fn IN6_IS_ADDR_MC_ORGLOCAL(a: anytype) @TypeOf((IN6_IS_ADDR_MULTICAST(a) != 0) and (__IPV6_ADDR_MC_SCOPE(a) == __IPV6_ADDR_SCOPE_ORGLOCAL)) {
    return (IN6_IS_ADDR_MULTICAST(a) != 0) and (__IPV6_ADDR_MC_SCOPE(a) == __IPV6_ADDR_SCOPE_ORGLOCAL);
}
pub inline fn IN6_IS_ADDR_MC_GLOBAL(a: anytype) @TypeOf((IN6_IS_ADDR_MULTICAST(a) != 0) and (__IPV6_ADDR_MC_SCOPE(a) == __IPV6_ADDR_SCOPE_GLOBAL)) {
    return (IN6_IS_ADDR_MULTICAST(a) != 0) and (__IPV6_ADDR_MC_SCOPE(a) == __IPV6_ADDR_SCOPE_GLOBAL);
}
pub const IPV6_UNICAST_HOPS = @as(c_int, 4);
pub const IPV6_MULTICAST_IF = @as(c_int, 9);
pub const IPV6_MULTICAST_HOPS = @as(c_int, 10);
pub const IPV6_MULTICAST_LOOP = @as(c_int, 11);
pub const IPV6_JOIN_GROUP = @as(c_int, 12);
pub const IPV6_LEAVE_GROUP = @as(c_int, 13);
pub const IPV6_PORTRANGE = @as(c_int, 14);
pub const ICMP6_FILTER = @as(c_int, 18);
pub const IPV6_CHECKSUM = @as(c_int, 26);
pub const IPV6_V6ONLY = @as(c_int, 27);
pub const IPV6_RTHDRDSTOPTS = @as(c_int, 35);
pub const IPV6_RECVPKTINFO = @as(c_int, 36);
pub const IPV6_RECVHOPLIMIT = @as(c_int, 37);
pub const IPV6_RECVRTHDR = @as(c_int, 38);
pub const IPV6_RECVHOPOPTS = @as(c_int, 39);
pub const IPV6_RECVDSTOPTS = @as(c_int, 40);
pub const IPV6_USE_MIN_MTU = @as(c_int, 42);
pub const IPV6_RECVPATHMTU = @as(c_int, 43);
pub const IPV6_PATHMTU = @as(c_int, 44);
pub const IPV6_PKTINFO = @as(c_int, 46);
pub const IPV6_HOPLIMIT = @as(c_int, 47);
pub const IPV6_NEXTHOP = @as(c_int, 48);
pub const IPV6_HOPOPTS = @as(c_int, 49);
pub const IPV6_DSTOPTS = @as(c_int, 50);
pub const IPV6_RTHDR = @as(c_int, 51);
pub const IPV6_AUTH_LEVEL = @as(c_int, 53);
pub const IPV6_ESP_TRANS_LEVEL = @as(c_int, 54);
pub const IPV6_ESP_NETWORK_LEVEL = @as(c_int, 55);
pub const IPSEC6_OUTSA = @as(c_int, 56);
pub const IPV6_RECVTCLASS = @as(c_int, 57);
pub const IPV6_AUTOFLOWLABEL = @as(c_int, 59);
pub const IPV6_IPCOMP_LEVEL = @as(c_int, 60);
pub const IPV6_TCLASS = @as(c_int, 61);
pub const IPV6_DONTFRAG = @as(c_int, 62);
pub const IPV6_PIPEX = @as(c_int, 63);
pub const IPV6_RECVDSTPORT = @as(c_int, 64);
pub const IPV6_MINHOPCOUNT = @as(c_int, 65);
pub const IPV6_RTABLE = @as(c_int, 0x1021);
pub const IPV6_RTHDR_LOOSE = @as(c_int, 0);
pub const IPV6_RTHDR_TYPE_0 = @as(c_int, 0);
pub const IPV6_DEFAULT_MULTICAST_HOPS = @as(c_int, 1);
pub const IPV6_DEFAULT_MULTICAST_LOOP = @as(c_int, 1);
pub const IPV6_PORTRANGE_DEFAULT = @as(c_int, 0);
pub const IPV6_PORTRANGE_HIGH = @as(c_int, 1);
pub const IPV6_PORTRANGE_LOW = @as(c_int, 2);
pub const IPV6PROTO_MAXID = IPPROTO_DIVERT + @as(c_int, 1);
pub const IPV6CTL_FORWARDING = @as(c_int, 1);
pub const IPV6CTL_SENDREDIRECTS = @as(c_int, 2);
pub const IPV6CTL_DEFHLIM = @as(c_int, 3);
pub const IPV6CTL_FORWSRCRT = @as(c_int, 5);
pub const IPV6CTL_STATS = @as(c_int, 6);
pub const IPV6CTL_MRTSTATS = @as(c_int, 7);
pub const IPV6CTL_MRTPROTO = @as(c_int, 8);
pub const IPV6CTL_MAXFRAGPACKETS = @as(c_int, 9);
pub const IPV6CTL_SOURCECHECK = @as(c_int, 10);
pub const IPV6CTL_SOURCECHECK_LOGINT = @as(c_int, 11);
pub const IPV6CTL_ACCEPT_RTADV = @as(c_int, 12);
pub const IPV6CTL_LOG_INTERVAL = @as(c_int, 14);
pub const IPV6CTL_HDRNESTLIMIT = @as(c_int, 15);
pub const IPV6CTL_DAD_COUNT = @as(c_int, 16);
pub const IPV6CTL_AUTO_FLOWLABEL = @as(c_int, 17);
pub const IPV6CTL_DEFMCASTHLIM = @as(c_int, 18);
pub const IPV6CTL_USE_DEPRECATED = @as(c_int, 21);
pub const IPV6CTL_MAXFRAGS = @as(c_int, 41);
pub const IPV6CTL_MFORWARDING = @as(c_int, 42);
pub const IPV6CTL_MULTIPATH = @as(c_int, 43);
pub const IPV6CTL_MCAST_PMTU = @as(c_int, 44);
pub const IPV6CTL_NEIGHBORGCTHRESH = @as(c_int, 45);
pub const IPV6CTL_MAXDYNROUTES = @as(c_int, 48);
pub const IPV6CTL_DAD_PENDING = @as(c_int, 49);
pub const IPV6CTL_MTUDISCTIMEOUT = @as(c_int, 50);
pub const IPV6CTL_IFQUEUE = @as(c_int, 51);
pub const IPV6CTL_MRTMIF = @as(c_int, 52);
pub const IPV6CTL_MRTMFC = @as(c_int, 53);
pub const IPV6CTL_SOIIKEY = @as(c_int, 54);
pub const IPV6CTL_MAXID = @as(c_int, 55);
pub const _NETINET_TCP_H_ = "";
pub const TH_FIN = @as(c_int, 0x01);
pub const TH_SYN = @as(c_int, 0x02);
pub const TH_RST = @as(c_int, 0x04);
pub const TH_PUSH = @as(c_int, 0x08);
pub const TH_ACK = @as(c_int, 0x10);
pub const TH_URG = @as(c_int, 0x20);
pub const TH_ECE = @as(c_int, 0x40);
pub const TH_CWR = @as(c_int, 0x80);
pub const TCPOPT_EOL = @as(c_int, 0);
pub const TCPOPT_NOP = @as(c_int, 1);
pub const TCPOPT_MAXSEG = @as(c_int, 2);
pub const TCPOLEN_MAXSEG = @as(c_int, 4);
pub const TCPOPT_WINDOW = @as(c_int, 3);
pub const TCPOLEN_WINDOW = @as(c_int, 3);
pub const TCPOPT_SACK_PERMITTED = @as(c_int, 4);
pub const TCPOLEN_SACK_PERMITTED = @as(c_int, 2);
pub const TCPOPT_SACK = @as(c_int, 5);
pub const TCPOLEN_SACK = @as(c_int, 8);
pub const TCPOPT_TIMESTAMP = @as(c_int, 8);
pub const TCPOLEN_TIMESTAMP = @as(c_int, 10);
pub const TCPOLEN_TSTAMP_APPA = TCPOLEN_TIMESTAMP + @as(c_int, 2);
pub const TCPOPT_SIGNATURE = @as(c_int, 19);
pub const TCPOLEN_SIGNATURE = @as(c_int, 18);
pub const TCPOLEN_SIGLEN = TCPOLEN_SIGNATURE + @as(c_int, 2);
pub const MAX_TCPOPTLEN = @as(c_int, 40);
pub const TCPOPT_TSTAMP_HDR = (((TCPOPT_NOP << @as(c_int, 24)) | (TCPOPT_NOP << @as(c_int, 16))) | (TCPOPT_TIMESTAMP << @as(c_int, 8))) | TCPOLEN_TIMESTAMP;
pub const TCPOPT_SACK_PERMIT_HDR = (((TCPOPT_NOP << @as(c_int, 24)) | (TCPOPT_NOP << @as(c_int, 16))) | (TCPOPT_SACK_PERMITTED << @as(c_int, 8))) | TCPOLEN_SACK_PERMITTED;
pub const TCPOPT_SACK_HDR = ((TCPOPT_NOP << @as(c_int, 24)) | (TCPOPT_NOP << @as(c_int, 16))) | (TCPOPT_SACK << @as(c_int, 8));
pub const MAX_SACK_BLKS = @as(c_int, 6);
pub const TCP_MAX_SACK = @as(c_int, 3);
pub const TCP_SACKHOLE_LIMIT = @as(c_int, 128);
pub const TCP_MSS = @as(c_int, 512);
pub const TCP_MAXWIN = @import("std").zig.c_translation.promoteIntLiteral(c_int, 65535, .decimal);
pub const TCP_MAX_WINSHIFT = @as(c_int, 14);
pub const TCPI_OPT_TIMESTAMPS = @as(c_int, 0x01);
pub const TCPI_OPT_SACK = @as(c_int, 0x02);
pub const TCPI_OPT_WSCALE = @as(c_int, 0x04);
pub const TCPI_OPT_ECN = @as(c_int, 0x08);
pub const TCPI_OPT_TOE = @as(c_int, 0x10);
pub const TCP_NODELAY = @as(c_int, 0x01);
pub const TCP_MAXSEG = @as(c_int, 0x02);
pub const TCP_MD5SIG = @as(c_int, 0x04);
pub const TCP_SACK_ENABLE = @as(c_int, 0x08);
pub const TCP_INFO = @as(c_int, 0x09);
pub const TCP_NOPUSH = @as(c_int, 0x10);
pub const _INET_H_ = "";
pub const _NETDB_H_ = "";
pub const _PATH_HEQUIV = "/etc/hosts.equiv";
pub const _PATH_HOSTS = "/etc/hosts";
pub const _PATH_NETWORKS = "/etc/networks";
pub const _PATH_PROTOCOLS = "/etc/protocols";
pub const _PATH_SERVICES = "/etc/services";
pub const NETDB_INTERNAL = -@as(c_int, 1);
pub const NETDB_SUCCESS = @as(c_int, 0);
pub const HOST_NOT_FOUND = @as(c_int, 1);
pub const TRY_AGAIN = @as(c_int, 2);
pub const NO_RECOVERY = @as(c_int, 3);
pub const NO_DATA = @as(c_int, 4);
pub const NO_ADDRESS = NO_DATA;
pub const AI_PASSIVE = @as(c_int, 1);
pub const AI_CANONNAME = @as(c_int, 2);
pub const AI_NUMERICHOST = @as(c_int, 4);
pub const AI_EXT = @as(c_int, 8);
pub const AI_NUMERICSERV = @as(c_int, 16);
pub const AI_FQDN = @as(c_int, 32);
pub const AI_ADDRCONFIG = @as(c_int, 64);
pub const AI_MASK = ((((AI_PASSIVE | AI_CANONNAME) | AI_NUMERICHOST) | AI_NUMERICSERV) | AI_FQDN) | AI_ADDRCONFIG;
pub const NI_NUMERICHOST = @as(c_int, 1);
pub const NI_NUMERICSERV = @as(c_int, 2);
pub const NI_NOFQDN = @as(c_int, 4);
pub const NI_NAMEREQD = @as(c_int, 8);
pub const NI_DGRAM = @as(c_int, 16);
pub const NI_MAXHOST = @as(c_int, 256);
pub const NI_MAXSERV = @as(c_int, 32);
pub const SCOPE_DELIMITER = '%';
pub const EAI_BADFLAGS = -@as(c_int, 1);
pub const EAI_NONAME = -@as(c_int, 2);
pub const EAI_AGAIN = -@as(c_int, 3);
pub const EAI_FAIL = -@as(c_int, 4);
pub const EAI_NODATA = -@as(c_int, 5);
pub const EAI_FAMILY = -@as(c_int, 6);
pub const EAI_SOCKTYPE = -@as(c_int, 7);
pub const EAI_SERVICE = -@as(c_int, 8);
pub const EAI_ADDRFAMILY = -@as(c_int, 9);
pub const EAI_MEMORY = -@as(c_int, 10);
pub const EAI_SYSTEM = -@as(c_int, 11);
pub const EAI_BADHINTS = -@as(c_int, 12);
pub const EAI_PROTOCOL = -@as(c_int, 13);
pub const EAI_OVERFLOW = -@as(c_int, 14);
pub const RRSET_VALIDATED = @as(c_int, 1);
pub const ERRSET_SUCCESS = @as(c_int, 0);
pub const ERRSET_NOMEMORY = @as(c_int, 1);
pub const ERRSET_FAIL = @as(c_int, 2);
pub const ERRSET_INVAL = @as(c_int, 3);
pub const ERRSET_NONAME = @as(c_int, 4);
pub const ERRSET_NODATA = @as(c_int, 5);
pub const _SYS_TERMIOS_H_ = "";
pub const VEOF = @as(c_int, 0);
pub const VEOL = @as(c_int, 1);
pub const VEOL2 = @as(c_int, 2);
pub const VERASE = @as(c_int, 3);
pub const VWERASE = @as(c_int, 4);
pub const VKILL = @as(c_int, 5);
pub const VREPRINT = @as(c_int, 6);
pub const VINTR = @as(c_int, 8);
pub const VQUIT = @as(c_int, 9);
pub const VSUSP = @as(c_int, 10);
pub const VDSUSP = @as(c_int, 11);
pub const VSTART = @as(c_int, 12);
pub const VSTOP = @as(c_int, 13);
pub const VLNEXT = @as(c_int, 14);
pub const VDISCARD = @as(c_int, 15);
pub const VMIN = @as(c_int, 16);
pub const VTIME = @as(c_int, 17);
pub const VSTATUS = @as(c_int, 18);
pub const NCCS = @as(c_int, 20);
pub const _POSIX_VDISABLE = @as(c_int, 0o377);
pub inline fn CCEQ(val: anytype, c: anytype) @TypeOf(if (c == val) val != _POSIX_VDISABLE else @as(c_int, 0)) {
    return if (c == val) val != _POSIX_VDISABLE else @as(c_int, 0);
}
pub const IGNBRK = @as(c_int, 0x00000001);
pub const BRKINT = @as(c_int, 0x00000002);
pub const IGNPAR = @as(c_int, 0x00000004);
pub const PARMRK = @as(c_int, 0x00000008);
pub const INPCK = @as(c_int, 0x00000010);
pub const ISTRIP = @as(c_int, 0x00000020);
pub const INLCR = @as(c_int, 0x00000040);
pub const IGNCR = @as(c_int, 0x00000080);
pub const ICRNL = @as(c_int, 0x00000100);
pub const IXON = @as(c_int, 0x00000200);
pub const IXOFF = @as(c_int, 0x00000400);
pub const IXANY = @as(c_int, 0x00000800);
pub const IUCLC = @as(c_int, 0x00001000);
pub const IMAXBEL = @as(c_int, 0x00002000);
pub const OPOST = @as(c_int, 0x00000001);
pub const ONLCR = @as(c_int, 0x00000002);
pub const TABDLY = @as(c_int, 0x00000004);
pub const TAB0 = @as(c_int, 0x00000000);
pub const TAB3 = @as(c_int, 0x00000004);
pub const OXTABS = TAB3;
pub const ONOEOT = @as(c_int, 0x00000008);
pub const OCRNL = @as(c_int, 0x00000010);
pub const OLCUC = @as(c_int, 0x00000020);
pub const ONOCR = @as(c_int, 0x00000040);
pub const ONLRET = @as(c_int, 0x00000080);
pub const CIGNORE = @as(c_int, 0x00000001);
pub const CSIZE = @as(c_int, 0x00000300);
pub const CS5 = @as(c_int, 0x00000000);
pub const CS6 = @as(c_int, 0x00000100);
pub const CS7 = @as(c_int, 0x00000200);
pub const CS8 = @as(c_int, 0x00000300);
pub const CSTOPB = @as(c_int, 0x00000400);
pub const CREAD = @as(c_int, 0x00000800);
pub const PARENB = @as(c_int, 0x00001000);
pub const PARODD = @as(c_int, 0x00002000);
pub const HUPCL = @as(c_int, 0x00004000);
pub const CLOCAL = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x00008000, .hexadecimal);
pub const CRTSCTS = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x00010000, .hexadecimal);
pub const CRTS_IFLOW = CRTSCTS;
pub const CCTS_OFLOW = CRTSCTS;
pub const MDMBUF = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x00100000, .hexadecimal);
pub const CHWFLOW = MDMBUF | CRTSCTS;
pub const ECHOKE = @as(c_int, 0x00000001);
pub const ECHOE = @as(c_int, 0x00000002);
pub const ECHOK = @as(c_int, 0x00000004);
pub const ECHO = @as(c_int, 0x00000008);
pub const ECHONL = @as(c_int, 0x00000010);
pub const ECHOPRT = @as(c_int, 0x00000020);
pub const ECHOCTL = @as(c_int, 0x00000040);
pub const ISIG = @as(c_int, 0x00000080);
pub const ICANON = @as(c_int, 0x00000100);
pub const ALTWERASE = @as(c_int, 0x00000200);
pub const IEXTEN = @as(c_int, 0x00000400);
pub const EXTPROC = @as(c_int, 0x00000800);
pub const TOSTOP = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x00400000, .hexadecimal);
pub const FLUSHO = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x00800000, .hexadecimal);
pub const XCASE = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x01000000, .hexadecimal);
pub const NOKERNINFO = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x02000000, .hexadecimal);
pub const PENDIN = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x20000000, .hexadecimal);
pub const NOFLSH = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x80000000, .hexadecimal);
pub const TCSANOW = @as(c_int, 0);
pub const TCSADRAIN = @as(c_int, 1);
pub const TCSAFLUSH = @as(c_int, 2);
pub const TCSASOFT = @as(c_int, 0x10);
pub const B0 = @as(c_int, 0);
pub const B50 = @as(c_int, 50);
pub const B75 = @as(c_int, 75);
pub const B110 = @as(c_int, 110);
pub const B134 = @as(c_int, 134);
pub const B150 = @as(c_int, 150);
pub const B200 = @as(c_int, 200);
pub const B300 = @as(c_int, 300);
pub const B600 = @as(c_int, 600);
pub const B1200 = @as(c_int, 1200);
pub const B1800 = @as(c_int, 1800);
pub const B2400 = @as(c_int, 2400);
pub const B4800 = @as(c_int, 4800);
pub const B9600 = @as(c_int, 9600);
pub const B19200 = @as(c_int, 19200);
pub const B38400 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 38400, .decimal);
pub const B7200 = @as(c_int, 7200);
pub const B14400 = @as(c_int, 14400);
pub const B28800 = @as(c_int, 28800);
pub const B57600 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 57600, .decimal);
pub const B76800 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 76800, .decimal);
pub const B115200 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 115200, .decimal);
pub const B230400 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 230400, .decimal);
pub const EXTA = @as(c_int, 19200);
pub const EXTB = @import("std").zig.c_translation.promoteIntLiteral(c_int, 38400, .decimal);
pub const TCIFLUSH = @as(c_int, 1);
pub const TCOFLUSH = @as(c_int, 2);
pub const TCIOFLUSH = @as(c_int, 3);
pub const TCOOFF = @as(c_int, 1);
pub const TCOON = @as(c_int, 2);
pub const TCIOFF = @as(c_int, 3);
pub const TCION = @as(c_int, 4);
pub const _SYS_TTYCOM_H_ = "";
pub const _SYS_IOCCOM_H_ = "";
pub const IOCPARM_MASK = @as(c_int, 0x1fff);
pub inline fn IOCPARM_LEN(x: anytype) @TypeOf((x >> @as(c_int, 16)) & IOCPARM_MASK) {
    return (x >> @as(c_int, 16)) & IOCPARM_MASK;
}
pub inline fn IOCBASECMD(x: anytype) @TypeOf(x & ~(IOCPARM_MASK << @as(c_int, 16))) {
    return x & ~(IOCPARM_MASK << @as(c_int, 16));
}
pub inline fn IOCGROUP(x: anytype) @TypeOf((x >> @as(c_int, 8)) & @as(c_int, 0xff)) {
    return (x >> @as(c_int, 8)) & @as(c_int, 0xff);
}
pub const IOCPARM_MAX = PAGE_SIZE;
pub const IOC_VOID = @import("std").zig.c_translation.cast(c_ulong, @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x20000000, .hexadecimal));
pub const IOC_OUT = @import("std").zig.c_translation.cast(c_ulong, @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x40000000, .hexadecimal));
pub const IOC_IN = @import("std").zig.c_translation.cast(c_ulong, @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x80000000, .hexadecimal));
pub const IOC_INOUT = IOC_IN | IOC_OUT;
pub const IOC_DIRMASK = @import("std").zig.c_translation.cast(c_ulong, @import("std").zig.c_translation.promoteIntLiteral(c_int, 0xe0000000, .hexadecimal));
pub inline fn _IOC(inout: anytype, group: anytype, num: anytype, len: anytype) @TypeOf(((inout | ((len & IOCPARM_MASK) << @as(c_int, 16))) | (group << @as(c_int, 8))) | num) {
    return ((inout | ((len & IOCPARM_MASK) << @as(c_int, 16))) | (group << @as(c_int, 8))) | num;
}
pub inline fn _IO(g: anytype, n: anytype) @TypeOf(_IOC(IOC_VOID, g, n, @as(c_int, 0))) {
    return _IOC(IOC_VOID, g, n, @as(c_int, 0));
}
pub inline fn _IOR(g: anytype, n: anytype, t: anytype) @TypeOf(_IOC(IOC_OUT, g, n, @import("std").zig.c_translation.sizeof(t))) {
    _ = @TypeOf(t);
    return _IOC(IOC_OUT, g, n, @import("std").zig.c_translation.sizeof(t));
}
pub inline fn _IOW(g: anytype, n: anytype, t: anytype) @TypeOf(_IOC(IOC_IN, g, n, @import("std").zig.c_translation.sizeof(t))) {
    _ = @TypeOf(t);
    return _IOC(IOC_IN, g, n, @import("std").zig.c_translation.sizeof(t));
}
pub inline fn _IOWR(g: anytype, n: anytype, t: anytype) @TypeOf(_IOC(IOC_INOUT, g, n, @import("std").zig.c_translation.sizeof(t))) {
    _ = @TypeOf(t);
    return _IOC(IOC_INOUT, g, n, @import("std").zig.c_translation.sizeof(t));
}
pub const TIOCM_LE = @as(c_int, 0o001);
pub const TIOCM_DTR = @as(c_int, 0o002);
pub const TIOCM_RTS = @as(c_int, 0o004);
pub const TIOCM_ST = @as(c_int, 0o010);
pub const TIOCM_SR = @as(c_int, 0o020);
pub const TIOCM_CTS = @as(c_int, 0o040);
pub const TIOCM_CAR = @as(c_int, 0o100);
pub const TIOCM_CD = TIOCM_CAR;
pub const TIOCM_RNG = @as(c_int, 0o200);
pub const TIOCM_RI = TIOCM_RNG;
pub const TIOCM_DSR = @as(c_int, 0o400);
pub const TIOCEXCL = _IO('t', @as(c_int, 13));
pub const TIOCNXCL = _IO('t', @as(c_int, 14));
pub const TIOCFLUSH = _IOW('t', @as(c_int, 16), c_int);
pub const TIOCGETA = _IOR('t', @as(c_int, 19), struct_termios);
pub const TIOCSETA = _IOW('t', @as(c_int, 20), struct_termios);
pub const TIOCSETAW = _IOW('t', @as(c_int, 21), struct_termios);
pub const TIOCSETAF = _IOW('t', @as(c_int, 22), struct_termios);
pub const TIOCGETD = _IOR('t', @as(c_int, 26), c_int);
pub const TIOCSETD = _IOW('t', @as(c_int, 27), c_int);
pub const TIOCSETVERAUTH = _IOW('t', @as(c_int, 28), c_int);
pub const TIOCCLRVERAUTH = _IO('t', @as(c_int, 29));
pub const TIOCCHKVERAUTH = _IO('t', @as(c_int, 30));
pub const TIOCSBRK = _IO('t', @as(c_int, 123));
pub const TIOCCBRK = _IO('t', @as(c_int, 122));
pub const TIOCSDTR = _IO('t', @as(c_int, 121));
pub const TIOCCDTR = _IO('t', @as(c_int, 120));
pub const TIOCGPGRP = _IOR('t', @as(c_int, 119), c_int);
pub const TIOCSPGRP = _IOW('t', @as(c_int, 118), c_int);
pub const TIOCOUTQ = _IOR('t', @as(c_int, 115), c_int);
pub const TIOCNOTTY = _IO('t', @as(c_int, 113));
pub const TIOCPKT = _IOW('t', @as(c_int, 112), c_int);
pub const TIOCPKT_DATA = @as(c_int, 0x00);
pub const TIOCPKT_FLUSHREAD = @as(c_int, 0x01);
pub const TIOCPKT_FLUSHWRITE = @as(c_int, 0x02);
pub const TIOCPKT_STOP = @as(c_int, 0x04);
pub const TIOCPKT_START = @as(c_int, 0x08);
pub const TIOCPKT_NOSTOP = @as(c_int, 0x10);
pub const TIOCPKT_DOSTOP = @as(c_int, 0x20);
pub const TIOCPKT_IOCTL = @as(c_int, 0x40);
pub const TIOCSTOP = _IO('t', @as(c_int, 111));
pub const TIOCSTART = _IO('t', @as(c_int, 110));
pub const TIOCMSET = _IOW('t', @as(c_int, 109), c_int);
pub const TIOCMBIS = _IOW('t', @as(c_int, 108), c_int);
pub const TIOCMBIC = _IOW('t', @as(c_int, 107), c_int);
pub const TIOCMGET = _IOR('t', @as(c_int, 106), c_int);
pub const TIOCREMOTE = _IOW('t', @as(c_int, 105), c_int);
pub const TIOCGWINSZ = _IOR('t', @as(c_int, 104), struct_winsize);
pub const TIOCSWINSZ = _IOW('t', @as(c_int, 103), struct_winsize);
pub const TIOCUCNTL = _IOW('t', @as(c_int, 102), c_int);
pub inline fn UIOCCMD(n: anytype) @TypeOf(_IO('u', n)) {
    return _IO('u', n);
}
pub const TIOCUCNTL_SBRK = TIOCSBRK & @as(c_int, 0xff);
pub const TIOCUCNTL_CBRK = TIOCCBRK & @as(c_int, 0xff);
pub const TIOCSTAT = _IO('t', @as(c_int, 101));
pub const TIOCGSID = _IOR('t', @as(c_int, 99), c_int);
pub const TIOCCONS = _IOW('t', @as(c_int, 98), c_int);
pub const TIOCSCTTY = _IO('t', @as(c_int, 97));
pub const TIOCEXT = _IOW('t', @as(c_int, 96), c_int);
pub const TIOCSIG = _IOW('t', @as(c_int, 95), c_int);
pub const TIOCDRAIN = _IO('t', @as(c_int, 94));
pub const TIOCGFLAGS = _IOR('t', @as(c_int, 93), c_int);
pub const TIOCSFLAGS = _IOW('t', @as(c_int, 92), c_int);
pub const TIOCFLAG_SOFTCAR = @as(c_int, 0x01);
pub const TIOCFLAG_CLOCAL = @as(c_int, 0x02);
pub const TIOCFLAG_CRTSCTS = @as(c_int, 0x04);
pub const TIOCFLAG_MDMBUF = @as(c_int, 0x08);
pub const TIOCFLAG_PPS = @as(c_int, 0x10);
pub const TIOCGTSTAMP = _IOR('t', @as(c_int, 91), struct_timeval);
pub const TIOCSTSTAMP = _IOW('t', @as(c_int, 90), struct_tstamps);
pub const TIOCMODG = TIOCMGET;
pub const TIOCMODS = TIOCMSET;
pub const TTYDISC = @as(c_int, 0);
pub const TABLDISC = @as(c_int, 3);
pub const SLIPDISC = @as(c_int, 4);
pub const PPPDISC = @as(c_int, 5);
pub const STRIPDISC = @as(c_int, 6);
pub const NMEADISC = @as(c_int, 7);
pub const MSTSDISC = @as(c_int, 8);
pub const ENDRUNDISC = @as(c_int, 9);
pub const _SYS_TTYDEFAULTS_H_ = "";
pub const TTYDEF_IFLAG = (((BRKINT | ICRNL) | IMAXBEL) | IXON) | IXANY;
pub const TTYDEF_OFLAG = OPOST | ONLCR;
pub const TTYDEF_LFLAG = (((((ECHO | ICANON) | ISIG) | IEXTEN) | ECHOE) | ECHOKE) | ECHOCTL;
pub const TTYDEF_CFLAG = (CREAD | CS8) | HUPCL;
pub const TTYDEF_SPEED = B9600;
pub inline fn CTRL(x: anytype) @TypeOf(x & @as(c_int, 0o37)) {
    return x & @as(c_int, 0o37);
}
pub const CEOF = CTRL('d');
pub const CEOL = @import("std").zig.c_translation.cast(u8, '\xff');
pub const CERASE = @as(c_int, 0o177);
pub const CINTR = CTRL('c');
pub const CSTATUS = @import("std").zig.c_translation.cast(u8, '\xff');
pub const CKILL = CTRL('u');
pub const CMIN = @as(c_int, 1);
pub const CQUIT = @as(c_int, 0o34);
pub const CSUSP = CTRL('z');
pub const CTIME = @as(c_int, 0);
pub const CDSUSP = CTRL('y');
pub const CSTART = CTRL('q');
pub const CSTOP = CTRL('s');
pub const CLNEXT = CTRL('v');
pub const CDISCARD = CTRL('o');
pub const CWERASE = CTRL('w');
pub const CREPRINT = CTRL('r');
pub const CEOT = CEOF;
pub const CBRK = CEOL;
pub const CRPRNT = CREPRINT;
pub const CFLUSH = CDISCARD;
pub const _PWD_H_ = "";
pub const _PATH_PASSWD = "/etc/passwd";
pub const _PATH_MASTERPASSWD = "/etc/master.passwd";
pub const _PATH_MASTERPASSWD_LOCK = "/etc/ptmp";
pub const _PATH_MP_DB = "/etc/pwd.db";
pub const _PATH_SMP_DB = "/etc/spwd.db";
pub const _PATH_PWD_MKDB = "/usr/sbin/pwd_mkdb";
pub const _PW_KEYBYNAME = '1';
pub const _PW_KEYBYNUM = '2';
pub const _PW_KEYBYUID = '3';
pub const _PW_YPTOKEN = "__YP!";
pub const _PASSWORD_EFMT1 = '_';
pub const _PASSWORD_LEN = @as(c_int, 128);
pub const _PW_NAME_LEN = @as(c_int, 31);
pub const _PW_BUF_LEN = @as(c_int, 1024);
pub const _PASSWORD_NOUID = @as(c_int, 0x01);
pub const _PASSWORD_NOGID = @as(c_int, 0x02);
pub const _PASSWORD_NOCHG = @as(c_int, 0x04);
pub const _PASSWORD_NOEXP = @as(c_int, 0x08);
pub const _PASSWORD_SECUREONLY = @as(c_int, 0x01);
pub const _PASSWORD_OMITV7 = @as(c_int, 0x02);
pub const _SEMAPHORE_H_ = "";
pub const SEM_FAILED = @import("std").zig.c_translation.cast([*c]sem_t, @as(c_int, 0));
pub const _SYS_PARAM_H_ = "";
pub const BSD = @import("std").zig.c_translation.promoteIntLiteral(c_int, 199306, .decimal);
pub const BSD4_3 = @as(c_int, 1);
pub const BSD4_4 = @as(c_int, 1);
pub const OpenBSD = @import("std").zig.c_translation.promoteIntLiteral(c_int, 202310, .decimal);
pub const OpenBSD7_4 = @as(c_int, 1);
pub const ARG_MAX = @as(c_int, 512) * @as(c_int, 1024);
pub const CHILD_MAX = @as(c_int, 80);
pub const LINK_MAX = @as(c_int, 32767);
pub const MAX_CANON = @as(c_int, 255);
pub const MAX_INPUT = @as(c_int, 255);
pub const NAME_MAX = @as(c_int, 255);
pub const NGROUPS_MAX = @as(c_int, 16);
pub const OPEN_MAX = @as(c_int, 64);
pub const PATH_MAX = @as(c_int, 1024);
pub const PIPE_BUF = @as(c_int, 512);
pub const SYMLINK_MAX = PATH_MAX;
pub const SYMLOOP_MAX = @as(c_int, 32);
pub const BC_BASE_MAX = INT_MAX;
pub const BC_DIM_MAX = @import("std").zig.c_translation.promoteIntLiteral(c_int, 65535, .decimal);
pub const BC_SCALE_MAX = INT_MAX;
pub const BC_STRING_MAX = INT_MAX;
pub const COLL_WEIGHTS_MAX = @as(c_int, 2);
pub const EXPR_NEST_MAX = @as(c_int, 32);
pub const LINE_MAX = @as(c_int, 2048);
pub const RE_DUP_MAX = @as(c_int, 255);
pub const SEM_VALUE_MAX = UINT_MAX;
pub const IOV_MAX = @as(c_int, 1024);
pub const NZERO = @as(c_int, 20);
pub const TTY_NAME_MAX = @as(c_int, 260);
pub const LOGIN_NAME_MAX = @as(c_int, 32);
pub const HOST_NAME_MAX = @as(c_int, 255);
pub const _MAXCOMLEN = @as(c_int, 24);
pub const MAXCOMLEN = _MAXCOMLEN - @as(c_int, 1);
pub const MAXINTERP = @as(c_int, 128);
pub const MAXLOGNAME = LOGIN_NAME_MAX;
pub const MAXUPRC = CHILD_MAX;
pub const NCARGS = ARG_MAX;
pub const NGROUPS = NGROUPS_MAX;
pub const NOFILE = OPEN_MAX;
pub const NOFILE_MAX = @as(c_int, 1024);
pub const NOGROUP = @import("std").zig.c_translation.promoteIntLiteral(c_int, 65535, .decimal);
pub const MAXHOSTNAMELEN = @as(c_int, 256);
pub const _SYS_SIGNAL_H_ = "";
pub const _MACHINE_SIGNAL_H_ = "";
pub const _NSIG = @as(c_int, 33);
pub const NSIG = _NSIG;
pub const SIGHUP = @as(c_int, 1);
pub const SIGINT = @as(c_int, 2);
pub const SIGQUIT = @as(c_int, 3);
pub const SIGILL = @as(c_int, 4);
pub const SIGTRAP = @as(c_int, 5);
pub const SIGABRT = @as(c_int, 6);
pub const SIGIOT = SIGABRT;
pub const SIGEMT = @as(c_int, 7);
pub const SIGFPE = @as(c_int, 8);
pub const SIGKILL = @as(c_int, 9);
pub const SIGBUS = @as(c_int, 10);
pub const SIGSEGV = @as(c_int, 11);
pub const SIGSYS = @as(c_int, 12);
pub const SIGPIPE = @as(c_int, 13);
pub const SIGALRM = @as(c_int, 14);
pub const SIGTERM = @as(c_int, 15);
pub const SIGURG = @as(c_int, 16);
pub const SIGSTOP = @as(c_int, 17);
pub const SIGTSTP = @as(c_int, 18);
pub const SIGCONT = @as(c_int, 19);
pub const SIGCHLD = @as(c_int, 20);
pub const SIGTTIN = @as(c_int, 21);
pub const SIGTTOU = @as(c_int, 22);
pub const SIGIO = @as(c_int, 23);
pub const SIGXCPU = @as(c_int, 24);
pub const SIGXFSZ = @as(c_int, 25);
pub const SIGVTALRM = @as(c_int, 26);
pub const SIGPROF = @as(c_int, 27);
pub const SIGWINCH = @as(c_int, 28);
pub const SIGINFO = @as(c_int, 29);
pub const SIGUSR1 = @as(c_int, 30);
pub const SIGUSR2 = @as(c_int, 31);
pub const SIGTHR = @as(c_int, 32);
pub const _SYS_SIGINFO_H = "";
pub inline fn SI_FROMUSER(sip: anytype) @TypeOf(sip.*.si_code <= @as(c_int, 0)) {
    return sip.*.si_code <= @as(c_int, 0);
}
pub inline fn SI_FROMKERNEL(sip: anytype) @TypeOf(sip.*.si_code > @as(c_int, 0)) {
    return sip.*.si_code > @as(c_int, 0);
}
pub const SI_NOINFO = @as(c_int, 32767);
pub const SI_USER = @as(c_int, 0);
pub const SI_LWP = -@as(c_int, 1);
pub const SI_QUEUE = -@as(c_int, 2);
pub const SI_TIMER = -@as(c_int, 3);
pub const ILL_ILLOPC = @as(c_int, 1);
pub const ILL_ILLOPN = @as(c_int, 2);
pub const ILL_ILLADR = @as(c_int, 3);
pub const ILL_ILLTRP = @as(c_int, 4);
pub const ILL_PRVOPC = @as(c_int, 5);
pub const ILL_PRVREG = @as(c_int, 6);
pub const ILL_COPROC = @as(c_int, 7);
pub const ILL_BADSTK = @as(c_int, 8);
pub const NSIGILL = @as(c_int, 8);
pub const EMT_TAGOVF = @as(c_int, 1);
pub const NSIGEMT = @as(c_int, 1);
pub const FPE_INTDIV = @as(c_int, 1);
pub const FPE_INTOVF = @as(c_int, 2);
pub const FPE_FLTDIV = @as(c_int, 3);
pub const FPE_FLTOVF = @as(c_int, 4);
pub const FPE_FLTUND = @as(c_int, 5);
pub const FPE_FLTRES = @as(c_int, 6);
pub const FPE_FLTINV = @as(c_int, 7);
pub const FPE_FLTSUB = @as(c_int, 8);
pub const NSIGFPE = @as(c_int, 8);
pub const SEGV_MAPERR = @as(c_int, 1);
pub const SEGV_ACCERR = @as(c_int, 2);
pub const NSIGSEGV = @as(c_int, 2);
pub const BUS_ADRALN = @as(c_int, 1);
pub const BUS_ADRERR = @as(c_int, 2);
pub const BUS_OBJERR = @as(c_int, 3);
pub const NSIGBUS = @as(c_int, 3);
pub const TRAP_BRKPT = @as(c_int, 1);
pub const TRAP_TRACE = @as(c_int, 2);
pub const NSIGTRAP = @as(c_int, 2);
pub const CLD_EXITED = @as(c_int, 1);
pub const CLD_KILLED = @as(c_int, 2);
pub const CLD_DUMPED = @as(c_int, 3);
pub const CLD_TRAPPED = @as(c_int, 4);
pub const CLD_STOPPED = @as(c_int, 5);
pub const CLD_CONTINUED = @as(c_int, 6);
pub const NSIGCLD = @as(c_int, 6);
pub const SI_MAXSZ = @as(c_int, 128);
pub const SI_PAD = @import("std").zig.c_translation.MacroArithmetic.div(SI_MAXSZ, @import("std").zig.c_translation.sizeof(c_int)) - @as(c_int, 3);
pub const SA_ONSTACK = @as(c_int, 0x0001);
pub const SA_RESTART = @as(c_int, 0x0002);
pub const SA_RESETHAND = @as(c_int, 0x0004);
pub const SA_NODEFER = @as(c_int, 0x0010);
pub const SA_NOCLDWAIT = @as(c_int, 0x0020);
pub const SA_NOCLDSTOP = @as(c_int, 0x0008);
pub const SA_SIGINFO = @as(c_int, 0x0040);
pub const SIG_BLOCK = @as(c_int, 1);
pub const SIG_UNBLOCK = @as(c_int, 2);
pub const SIG_SETMASK = @as(c_int, 3);
pub const SV_ONSTACK = SA_ONSTACK;
pub const SV_INTERRUPT = SA_RESTART;
pub const SV_RESETHAND = SA_RESETHAND;
pub inline fn sigmask(m: anytype) @TypeOf(@as(c_uint, 1) << (m - @as(c_int, 1))) {
    return @as(c_uint, 1) << (m - @as(c_int, 1));
}
pub const BADSIG = SIG_ERR;
pub const SS_ONSTACK = @as(c_int, 0x0001);
pub const SS_DISABLE = @as(c_int, 0x0004);
pub const MINSIGSTKSZ = @as(c_uint, 3) << _MAX_PAGE_SHIFT;
pub const SIGSTKSZ = MINSIGSTKSZ + ((@as(c_uint, 1) << _MAX_PAGE_SHIFT) * @as(c_int, 4));
pub const _SYS_LIMITS_H_ = "";
pub const _MACHINE_LIMITS_H_ = "";
pub const SSIZE_MAX = LONG_MAX;
pub const SIZE_T_MAX = ULONG_MAX;
pub const UQUAD_MAX = @as(c_ulonglong, 0xffffffffffffffff);
pub const QUAD_MAX = @as(c_longlong, 0x7fffffffffffffff);
pub const QUAD_MIN = -@as(c_longlong, 0x7fffffffffffffff) - @as(c_int, 1);
pub const CHAR_BIT = @as(c_int, 8);
pub const SCHAR_MAX = @as(c_int, 0x7f);
pub const SCHAR_MIN = -@as(c_int, 0x7f) - @as(c_int, 1);
pub const UCHAR_MAX = @as(c_int, 0xff);
pub const CHAR_MAX = @as(c_int, 0x7f);
pub const CHAR_MIN = -@as(c_int, 0x7f) - @as(c_int, 1);
pub const MB_LEN_MAX = @as(c_int, 4);
pub const USHRT_MAX = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0xffff, .hexadecimal);
pub const SHRT_MAX = @as(c_int, 0x7fff);
pub const SHRT_MIN = -@as(c_int, 0x7fff) - @as(c_int, 1);
pub const UINT_MAX = @import("std").zig.c_translation.promoteIntLiteral(c_uint, 0xffffffff, .hexadecimal);
pub const INT_MAX = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x7fffffff, .hexadecimal);
pub const INT_MIN = -@import("std").zig.c_translation.promoteIntLiteral(c_int, 0x7fffffff, .hexadecimal) - @as(c_int, 1);
pub const ULONG_MAX = @import("std").zig.c_translation.promoteIntLiteral(c_ulong, 0xffffffffffffffff, .hexadecimal);
pub const LONG_MAX = @import("std").zig.c_translation.promoteIntLiteral(c_long, 0x7fffffffffffffff, .hexadecimal);
pub const LONG_MIN = -@import("std").zig.c_translation.promoteIntLiteral(c_long, 0x7fffffffffffffff, .hexadecimal) - @as(c_int, 1);
pub const ULLONG_MAX = @as(c_ulonglong, 0xffffffffffffffff);
pub const LLONG_MAX = @as(c_longlong, 0x7fffffffffffffff);
pub const LLONG_MIN = -@as(c_longlong, 0x7fffffffffffffff) - @as(c_int, 1);
pub const UID_MAX = UINT_MAX;
pub const GID_MAX = UINT_MAX;
pub const LONG_BIT = @as(c_int, 64);
pub const WORD_BIT = @as(c_int, 32);
pub const _MACHINE_PARAM_H_ = "";
pub const MACHINE = "amd64";
pub const MACHINE_ARCH = "amd64";
pub const PAGE_SHIFT = @as(c_int, 12);
pub const PAGE_SIZE = @as(c_int, 1) << PAGE_SHIFT;
pub const PAGE_MASK = PAGE_SIZE - @as(c_int, 1);
pub const KERNBASE = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0xffffffff80000000, .hexadecimal);
pub const PZERO = @as(c_int, 22);
pub const NODEV = @import("std").zig.c_translation.cast(dev_t, -@as(c_int, 1));
pub const ALIGNBYTES = _ALIGNBYTES;
pub inline fn ALIGN(p: anytype) @TypeOf(_ALIGN(p)) {
    return _ALIGN(p);
}
pub inline fn ALIGNED_POINTER(p: anytype, t: anytype) @TypeOf(_ALIGNED_POINTER(p, t)) {
    return _ALIGNED_POINTER(p, t);
}
pub const MAXBSIZE = @as(c_int, 64) * @as(c_int, 1024);
pub const _DEV_BSHIFT = @as(c_int, 9);
pub const DEV_BSIZE = @as(c_int, 1) << _DEV_BSHIFT;
pub inline fn ctod(x: anytype) @TypeOf(x << (PAGE_SHIFT - _DEV_BSHIFT)) {
    return x << (PAGE_SHIFT - _DEV_BSHIFT);
}
pub inline fn dtoc(x: anytype) @TypeOf(x >> (PAGE_SHIFT - _DEV_BSHIFT)) {
    return x >> (PAGE_SHIFT - _DEV_BSHIFT);
}
pub inline fn btodb(x: anytype) @TypeOf(x >> _DEV_BSHIFT) {
    return x >> _DEV_BSHIFT;
}
pub inline fn dbtob(x: anytype) @TypeOf(x << _DEV_BSHIFT) {
    return x << _DEV_BSHIFT;
}
pub const MAXPATHLEN = PATH_MAX;
pub const MAXSYMLINKS = SYMLOOP_MAX;
pub inline fn isset(a: anytype, i: anytype) @TypeOf(a[@as(usize, @intCast(i >> @as(c_int, 3)))] & (@as(c_int, 1) << (i & (NBBY - @as(c_int, 1))))) {
    return a[@as(usize, @intCast(i >> @as(c_int, 3)))] & (@as(c_int, 1) << (i & (NBBY - @as(c_int, 1))));
}
pub inline fn isclr(a: anytype, i: anytype) @TypeOf((a[@as(usize, @intCast(i >> @as(c_int, 3)))] & (@as(c_int, 1) << (i & (NBBY - @as(c_int, 1))))) == @as(c_int, 0)) {
    return (a[@as(usize, @intCast(i >> @as(c_int, 3)))] & (@as(c_int, 1) << (i & (NBBY - @as(c_int, 1))))) == @as(c_int, 0);
}
pub inline fn roundup(x: anytype, y: anytype) @TypeOf(@import("std").zig.c_translation.MacroArithmetic.div(x + (y - @as(c_int, 1)), y) * y) {
    return @import("std").zig.c_translation.MacroArithmetic.div(x + (y - @as(c_int, 1)), y) * y;
}
pub inline fn powerof2(x: anytype) @TypeOf(((x - @as(c_int, 1)) & x) == @as(c_int, 0)) {
    return ((x - @as(c_int, 1)) & x) == @as(c_int, 0);
}
pub inline fn MIN(a: anytype, b: anytype) @TypeOf(if (a < b) a else b) {
    return if (a < b) a else b;
}
pub inline fn MAX(a: anytype, b: anytype) @TypeOf(if (a > b) a else b) {
    return if (a > b) a else b;
}
pub const _FSHIFT = @as(c_int, 11);
pub const FSCALE = @as(c_int, 1) << _FSHIFT;
pub const _PTHREAD_H_ = "";
pub const __CLANG_LIMITS_H = "";
pub const _GCC_LIMITS_H_ = "";
pub const _LIMITS_H_ = "";
pub const _POSIX_ARG_MAX = @as(c_int, 4096);
pub const _POSIX_CHILD_MAX = @as(c_int, 25);
pub const _POSIX_LINK_MAX = @as(c_int, 8);
pub const _POSIX_MAX_CANON = @as(c_int, 255);
pub const _POSIX_MAX_INPUT = @as(c_int, 255);
pub const _POSIX_NAME_MAX = @as(c_int, 14);
pub const _POSIX_PATH_MAX = @as(c_int, 256);
pub const _POSIX_PIPE_BUF = @as(c_int, 512);
pub const _POSIX_RE_DUP_MAX = @as(c_int, 255);
pub const _POSIX_SEM_NSEMS_MAX = @as(c_int, 256);
pub const _POSIX_SEM_VALUE_MAX = @as(c_int, 32767);
pub const _POSIX_SSIZE_MAX = @as(c_int, 32767);
pub const _POSIX_STREAM_MAX = @as(c_int, 8);
pub const _POSIX_SYMLINK_MAX = @as(c_int, 255);
pub const _POSIX_SYMLOOP_MAX = @as(c_int, 8);
pub const _POSIX_THREAD_DESTRUCTOR_ITERATIONS = @as(c_int, 4);
pub const _POSIX_THREAD_KEYS_MAX = @as(c_int, 128);
pub const _POSIX_THREAD_THREADS_MAX = @as(c_int, 4);
pub const _POSIX_CLOCKRES_MIN = @import("std").zig.c_translation.promoteIntLiteral(c_int, 20000000, .decimal);
pub const _POSIX_NGROUPS_MAX = @as(c_int, 8);
pub const _POSIX_OPEN_MAX = @as(c_int, 20);
pub const _POSIX_TZNAME_MAX = @as(c_int, 6);
pub const _POSIX2_BC_BASE_MAX = @as(c_int, 99);
pub const _POSIX2_BC_DIM_MAX = @as(c_int, 2048);
pub const _POSIX2_BC_SCALE_MAX = @as(c_int, 99);
pub const _POSIX2_BC_STRING_MAX = @as(c_int, 1000);
pub const _POSIX2_COLL_WEIGHTS_MAX = @as(c_int, 2);
pub const _POSIX2_EXPR_NEST_MAX = @as(c_int, 32);
pub const _POSIX2_LINE_MAX = @as(c_int, 2048);
pub const _POSIX2_RE_DUP_MAX = _POSIX_RE_DUP_MAX;
pub const _POSIX2_CHARCLASS_NAME_MAX = @as(c_int, 14);
pub const _POSIX_HOST_NAME_MAX = @as(c_int, 255);
pub const _POSIX_LOGIN_NAME_MAX = @as(c_int, 9);
pub const _POSIX_TTY_NAME_MAX = @as(c_int, 9);
pub const NL_ARGMAX = @as(c_int, 9);
pub const NL_LANGMAX = @as(c_int, 14);
pub const NL_MSGMAX = @as(c_int, 32767);
pub const NL_SETMAX = @as(c_int, 255);
pub const NL_TEXTMAX = @as(c_int, 255);
pub const _XOPEN_IOV_MAX = @as(c_int, 16);
pub const _XOPEN_NAME_MAX = @as(c_int, 255);
pub const _XOPEN_PATH_MAX = @as(c_int, 1024);
pub const LONG_LONG_MAX = __LONG_LONG_MAX__;
pub const LONG_LONG_MIN = -__LONG_LONG_MAX__ - @as(c_longlong, 1);
pub const ULONG_LONG_MAX = (__LONG_LONG_MAX__ * @as(c_ulonglong, 2)) + @as(c_ulonglong, 1);
pub const _SCHED_H_ = "";
pub const SCHED_FIFO = @as(c_int, 1);
pub const SCHED_OTHER = @as(c_int, 2);
pub const SCHED_RR = @as(c_int, 3);
pub const PTHREAD_DESTRUCTOR_ITERATIONS = @as(c_int, 4);
pub const PTHREAD_KEYS_MAX = @as(c_int, 256);
pub const PTHREAD_STACK_MIN = @as(c_uint, 1) << _MAX_PAGE_SHIFT;
pub const PTHREAD_THREADS_MAX = ULONG_MAX;
pub const PTHREAD_DETACHED = @as(c_int, 0x1);
pub const PTHREAD_SCOPE_SYSTEM = @as(c_int, 0x2);
pub const PTHREAD_INHERIT_SCHED = @as(c_int, 0x4);
pub const PTHREAD_NOFLOAT = @as(c_int, 0x8);
pub const PTHREAD_CREATE_DETACHED = PTHREAD_DETACHED;
pub const PTHREAD_CREATE_JOINABLE = @as(c_int, 0);
pub const PTHREAD_SCOPE_PROCESS = @as(c_int, 0);
pub const PTHREAD_EXPLICIT_SCHED = @as(c_int, 0);
pub const PTHREAD_PROCESS_PRIVATE = @as(c_int, 0);
pub const PTHREAD_PROCESS_SHARED = @as(c_int, 1);
pub const PTHREAD_CANCEL_ENABLE = @as(c_int, 0);
pub const PTHREAD_CANCEL_DISABLE = @as(c_int, 1);
pub const PTHREAD_CANCEL_DEFERRED = @as(c_int, 0);
pub const PTHREAD_CANCEL_ASYNCHRONOUS = @as(c_int, 2);
pub const PTHREAD_CANCELED = @import("std").zig.c_translation.cast(?*anyopaque, @as(c_int, 1));
pub const PTHREAD_BARRIER_SERIAL_THREAD = -@as(c_int, 1);
pub const PTHREAD_NEEDS_INIT = @as(c_int, 0);
pub const PTHREAD_DONE_INIT = @as(c_int, 1);
pub const PTHREAD_MUTEX_INITIALIZER = NULL;
pub const PTHREAD_COND_INITIALIZER = NULL;
pub const PTHREAD_RWLOCK_INITIALIZER = NULL;
pub const PTHREAD_PRIO_NONE = @as(c_int, 0);
pub const PTHREAD_PRIO_INHERIT = @as(c_int, 1);
pub const PTHREAD_PRIO_PROTECT = @as(c_int, 2);
pub const PTHREAD_MUTEX_DEFAULT = PTHREAD_MUTEX_STRICT_NP;
pub const _USER_SIGNAL_H = "";
pub const UV_THREADPOOL_H_ = "";
pub const UV_BSD_H = "";
pub const UV_HAVE_KQUEUE = @as(c_int, 1);
pub const UV_PLATFORM_SEM_T = sem_t;
pub const UV_PLATFORM_LOOP_FIELDS = "";
pub const UV_STREAM_PRIVATE_PLATFORM_FIELDS = "";
pub const UV_ONCE_INIT = PTHREAD_ONCE_INIT;
pub const HAVE_DIRENT_TYPES = "";
pub const UV__DT_FILE = DT_REG;
pub const UV__DT_DIR = DT_DIR;
pub const UV__DT_LINK = DT_LNK;
pub const UV__DT_FIFO = DT_FIFO;
pub const UV__DT_SOCKET = DT_SOCK;
pub const UV__DT_CHAR = DT_CHR;
pub const UV__DT_BLOCK = DT_BLK;
pub const UV_DYNAMIC = "";
pub const UV_REQ_TYPE_PRIVATE = "";
pub const UV_REQ_PRIVATE_FIELDS = "";
pub const UV_PRIVATE_REQ_TYPES = "";
pub const UV_SHUTDOWN_PRIVATE_FIELDS = "";
pub const UV_TCP_PRIVATE_FIELDS = "";
pub const UV_FS_O_APPEND = O_APPEND;
pub const UV_FS_O_CREAT = O_CREAT;
pub const UV_FS_O_DIRECT = @as(c_int, 0);
pub const UV_FS_O_DIRECTORY = O_DIRECTORY;
pub const UV_FS_O_DSYNC = O_DSYNC;
pub const UV_FS_O_EXCL = O_EXCL;
pub const UV_FS_O_EXLOCK = O_EXLOCK;
pub const UV_FS_O_NOATIME = @as(c_int, 0);
pub const UV_FS_O_NOCTTY = O_NOCTTY;
pub const UV_FS_O_NOFOLLOW = O_NOFOLLOW;
pub const UV_FS_O_NONBLOCK = O_NONBLOCK;
pub const UV_FS_O_RDONLY = O_RDONLY;
pub const UV_FS_O_RDWR = O_RDWR;
pub const UV_FS_O_SYMLINK = @as(c_int, 0);
pub const UV_FS_O_SYNC = O_SYNC;
pub const UV_FS_O_TRUNC = O_TRUNC;
pub const UV_FS_O_WRONLY = O_WRONLY;
pub const UV_FS_O_FILEMAP = @as(c_int, 0);
pub const UV_FS_O_RANDOM = @as(c_int, 0);
pub const UV_FS_O_SHORT_LIVED = @as(c_int, 0);
pub const UV_FS_O_SEQUENTIAL = @as(c_int, 0);
pub const UV_FS_O_TEMPORARY = @as(c_int, 0);
pub const UV_PRIORITY_LOW = @as(c_int, 19);
pub const UV_PRIORITY_BELOW_NORMAL = @as(c_int, 10);
pub const UV_PRIORITY_NORMAL = @as(c_int, 0);
pub const UV_PRIORITY_ABOVE_NORMAL = -@as(c_int, 7);
pub const UV_PRIORITY_HIGH = -@as(c_int, 14);
pub const UV_PRIORITY_HIGHEST = -@as(c_int, 20);
pub const UV_MAXHOSTNAMESIZE = MAXHOSTNAMELEN + @as(c_int, 1);
pub const UV_FS_COPYFILE_EXCL = @as(c_int, 0x0001);
pub const UV_FS_COPYFILE_FICLONE = @as(c_int, 0x0002);
pub const UV_FS_COPYFILE_FICLONE_FORCE = @as(c_int, 0x0004);
pub const UV_FS_SYMLINK_DIR = @as(c_int, 0x0001);
pub const UV_FS_SYMLINK_JUNCTION = @as(c_int, 0x0002);
pub const UV_IF_NAMESIZE = @as(c_int, 16) + @as(c_int, 1);
pub const UVWRAP_H = "";
pub const __va_list_tag = struct___va_list_tag;
pub const __sbuf = struct___sbuf;
pub const __sFILE = struct___sFILE;
pub const timeval = struct_timeval;
pub const timespec = struct_timespec;
pub const itimerval = struct_itimerval;
pub const clockinfo = struct_clockinfo;
pub const itimerspec = struct_itimerspec;
pub const tm = struct_tm;
pub const dirent = struct_dirent;
pub const _dirdesc = struct__dirdesc;
pub const iovec = struct_iovec;
pub const uio_rw = enum_uio_rw;
pub const uio_seg = enum_uio_seg;
pub const linger = struct_linger;
pub const splice = struct_splice;
pub const sockaddr = struct_sockaddr;
pub const sockaddr_storage = struct_sockaddr_storage;
pub const sockpeercred = struct_sockpeercred;
pub const msghdr = struct_msghdr;
pub const mmsghdr = struct_mmsghdr;
pub const cmsghdr = struct_cmsghdr;
pub const in_addr = struct_in_addr;
pub const sockaddr_in = struct_sockaddr_in;
pub const ip_opts = struct_ip_opts;
pub const ip_mreq = struct_ip_mreq;
pub const ip_mreqn = struct_ip_mreqn;
pub const in6_addr = struct_in6_addr;
pub const sockaddr_in6 = struct_sockaddr_in6;
pub const rtentry = struct_rtentry;
pub const route_in6 = struct_route_in6;
pub const ipv6_mreq = struct_ipv6_mreq;
pub const in6_pktinfo = struct_in6_pktinfo;
pub const ip6_mtuinfo = struct_ip6_mtuinfo;
pub const tcphdr = struct_tcphdr;
pub const tcp_info = struct_tcp_info;
pub const hostent = struct_hostent;
pub const netent = struct_netent;
pub const servent = struct_servent;
pub const protoent = struct_protoent;
pub const addrinfo = struct_addrinfo;
pub const rdatainfo = struct_rdatainfo;
pub const rrsetinfo = struct_rrsetinfo;
pub const servent_data = struct_servent_data;
pub const protoent_data = struct_protoent_data;
pub const termios = struct_termios;
pub const winsize = struct_winsize;
pub const tstamps = struct_tstamps;
pub const passwd = struct_passwd;
pub const __sem = struct___sem;
pub const fxsave64 = struct_fxsave64;
pub const sigcontext = struct_sigcontext;
pub const sigval = union_sigval;
pub const sched_param = struct_sched_param;
pub const pthread = struct_pthread;
pub const pthread_attr = struct_pthread_attr;
pub const pthread_cond = struct_pthread_cond;
pub const pthread_cond_attr = struct_pthread_cond_attr;
pub const pthread_mutex = struct_pthread_mutex;
pub const pthread_mutex_attr = struct_pthread_mutex_attr;
pub const pthread_rwlock = struct_pthread_rwlock;
pub const pthread_rwlockattr = struct_pthread_rwlockattr;
pub const pthread_barrier = struct_pthread_barrier;
pub const pthread_barrierattr = struct_pthread_barrierattr;
pub const pthread_spinlock = struct_pthread_spinlock;
pub const pthread_mutextype = enum_pthread_mutextype;
pub const uv__io_s = struct_uv__io_s;
pub const uv_handle_s = struct_uv_handle_s;
pub const uv_async_s = struct_uv_async_s;
pub const uv_signal_s = struct_uv_signal_s;
pub const uv_loop_s = struct_uv_loop_s;
pub const uv__work = struct_uv__work;
pub const _uv_barrier = struct__uv_barrier;
pub const uv_dirent_s = struct_uv_dirent_s;
pub const uv_dir_s = struct_uv_dir_s;
pub const uv_connect_s = struct_uv_connect_s;
pub const uv_shutdown_s = struct_uv_shutdown_s;
pub const uv_stream_s = struct_uv_stream_s;
pub const uv_tcp_s = struct_uv_tcp_s;
pub const uv_udp_s = struct_uv_udp_s;
pub const uv_pipe_s = struct_uv_pipe_s;
pub const uv_tty_s = struct_uv_tty_s;
pub const uv_poll_s = struct_uv_poll_s;
pub const uv_timer_s = struct_uv_timer_s;
pub const uv_prepare_s = struct_uv_prepare_s;
pub const uv_check_s = struct_uv_check_s;
pub const uv_idle_s = struct_uv_idle_s;
pub const uv_process_s = struct_uv_process_s;
pub const uv_fs_event_s = struct_uv_fs_event_s;
pub const uv_fs_poll_s = struct_uv_fs_poll_s;
pub const uv_req_s = struct_uv_req_s;
pub const uv_getaddrinfo_s = struct_uv_getaddrinfo_s;
pub const uv_getnameinfo_s = struct_uv_getnameinfo_s;
pub const uv_write_s = struct_uv_write_s;
pub const uv_udp_send_s = struct_uv_udp_send_s;
pub const uv_fs_s = struct_uv_fs_s;
pub const uv_work_s = struct_uv_work_s;
pub const uv_random_s = struct_uv_random_s;
pub const uv_env_item_s = struct_uv_env_item_s;
pub const uv_cpu_times_s = struct_uv_cpu_times_s;
pub const uv_cpu_info_s = struct_uv_cpu_info_s;
pub const uv_interface_address_s = struct_uv_interface_address_s;
pub const uv_passwd_s = struct_uv_passwd_s;
pub const uv_utsname_s = struct_uv_utsname_s;
pub const uv_statfs_s = struct_uv_statfs_s;
pub const uv_tcp_flags = enum_uv_tcp_flags;
pub const uv_udp_flags = enum_uv_udp_flags;
pub const uv_poll_event = enum_uv_poll_event;
pub const uv_stdio_container_s = struct_uv_stdio_container_s;
pub const uv_process_options_s = struct_uv_process_options_s;
pub const uv_process_flags = enum_uv_process_flags;
pub const uv_fs_event = enum_uv_fs_event;
pub const uv_fs_event_flags = enum_uv_fs_event_flags;
pub const uv_thread_options_s = struct_uv_thread_options_s;
pub const uv_any_handle = union_uv_any_handle;
pub const uv_any_req = union_uv_any_req;
