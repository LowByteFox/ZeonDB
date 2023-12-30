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

#define LOG_V(format, ...) LOG.verbose(__PRETTY_FUNCTION__, __LINE__, format, __VA_ARGS__)
#define LOG_D(format, ...) LOG.debug(__PRETTY_FUNCTION__, __LINE__, format, __VA_ARGS__)
#define LOG_I(format, ...) LOG.info(__PRETTY_FUNCTION__, __LINE__, format, __VA_ARGS__)
#define LOG_W(format, ...) LOG.warn(__PRETTY_FUNCTION__, __LINE__, format, __VA_ARGS__)
#define LOG_E(format, ...) LOG.error(__PRETTY_FUNCTION__, __LINE__, format, __VA_ARGS__)

extern ZeonDB::Logger LOG;
