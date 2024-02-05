#include <templates.hpp>
#include <string>
#include <memory>
#include <types.hpp>
#include <serializator.hpp>

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

	void Template::serialize(std::fstream& stream) {
		size_t len = this->size();
		stream.write(reinterpret_cast<char*>(&len), sizeof(size_t));

		for (auto& [key, value]: (*this)) {
			len = key.length();
			stream.write(reinterpret_cast<char*>(&len), sizeof(size_t));
			stream.write(key.data(), len);
			stream.write(reinterpret_cast<char*>(&(value->t)), sizeof(ZeonDB::Types::Type));
			value->serialize(stream);
		}
	}

	void Template::unserialize(SerializationContext ctx) {
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
		}
	}

	void TemplateStore::serialize(std::fstream& stream) {
		size_t len = this->size();
		stream.write(reinterpret_cast<char*>(&len), sizeof(size_t));

		for (auto& [key, templ]: (*this)) {
			len = key.length();
			stream.write(reinterpret_cast<char*>(&len), sizeof(size_t));
			stream.write(key.data(), len);
			templ.serialize(stream);
		}
	}

	void TemplateStore::unserialize(SerializationContext ctx) {
		size_t count = 0;
		ctx.stream.read(reinterpret_cast<char*>(&count), sizeof(size_t));

		for (int i = 0; i < count; i++) {
			Template templ;
			size_t len = 0;
			ctx.stream.read(reinterpret_cast<char*>(&len), sizeof(size_t));
			std::string key(len, 0);
			ctx.stream.read(key.data(), len);
			templ.unserialize(ctx);

			this->add(key, templ);
		}
	}
}
