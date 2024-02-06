#include <cstdint>
#include <cstring>
#include <bit>
#include <array>

#include <net/frame.hpp>

namespace ZeonDB::Net {

	void ZeonFrame::to_buffer(ZeonFrameStatus status, uint64_t length) {
		memset(this->buffer.data(), 0, 9);
		memcpy(this->buffer.data(), &status, sizeof(status));

		switch (status) {
			case ZeonFrameStatus::Command:
			case ZeonFrameStatus::Error:
			case ZeonFrameStatus::Auth:
				this->target_length = length;
				memcpy(this->buffer.data() + sizeof(status), &length, sizeof(uint64_t));
			default:
				;
		}
	}

	void ZeonFrame::from_buffer() {
		memcpy(&this->status, this->buffer.data(), sizeof(ZeonFrameStatus));
		switch (this->status) {
			case ZeonFrameStatus::Command:
			case ZeonFrameStatus::Error:
			case ZeonFrameStatus::Auth:
				memcpy(&this->target_length, this->buffer.data() + sizeof(ZeonFrameStatus), sizeof(uint64_t));
			default:
				;
		}
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
