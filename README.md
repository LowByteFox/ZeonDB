# ZeonDB
Multi-model, high performance, NoSQL database in C++.

<img src="./logo.png" width=128>

## Features
- Suports multiple database models (KV, Document, Graph, SQL-like)
- Simple query language ZQL (Zeon Query Language)
- C Client API
- Cross-platform, depending only on OpenSSL/LibreSSL and libuv

## Getting Started
```sh
git clone https://codeberg.org/LowByteFox/ZeonDB
cd ZeonDB
mkdir subprojects
meson wrap install tomlplusplus
meson setup build
ninja -C build
```

> Note
> Official repository is at [codeberg](https://codeberg.org/LowByteFox/ZeonDB) <br>
> Mirror of the repository is at [github](https://github.com/LowByteFox/ZeonDB)
