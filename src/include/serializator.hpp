#pragma once

#include <fstream>
#include <string>
#include <memory>

#include <types.hpp>
#include <db.hpp>

namespace ZeonDB {
	class DB;

	struct SerializationContext {
		Types::ManagedValue root;
		std::fstream& stream;
	};

	class Serializer {
		private:
			std::fstream data_file;

		public:
			Serializer(std::string);
			~Serializer();
			void serialize(ZeonDB::DB&);
			void unserialize(ZeonDB::DB&);
	};
}
