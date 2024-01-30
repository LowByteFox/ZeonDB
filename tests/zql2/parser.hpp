#pragma once

#include <map>
#include <string>
#include <vector>
#include <utility>
#include <memory>

#include <zql2/lexer.hpp>

namespace ZeonDB::ZQL {
	enum class AstType {
		KeyNode,
		ValueNode,
		KeywordNode,
		CommandNode
	};

	enum class ValueTypes {
		String,
		Integer,
		Floating,
		Boolean,
		Array,
		Object
	};

	struct AstNode {
		public:
			AstType type;
			virtual std::string stringify() const;
	};

	class KeyNode {
		private:
			std::string name;
			std::string version;
			std::pair<int, int> array_bounds;
		public:
			KeyNode(std::string key_name): name(key_name) {
				this->version = "";
				this->array_bounds = std::make_pair(-1, -1);
			}
			void set_version(std::string);
			std::string get_version();
			void set_array_index(size_t);
			void set_array_range(size_t);
			std::pair<int, int>& get_array_range();
			size_t get_array_index();
			std::string stringify() const;
	};

	class CommandKeyNode: public AstNode, public std::vector<KeyNode> {
		public:
			CommandKeyNode() {
				this->type = AstType::KeyNode;
			}
			std::string stringify() const override;
	};

	class CommandValueNode: public AstNode {
		private:
			std::string text;
			ValueTypes value_type;
		public:
			CommandValueNode(ValueTypes type): value_type(type) {
				this->type = AstType::ValueNode;
			}
			ValueTypes get_type();
			void set_text(std::string);
			std::string get_text();
			std::string stringify() const override;
	};

	class CommandEvalNode: public AstNode, public std::vector<AstNode*> {
		private:
			std::string command_name;
		public:
			CommandEvalNode(std::string name): command_name(name) {
				this->type = AstType::CommandNode;
			}

			~CommandEvalNode() {
				for (auto& ptr : (*this)) {
					delete ptr;
				}
			}

			void set_cmd_name(std::string);
			std::string get_cmd_name();
			std::string stringify() const override;
	};

	class Parser {
		private:
			Lexer lexer;
			std::string code;
			CommandValueNode* parse_value(Token&);
			CommandKeyNode* parse_key(Token&, CommandKeyNode*);
		public:
			Parser(std::string text): lexer(text), code(text) {}
			CommandEvalNode parse();
	};
}
