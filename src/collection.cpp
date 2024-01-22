#include <map>
#include <string>
#include <functional>

#include <logger.hpp>
#include <types.hpp>
#include <collection.hpp>
#include <accounts.hpp>
#include <utils/string.hpp>

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

	void Collection::add(ZeonDB::Utils::String key, std::shared_ptr<Types::Value> value) {
		std::string new_key = key.c_str();
		std::string version = this->def_ver;

		if (key.contains("@")) {
			new_key = key.next("@");
			version = key.next("@");
		}

		this->db[version][new_key] = value;
	}

	bool Collection::del(ZeonDB::Utils::String key) {
		std::string new_key = key.c_str();
		std::string version = this->def_ver;

		if (key.contains("@")) {
			new_key = key.next("@");
			version = key.next("@");
		}

		bool has = this->db[version].contains(new_key);
		if (!has) return has;

		if (version == this->def_ver) {
			for (auto& pair: this->db) {
				LOG_D("VERSION: %s", pair.first.c_str());
				pair.second.erase(new_key);
			}
		}
		this->db[version].erase(new_key);

		return has;
	}

	std::shared_ptr<Types::Value> Collection::get(ZeonDB::Utils::String key) {
		std::string new_key = key.c_str();
		std::string version = this->def_ver;

		if (key.contains("@")) {
			new_key = key.next("@");
			version = key.next("@");
		}

		if (!this->db[version].contains(new_key)) return nullptr;

		return this->db[version][new_key];
	}

	void Collection::iter(std::function<void(ZeonDB::Utils::String, std::shared_ptr<Types::Value>)> fn) {
		for (auto& [key, value] : this->db[this->def_ver]) {
			fn(key, value);
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

		for (const auto& [key, value] : this->db[this->def_ver]) {
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
			str += value->_stringify(fmtType, username, protector);
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
