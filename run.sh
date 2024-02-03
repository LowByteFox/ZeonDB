#!/bin/sh
ninja -C build && (./build/ZeonDB || lldb ./build/ZeonDB -c ZeonDB.core)
