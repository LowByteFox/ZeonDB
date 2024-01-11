fs = import('fs')

if not fs.is_dir('webview')
  run_command('git', 'clone', 'https://github.com/webview/webview.git')
endif

webview_lib = static_library('webview', ['webview/webview.cc'],
  cpp_args: ['-DWEBVIEW_STATIC'],
  dependencies: [dependency('gtk+-3.0'), dependency('webkit2gtk-4.0')],
  install: true,
  )

webview_include = include_directories(['webview'])
