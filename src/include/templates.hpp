#pragma once

#include <string>
#include <map>
#include <memory>

#include <types.hpp>

namespace ZeonDB {
	class TemplateStore;

	class Template: std::map<std::string, std::shared_ptr<ZeonDB::Types::Value>> {
		public:
			void add(std::string, std::shared_ptr<ZeonDB::Types::Value>);
			void remove(std::string);

		friend class TemplateStore;
	};

	class TemplateStore: std::map<std::string, Template> {
		public:
			void add(std::string, Template);
			Template *get(std::string);
			std::shared_ptr<ZeonDB::Types::Value> create(std::string);
			void remove(std::string);
	};
}
