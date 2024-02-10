#include <map>
#include <string>
#include <fstream>
#include <sstream>
#include <functional>

#include <logger.hpp>
#include <types.hpp>
#include <collection.hpp>
#include <accounts.hpp>
#include <utils/string.hpp>
#include <utils/key_processor.hpp>
#include <serializator.hpp>

namespace ZeonDB {
	void Collection::assign_perm(std::string username, std::string key, Accounts::Permission perms) {
		this->perms[username + ":" + key] = perms;
	}

	bool Collection::has_perms(std::string username, std::string key) {
		return this->perms.contains(username + ":" + key);
	}

	Accounts::Permission Collection::get_perms(std::string username, std::string key) {
		return this->perms[username + ":" + key];
	}

	void Collection::add(ZeonDB::Utils::Key key, std::shared_ptr<Types::Value> value) {
		if (key.version.length() == 0) {
			key.version = this->def_ver;
		}

		auto val = this->db[key.key][key.version];

		if (!this->db[key.key].contains(this->def_ver)) {
			this->db[key.key][this->def_ver] = ZeonDB::Types::Value::new_string("");
		}

		if (val && val->t == Types::Type::Array) {
			if (key.array_range.first > -1) {
				val->v.a[key.array_range.first] = value;
			} else {
				this->db[key.key][key.version] = value;
			}
		} else {
			this->db[key.key][key.version] = value;
		}
	}

	std::vector<ZeonDB::Utils::String> Collection::get_versions(ZeonDB::Utils::Key key) {
		std::vector<ZeonDB::Utils::String> versions;

		for (const auto& kv : this->db[key.key]) {
			versions.push_back(kv.first);
		}

		return versions;
	}

	bool Collection::del(ZeonDB::Utils::Key key) {
		if (key.version.length() == 0) {
			key.version = this->def_ver;
		}

		bool has = this->db[key.key].contains(key.version);
		if (!has) return has;

		if (key.version == this->def_ver) {
            this->db.erase(key.key);
		} else {
    		this->db[key.key].erase(key.version);
        }

		return has;
	}

	std::shared_ptr<Types::Value> Collection::get(ZeonDB::Utils::Key key) {
		if (key.version.length() == 0) {
			key.version = this->def_ver;
		}

		if (!this->db[key.key].contains(key.version)) return nullptr;

		auto val = this->db[key.key][key.version];
		if (val->t == Types::Type::Array) {
			if (key.array_range.first > -1) {
				val = val->v.a[key.array_range.first];
			}
		}

		return val;
	}

	bool Collection::has(ZeonDB::Utils::Key key) {
		if (key.version.length() == 0) {
			key.version = this->def_ver;
		}

		return this->db[key.key].contains(key.version);
	}

	std::shared_ptr<Types::Value>& Collection::get_ref(ZeonDB::Utils::Key key) {
		if (key.version.length() == 0) {
			key.version = this->def_ver;
		}

		if (!this->db[key.key].contains(key.version)) {
			LOG_E("The key %s does not exist! Stopping to prevent undefined behavior!", key.key.c_str());
			abort();
		}

		return this->db[key.key][key.version];
	}

	void Collection::iter(std::function<void(ZeonDB::Utils::String, std::shared_ptr<Types::Value>)> fn, std::string version) {
		for (auto& [key, value] : this->db) {
			fn(key, value[version]);
		}
	}

	void Collection::stringify(Types::FormatType fmtType, std::string username, ZeonDB::Types::RecursionProtector* protector, std::stringstream& res) {
		if (this->has_perms(username, "$")) {
			Accounts::Permission perms = this->get_perms(username, "$");
			if (!perms.can_read) {
				res << "{}";
				return;
			}
		}

		res << "{";

		for (auto it = this->db.begin(); it != this->db.end(); it++) {
			auto& val = it->second[this->def_ver];
			const auto& key = it->first;

			if (this->has_perms(username, key)) {
				Accounts::Permission perms = this->get_perms(username, key);
				if (!perms.can_read) {
					continue;
				}
			}

			if (key.find(' ') != std::string::npos || fmtType == Types::FormatType::JSON) {
				if (fmtType == Types::FormatType::JSON) {
					res << "\"" + key + "\":";
				} else {
					res << "\"" + key + "\"";
				}
			} else {
				res << key;
			}

			res << " ";
			val->_stringify(fmtType, username, protector, res);

			if (std::next(it) != this->db.end()) {
				if (fmtType == Types::FormatType::JSON) {
					res << ", ";
				} else {
					res << " ";
				}
			}
		}

		res << "}";
	}

	void Collection::serialize(std::fstream& stream) {
		size_t len = this->db.size();
		stream.write(reinterpret_cast<char*>(&len), sizeof(size_t));

		for (auto& [key, value] : this->db) {
			len = key.length();
			stream.write(reinterpret_cast<char*>(&len), sizeof(size_t));
			stream.write(key.data(), len);

            // default value is being serialized
            stream.write(reinterpret_cast<char*>(&(value[this->def_ver]->t)), sizeof(ZeonDB::Types::Type));
            value[this->def_ver]->serialize(stream);

			// number of versions
			len = value.size() - 1; // - 1 is the default version
			stream.write(reinterpret_cast<char*>(&len), sizeof(size_t));

			for (auto& [vkey, val] : value) {
				if (vkey.compare(this->def_ver) == 0) continue;
				len = vkey.length();
				stream.write(reinterpret_cast<char*>(&len), sizeof(size_t));
				stream.write(vkey.data(), len);
				stream.write(reinterpret_cast<char*>(&val->t), sizeof(ZeonDB::Types::Type));
				val->serialize(stream);
			}
		}
		len = this->perms.size();

		stream.write(reinterpret_cast<char*>(&len), sizeof(size_t));

		for (auto& [key, value] : this->perms) {
			len = key.length();
			stream.write(reinterpret_cast<char*>(&len), sizeof(size_t));
			stream.write(key.data(), len);
			stream.write(reinterpret_cast<char*>(&value), sizeof(value));
		}
	}

	void Collection::unserialize(SerializationContext ctx) {
		size_t count = 0;
		ctx.stream.read(reinterpret_cast<char*>(&count), sizeof(size_t));

		for (int i = 0; i < count; i++) {
			auto obj = std::make_shared<ZeonDB::Types::Value>();
			size_t len = 0;
			ctx.stream.read(reinterpret_cast<char*>(&len), sizeof(size_t));
			std::string key(len, 0);
			ctx.stream.read(key.data(), len);
			ctx.stream.read(reinterpret_cast<char*>(&obj->t), sizeof(ZeonDB::Types::Type));

			obj->unserialize(ctx);
			this->add(key, obj);

			// number of versions
			size_t vcount = 0;
			ctx.stream.read(reinterpret_cast<char*>(&vcount), sizeof(size_t));

			for (int j = 0; j < vcount; j++) {
				auto obj2 = std::make_shared<ZeonDB::Types::Value>();

				len = 0;
				ctx.stream.read(reinterpret_cast<char*>(&len), sizeof(size_t));
				std::string version(len, 0);
				ctx.stream.read(version.data(), len);
				ctx.stream.read(reinterpret_cast<char*>(&obj2->t), sizeof(ZeonDB::Types::Type));
				obj2->unserialize(ctx);
				this->add(key + "@" + version, obj2);
			}
		}

		count = 0;
		ctx.stream.read(reinterpret_cast<char*>(&count), sizeof(size_t));

		for (int i = 0; i < count; i++) {
			Accounts::Permission perms;
			size_t len = 0;
			ctx.stream.read(reinterpret_cast<char*>(&len), sizeof(size_t));
			std::string key(len, 0);
			ctx.stream.read(key.data(), len);
			ctx.stream.read(reinterpret_cast<char*>(&perms), sizeof(perms));

			this->perms[key] = perms;
		}
	}
}
