#pragma once

#include <string>
#include <map>
#include <memory>
#include <fstream>

#include <types.hpp>

namespace ZeonDB {
	struct SerializationContext;
	class TemplateStore;

	class Template: std::map<std::string, std::shared_ptr<ZeonDB::Types::Value>> {
		public:
			void add(std::string, std::shared_ptr<ZeonDB::Types::Value>);
			void remove(std::string);
			void serialize(std::fstream&);
			void unserialize(SerializationContext);

		friend class TemplateStore;
	};

	class TemplateStore: std::map<std::string, Template> {
		public:
			void add(std::string, Template);
			Template *get(std::string);
			std::shared_ptr<ZeonDB::Types::Value> create(std::string);
			void remove(std::string);

			void serialize(std::fstream&);
			void unserialize(SerializationContext);
	};
}
