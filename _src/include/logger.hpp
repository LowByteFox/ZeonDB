#pragma once

#include <cstdio>
#include <string>
#include <cstdarg>

// https://developer.android.com/static/studio/images/debug/logcat-window.png
// date (fn:line)  T  msg

namespace ZeonDB {
	class Logger {
		private:
			FILE* file;
		public:
			Logger(std::string);
			~Logger();
			void verbose(const char *, size_t, const char *, ...);
			void debug(const char *, size_t, const char *, ...);
			void info(const char *, size_t, const char *, ...);
			void warn(const char *, size_t, const char *, ...);
			void error(const char *, size_t, const char *, ...);
	};
}

#define LOG_V(format, args...) LOG.verbose(__FUNCTION__, __LINE__, format, args)
#define LOG_D(format, args...) LOG.debug(__FUNCTION__, __LINE__, format, args)
#define LOG_I(format, args...) LOG.info(__FUNCTION__, __LINE__, format, args)
#define LOG_W(format, args...) LOG.warn(__FUNCTION__, __LINE__, format, args)
#define LOG_E(format, args...) LOG.error(__FUNCTION__, __LINE__, format, args)

extern ZeonDB::Logger LOG;
