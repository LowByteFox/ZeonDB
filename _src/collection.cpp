#include <map>
#include <string>

#include <types.hpp>
#include <collection.hpp>
#include <accounts.hpp>

namespace ZeonDB {
	void Collection::assign_perm(std::string username, std::string key, Accounts::Permission perms) {
		this->perms.emplace(username + ":" + key, perms);
	}

	bool Collection::has_perms(std::string username, std::string key) {
		return this->perms.contains(username + ":" + key);
	}

	Accounts::Permission Collection::get_perms(std::string username, std::string key) {
		return this->perms[username + ":" + key];
	}

	void Collection::add(std::string key, std::shared_ptr<Types::Value> value) {
		this->db.emplace(key, value);
	}

	std::shared_ptr<Types::Value> Collection::get(std::string key) {
		if (!this->db.contains(key)) return nullptr;

		return this->db[key];
	}

	std::string Collection::stringify(Types::FormatType fmtType) {
		std::string str = "{";

		for (const auto& [key, value] : this->db) {
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
			str += value->stringify(fmtType);
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
