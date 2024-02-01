#include <map>
#include <string>
#include <functional>

#include <logger.hpp>
#include <types.hpp>
#include <collection.hpp>
#include <accounts.hpp>
#include <utils/string.hpp>
#include <utils/key_processor.hpp>

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
		this->db[key.key][key.version] = value;
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

		bool has = this->db[key.version].contains(key.key);
		if (!has) return has;

		if (key.version == this->def_ver) {
			for (auto& pair: this->db) {
				LOG_D("VERSION: %s", pair.first.c_str());
				pair.second.erase(key.key);
			}
		}
		this->db[key.key].erase(key.version);

		return has;
	}

	std::shared_ptr<Types::Value> Collection::get(ZeonDB::Utils::Key key) {
		if (key.version.length() == 0) {
			key.version = this->def_ver;
		}

		if (!this->db[key.key].contains(key.version)) return nullptr;

		return this->db[key.key][key.version];
	}

	void Collection::iter(std::function<void(ZeonDB::Utils::String, std::shared_ptr<Types::Value>)> fn) {
		for (auto& [key, value] : this->db) {
			fn(key, value[this->def_ver]);
		}
	}

	std::string Collection::stringify(Types::FormatType fmtType, std::string username, ZeonDB::Types::RecursionProtector* protector) {
		std::string str = "{";

		if (this->has_perms(username, "$")) {
			Accounts::Permission perms = this->get_perms(username, "$");
			if (!perms.can_read) {
				return "{}";
			}
		}

		for (auto& [key, value] : this->db) {
			const auto& val = value[this->def_ver];

			if (this->has_perms(username, key)) {
				Accounts::Permission perms = this->get_perms(username, key);
				if (!perms.can_read) {
					continue;
				}
			}

			if (key.find(' ') != std::string::npos || fmtType == Types::FormatType::JSON) {
				if (fmtType == Types::FormatType::JSON) {
					str += "\"" + key + "\":";
				} else {
					str += "\"" + key + "\"";
				}
			} else {
				str += key;
			}

			str += " ";
			str += val->_stringify(fmtType, username, protector);
			if (fmtType == Types::FormatType::JSON) {
				str += ", ";
			} else {
				str += " ";
			}
		}

		if (str.length() > 1 && fmtType == Types::FormatType::JSON) {
			str.erase(str.length() - 1, 1);
		}

		if (str.length() > 1) {
			str[str.length() - 1] = '}';
		} else {
			str += "}";
		}

		return str;
	}
}
