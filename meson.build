project('ZeonDB', 'cpp',
  default_options : ['cpp_std=c++20'])

files = ['_src/main.cpp', '_src/types.cpp', '_src/collection.cpp',
         '_src/ssl.cpp', '_src/accounts.cpp']

dirs = include_directories(['_src/'])

executable('ZeonDB', files,
  dependencies : [dependency('openssl')],
  include_directories : dirs)
