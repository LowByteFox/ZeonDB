#include <logger.hpp>
#include <sstream>
#include <cstdio>
#include <string>
#include <cstdarg>
#include <ctime>
#include <iomanip>

#define SPACING 125

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
		int printed = fprintf(this->file, "%s (%s:%lu)",
				get_time().c_str(), fn, line);
		fprintf(this->file, "%*c", SPACING - printed, ' ');
		fprintf(this->file, " \e[47;1m\e[30;1m V \e[0m ");
		vfprintf(this->file, format, args);
		fprintf(this->file, "\n");
		fflush(this->file);
		va_end(args);

		va_start(args, format);
		printed = printf("%s (%s:%lu)", get_time().c_str(), fn, line);
		printf("%*c", SPACING - printed, ' ');
		printf(" \e[47;1m\e[30;1m V \e[0m ");
		vprintf(format, args);
		printf("\n");
		va_end(args);
	}

	void Logger::debug(const char *fn, size_t line, const char *format, ...) {
		va_list args;

		va_start(args, format);
		int printed = fprintf(this->file, "%s (%s:%lu)",
				get_time().c_str(), fn, line);
		fprintf(this->file, "%*c", SPACING - printed, ' ');
		fprintf(this->file, " \e[42;1m\e[37;1m D \e[0m ");
		vfprintf(this->file, format, args);
		fprintf(this->file, "\n");
		fflush(this->file);
		va_end(args);

		va_start(args, format);
		printed = printf("%s (%s:%lu)", get_time().c_str(), fn, line);
		printf("%*c", SPACING - printed, ' ');
		printf(" \e[42;1m\e[37;1m D \e[0m ");
		vprintf(format, args);
		printf("\n");
		va_end(args);
	}

	void Logger::info(const char *fn, size_t line, const char *format, ...) {
		va_list args;

		va_start(args, format);
		int printed = fprintf(this->file, "%s (%s:%lu)",
				get_time().c_str(), fn, line);
		fprintf(this->file, "%*c", SPACING - printed, ' ');
		fprintf(this->file, " \e[46;1m\e[37;1m I \e[0m ");
		vfprintf(this->file, format, args);
		fprintf(this->file, "\n");
		fflush(this->file);
		va_end(args);

		va_start(args, format);
		printed = printf("%s (%s:%lu)", get_time().c_str(), fn, line);
		printf("%*c", SPACING - printed, ' ');
		printf(" \e[46;1m\e[37;1m I \e[0m ");
		vprintf(format, args);
		printf("\n");
		va_end(args);
	}

	void Logger::warn(const char *fn, size_t line, const char *format, ...) {
		va_list args;

		va_start(args, format);
		int printed = fprintf(this->file, "%s (%s:%lu)",
				get_time().c_str(), fn, line);
		fprintf(this->file, "%*c", SPACING - printed, ' ');
		fprintf(this->file, " \e[43;1m\e[30;1m W \e[0m\e[33;1m ");
		vfprintf(this->file, format, args);
		fprintf(this->file, "\e[0m\n");
		fflush(this->file);
		va_end(args);

		va_start(args, format);
		printed = printf("%s (%s:%lu)", get_time().c_str(), fn, line);
		printf("%*c", SPACING - printed, ' ');
		printf(" \e[43;1m\e[30;1m W \e[0m\e[33;1m ");
		vprintf(format, args);
		printf("\e[0m\n");
		va_end(args);
	}

	void Logger::error(const char *fn, size_t line, const char *format, ...) {
		va_list args;

		va_start(args, format);
		int printed = fprintf(this->file, "%s (%s:%lu)",
				get_time().c_str(), fn, line);
		fprintf(this->file, "%*c", SPACING - printed, ' ');
		fprintf(this->file, " \e[41;1m\e[30m E \e[0m\e[31;1m ");
		vfprintf(this->file, format, args);
		fprintf(this->file, "\e[0m\n");
		fflush(this->file);
		va_end(args);

		va_start(args, format);
		printed = printf("%s (%s:%lu)", get_time().c_str(), fn, line);
		printf("%*c", SPACING - printed, ' ');
		printf(" \e[41;1m\e[30m E \e[0m\e[31;1m ");
		vprintf(format, args);
		printf("\e[0m\n");
		va_end(args);
	}
}
