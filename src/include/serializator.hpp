#pragma once

#include <fstream>
#include <string>

#include <db.hpp>

namespace ZeonDB {
	class Serializer {
		private:
			std::fstream data_file;

		public:
			Serializer(std::string);
			~Serializer();
			void serialize(ZeonDB::DB&);
	};
}
