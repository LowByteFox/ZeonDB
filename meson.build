project('ZeonDB', 'cpp',
  default_options : ['cpp_std=c++20'])

files = ['_src/main.cpp', '_src/types.cpp', '_src/collection.cpp',
         '_src/ssl.cpp', '_src/accounts.cpp', '_src/config.cpp',
         '_src/zql/lexer.cpp', '_src/zql/parser.cpp', '_src/zql/ctx.cpp',
         '_src/db.cpp', '_src/utils/string.cpp',
         '_src/zql/commands/get.cpp', '_src/zql/commands/set.cpp',
         '_src/zql/commands/auth.cpp'
         ]

dirs = include_directories(['_src/include/'])

executable('ZeonDB', files,
  dependencies : [dependency('openssl'), dependency('tomlplusplus')],
  include_directories : dirs)
