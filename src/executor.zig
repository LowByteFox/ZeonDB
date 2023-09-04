const parser = @import("./parser/parser.zig");
const collection = @import("./collection.zig");

var instance_count: i32 = 0;

pub const Executor = struct {
    parser: parser.Parser,
    db: *collection.Collection,

    pub fn init(db: ?*collection.Collection) ?Executor {
        if (instance_count == 0) {
            if (db == null) {
                // WARN: Fix too dangerous
                unreachable;
            }

            instance_count += 1;
            return Executor{
                .parser = parser.Parser{},
                .db = db
            };
        }

        return null;
    }
};
