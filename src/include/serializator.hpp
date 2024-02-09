#pragma once

#include <fstream>
#include <string>
#include <memory>
#include <filesystem>

#include <types.hpp>
#include <db.hpp>

namespace fs = std::filesystem;

namespace ZeonDB {
	class DB;

	struct SerializationContext {
		Types::ManagedValue root;
		std::fstream& stream;
	};

	class Serializer {
		private:
			std::fstream data_file;
			std::fstream accounts_file;
			std::fstream templates_file;

            fs::path dir_path;

		public:
			Serializer(std::string);
			~Serializer();
			void serialize(ZeonDB::DB&);
			void unserialize(ZeonDB::DB&);
	};
}
