#include <serializator.hpp>

#include <db.hpp>

#include <string>
#include <filesystem>

namespace fs = std::filesystem;

namespace ZeonDB {
	Serializer::Serializer(std::string dir) {
		auto flags = std::fstream::in | std::fstream::out | std::fstream::trunc;

		fs::path dir_path(dir);
		if (fs::exists(dir_path) && fs::is_directory(dir_path)) {
			this->data_file.open(dir_path / fs::path("data"), flags);
			return;
		} else if (fs::exists(dir_path) && !fs::is_directory(dir_path)) {
			fs::remove(dir_path);
			fs::create_directory(dir_path);
			this->data_file.open(dir_path / fs::path("data"), flags);
			return;
		}

		fs::create_directory(dir_path);
		this->data_file.open(dir_path / fs::path("data"), flags);
	}

	Serializer::~Serializer() {
		this->data_file.close();
	}

	void Serializer::serialize(ZeonDB::DB& db) {
		db.serialize(this->data_file);
	}
}
