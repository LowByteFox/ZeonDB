project('ZeonDB', 'cpp',
  default_options: ['cpp_std=c++20'],
  version: '0.5.0')

files = ['src/main.cpp', 'src/types.cpp', 'src/collection.cpp',
         'src/ssl.cpp', 'src/accounts.cpp', 'src/config.cpp',
         'src/zql/lexer.cpp', 'src/zql/parser.cpp', 'src/zql/ctx.cpp',
         'src/db.cpp', 'src/utils/string.cpp', 'src/net/frame.cpp',
         'src/net/client.cpp', 'src/net/server.cpp', 'src/logger.cpp',
         'src/templates.cpp', 'src/link.cpp',
         'src/zql/commands/get.cpp', 'src/zql/commands/set.cpp',
         'src/zql/commands/auth.cpp', 'src/zql/commands/template.cpp',
         'src/zql/commands/link.cpp'
         ]

dirs = include_directories(['src/include/', 'external/'])

zeon_client_api = library('zeonapi', ['src/client/zeonapi.cpp', 'src/net/frame.cpp', 'src/ssl.cpp'],
  dependencies: [dependency('openssl'),
                  dependency('libuv')],
  include_directories: dirs)

cxxflags = ['-DZEON_VERSION="' + meson.project_version() + '"',
            '-DARGPARSE_VERSION="' + dependency('argparse').version() + '"',
            '-DTOMLPLUSPLUS_VERSION="' + dependency('tomlplusplus', static: true).version() + '"']

executable('ZeonCTL', 'src/client/main.cpp',
  link_with: zeon_client_api,
  dependencies: [dependency('openssl'),
                  dependency('libuv'),
                  dependency('argparse', static: true)],
  include_directories: dirs,
  cpp_args: cxxflags)

executable('ZeonDB', files,
  dependencies: [dependency('openssl'),
                  dependency('tomlplusplus', static: true),
                  dependency('argparse', static: true),
                  dependency('libuv')],
  include_directories: dirs,
  cpp_args: cxxflags)
