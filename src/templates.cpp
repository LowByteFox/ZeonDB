#include <templates.hpp>
#include <string>
#include <memory>
#include <types.hpp>

namespace ZeonDB {
	void Template::add(std::string name, std::shared_ptr<ZeonDB::Types::Value> v) {
		(*this)[name] = v;
	}

	void Template::remove(std::string name) {
		this->erase(name);
	}

	void TemplateStore::add(std::string name, Template templ) {
		(*this)[name] = templ;
	}
	
	void TemplateStore::remove(std::string name) {
		this->erase(name);
	}

	Template *TemplateStore::get(std::string name) {
		if (!this->contains(name)) return nullptr;

		return &((*this)[name]);
	}

	std::shared_ptr<ZeonDB::Types::Value> TemplateStore::create(std::string name) {
		auto templ = this->get(name);
		auto val = ZeonDB::Types::Value::new_collection();
		if (templ == nullptr) return val;

		for (auto [key, value] : (*templ)) {
			val->v.c.add(key, value);
		}

		return val;
	}
}
