#include <logger.hpp>
#include <sstream>
#include <cstdio>
#include <string>
#include <cstdarg>
#include <ctime>
#include <iomanip>

namespace ZeonDB {
	std::string get_time() {
		std::time_t currentTime = std::time(nullptr);

		std::tm *localTime = std::localtime(&currentTime);

		std::stringstream ss;
		ss << std::put_time(localTime, "%Y-%m-%d %H:%M:%S");	

	    return ss.str();
	}

	Logger::Logger(std::string filename) {
		this->file = fopen(filename.c_str(), "w");
	}

	Logger::~Logger() {
		fclose(this->file);
	}

	void Logger::verbose(const char *fn, size_t line, const char *format, ...) {
		va_list args;

		va_start(args, format);

		fprintf(this->file, "%s (%s:%lu) \e[47;1m\e[30;1m V \e[0m ",
				get_time().c_str(), fn, line);
		vfprintf(this->file, format, args);
		fprintf(this->file, "\n");
		fflush(this->file);
		va_end(args);

		va_start(args, format);
		printf("%s (%s:%lu) \e[30;1m\e[47;1m V \e[0m ",
				get_time().c_str(), fn, line);
		vprintf(format, args);
		printf("\n");
		va_end(args);
	}

	void Logger::debug(const char *fn, size_t line, const char *format, ...) {
		va_list args;

		va_start(args, format);

		fprintf(this->file, "%s (%s:%lu) \e[42;1m\e[37;1m V \e[0m ",
				get_time().c_str(), fn, line);
		vfprintf(this->file, format, args);
		fprintf(this->file, "\n");
		fflush(this->file);
		va_end(args);

		va_start(args, format);
		printf("%s (%s:%lu) \e[37;1m\e[42;1m V \e[0m ",
				get_time().c_str(), fn, line);
		vprintf(format, args);
		printf("\n");
		va_end(args);
	}

	void Logger::info(const char *fn, size_t line, const char *format, ...) {
		va_list args;

		va_start(args, format);

		fprintf(this->file, "%s (%s:%lu) \e[46;1m\e[37;1m V \e[0m ",
				get_time().c_str(), fn, line);
		vfprintf(this->file, format, args);
		fprintf(this->file, "\n");
		fflush(this->file);
		va_end(args);

		va_start(args, format);
		printf("%s (%s:%lu) \e[37;1m\e[46;1m V \e[0m ",
				get_time().c_str(), fn, line);
		vprintf(format, args);
		printf("\n");
		va_end(args);
	}

	void Logger::warn(const char *fn, size_t line, const char *format, ...) {
		va_list args;

		va_start(args, format);

		fprintf(this->file, "%s (%s:%lu) \e[43;1m\e[30;1m V \e[0m\e[33;1m ",
				get_time().c_str(), fn, line);
		vfprintf(this->file, format, args);
		fprintf(this->file, "\e[0m\n");
		fflush(this->file);
		va_end(args);

		va_start(args, format);
		printf("%s (%s:%lu) \e[30;1m\e[43;1m V \e[0m\e[33;1m ",
				get_time().c_str(), fn, line);
		vprintf(format, args);
		printf("\e[0m\n");
		va_end(args);
	}

	void Logger::error(const char *fn, size_t line, const char *format, ...) {
		va_list args;

		va_start(args, format);

		fprintf(this->file, "%s (%s:%lu) \e[41;1m\e[30m V \e[0m\e[31;1m ",
				get_time().c_str(), fn, line);
		vfprintf(this->file, format, args);
		fprintf(this->file, "\e[0m\n");
		fflush(this->file);
		va_end(args);

		va_start(args, format);
		printf("%s (%s:%lu) \e[30;1m\e[41;1m V \e[0m\e[31;1m ",
				get_time().c_str(), fn, line);
		vprintf(format, args);
		printf("\e[0m\n");
		va_end(args);
	}
}
