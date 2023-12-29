#include <cstdint>
#include <cstring>
#include <bit>
#include <array>

#include <net/frame.hpp>

namespace ZeonDB::Net {

	void ZeonFrame::to_buffer(ZeonFrameStatus status, uint64_t length) {
		memcpy(this->buffer.data(), &status, sizeof(status));
		switch (status) {
			case ZeonFrameStatus::Command:
			case ZeonFrameStatus::Error:
			case ZeonFrameStatus::Auth:
				this->target_length = length;
				memcpy(this->buffer.data() + sizeof(status), &length, sizeof(uint64_t));
				break;
			default:
				memset(this->buffer.data() + 1, 0, 1023);
		}
	}

	void ZeonFrame::from_buffer() {
		memcpy(this->buffer.data(), &this->status, sizeof(ZeonFrameStatus));
		switch (this->status) {
			case ZeonFrameStatus::Command:
			case ZeonFrameStatus::Error:
			case ZeonFrameStatus::Auth:
				memcpy(this->buffer.data() + sizeof(ZeonFrameStatus), &this->target_length, sizeof(uint64_t));
				break;
			default:
				break;
		}
	}

	void ZeonFrame::write_buffer(const std::array<char, 1015>& buffer) {
		memcpy(this->buffer.data() + sizeof(ZeonFrameStatus) + sizeof(uint64_t), buffer.data(), 1015);
	}

	std::array<char, 1015> ZeonFrame::read_buffer() {
		std::array<char, 1015> arr;
		memcpy(arr.data(), this->buffer.data() + sizeof(ZeonFrameStatus) + sizeof(uint64_t), 1015);
		return arr;
	}

	char* ZeonFrame::get_buffer() {
		return this->buffer.data();
	}

	uint64_t ZeonFrame::get_length() {
		return this->target_length;
	}

	ZeonFrameStatus ZeonFrame::get_status() {
		return this->status;
	}
}
