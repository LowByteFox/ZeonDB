#pragma once

#include <array>
#include <cstdint>

namespace ZeonDB::Net {

	enum class ZeonFrameStatus : uint8_t {
		Ok = 0,
		Command,
		Error,
		Auth,
	};

	class ZeonFrame {
		private:
			ZeonFrameStatus status;
			uint64_t target_length;
			std::array<char, 9> buffer;
		public:
			void to_buffer(ZeonFrameStatus, uint64_t);
			void from_buffer();
			char* get_buffer();
			uint64_t get_length();
			ZeonFrameStatus get_status();
	};
}
