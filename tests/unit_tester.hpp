#include <cstdio>
#include <cstdlib>
#include <functional>
#include <cassert>

#define match(fn, val) expect(fn, val, __FILE__, __LINE__)

template <typename V>
inline void expect(std::function<V()> fn, V expected, const char *file, size_t line) {
	if (!(fn() == expected)) {
		fprintf(stderr, "TEST at %s:%ld failed!", file, line);
		exit(1);
	}
}

template <typename V>
inline void expect(V (*fn)(), V expected, const char *file, size_t line) {
	if (!(fn() == expected)) {
		fprintf(stderr, "TEST at %s:%ld failed!", file, line);
		exit(1);
	}
}
