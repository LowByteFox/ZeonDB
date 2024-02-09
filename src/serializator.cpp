#include <serializator.hpp>

#include <db.hpp>
#include <logger.hpp>

#include <string>
#include <fstream>
#include <filesystem>

#define CREATE_NOT_EXIST(name) do {\
	if (!fs::exists(name)) {\
		std::ofstream s(name);\
		s.close();\
	}\
} while(0);

namespace fs = std::filesystem;

namespace ZeonDB {
	Serializer::Serializer(std::string dir) {
		auto flags = std::fstream::in | std::fstream::out;

		this->dir_path = fs::path(dir);
		if (fs::exists(this->dir_path) && fs::is_directory(dir_path)) {
			CREATE_NOT_EXIST(this->dir_path / fs::path("data"));
			CREATE_NOT_EXIST(this->dir_path / fs::path("accounts"));
			CREATE_NOT_EXIST(this->dir_path / fs::path("templates"));

			this->data_file.open(this->dir_path / fs::path("data"), flags);
			this->accounts_file.open(this->dir_path / fs::path("accounts"), flags);
			this->templates_file.open(this->dir_path / fs::path("templates"), flags);
			return;
		} else if (fs::exists(this->dir_path) && !fs::is_directory(dir_path)) {
			fs::remove(this->dir_path);
			fs::create_directory(this->dir_path);
			CREATE_NOT_EXIST(this->dir_path / fs::path("data"));
			CREATE_NOT_EXIST(this->dir_path / fs::path("accounts"));
			CREATE_NOT_EXIST(this->dir_path / fs::path("templates"));

			this->data_file.open(this->dir_path / fs::path("data"), flags);
			this->accounts_file.open(this->dir_path / fs::path("accounts"), flags);
			this->templates_file.open(this->dir_path / fs::path("templates"), flags);
			return;
		}

		fs::create_directory(this->dir_path);
		CREATE_NOT_EXIST(this->dir_path / fs::path("data"));
		CREATE_NOT_EXIST(this->dir_path / fs::path("accounts"));
		CREATE_NOT_EXIST(this->dir_path / fs::path("templates"));

		this->data_file.open(this->dir_path / fs::path("data"), flags);
		this->accounts_file.open(this->dir_path / fs::path("accounts"), flags);
		this->templates_file.open(this->dir_path / fs::path("templates"), flags);
	}

	Serializer::~Serializer() {
		this->data_file.close();
	}

	void Serializer::serialize(ZeonDB::DB& db) {
		auto flags = std::fstream::in | std::fstream::out | std::fstream::trunc;

		this->data_file.clear();
		this->data_file.close();

		this->data_file.open(this->dir_path / fs::path("data"), flags);
		db.serialize(this->data_file);

		this->accounts_file.clear();
		this->accounts_file.close();
		this->accounts_file.open(this->dir_path / fs::path("accounts"), flags);
		db.serialize_accounts(this->accounts_file);

		this->templates_file.clear();
        this->templates_file.close();
		this->templates_file.open(this->dir_path / fs::path("templates"), flags);
		db.serialize_templates(this->templates_file);
		LOG_I("Serialized!", nullptr);
	}

	void Serializer::unserialize(ZeonDB::DB& db) {
		db.unserialize(this->data_file);
		db.unserialize_accounts(this->accounts_file);
		db.unserialize_templates(this->templates_file);
	}
}
