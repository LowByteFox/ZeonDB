#include <zql2/parser.hpp>

#include <string>
#include <vector>
#include <utility>

namespace ZeonDB::ZQL {
	std::string AstNode::stringify() const {
		return "";
	}

	void KeyNode::set_version(std::string version) {
		this->version = version;
	}

	std::string KeyNode::get_version() {
		return this->version;
	}

	void KeyNode::set_array_index(size_t index) {
		this->array_bounds.first = index;
	}

	void KeyNode::set_array_range(size_t range) {
		this->array_bounds.second = range;
	}

	std::pair<int, int>& KeyNode::get_array_range() {
		return this->array_bounds;
	}

	size_t KeyNode::get_array_index() {
		return this->array_bounds.first;
	}

	std::string KeyNode::stringify() const {
		std::string str = this->name;

		if (this->version.length() > 0) {
			str += "@";
			str += this->version;
		}

		if (this->array_bounds.first >= 0) {
			if (this->array_bounds.second >= 0) {
				str += "[";
				str += std::to_string(this->array_bounds.first);
				str += "..";
				str += std::to_string(this->array_bounds.second);
				str += "]";
			} else {
				str += "[";
				str += std::to_string(this->array_bounds.first);
				str += "]";
			}
		}
		
		return str;
	}

	std::string CommandKeyNode::stringify() const {
		std::string str = "";
		if (this->size() == 0) {
			str += ".";
		}

		for (const auto& key : (*this)) {
			str += key.stringify();
			str += ".";
		}
		str.pop_back();

		return str;
	}

	ValueTypes CommandValueNode::get_type() {
		return this->value_type;
	}

	void CommandValueNode::set_text(std::string text) {
		this->text = text;
	}

	std::string CommandValueNode::get_text() {
		return this->text;
	}

	std::string CommandValueNode::stringify() const {
		return this->text;
	}

	std::string CommandEvalNode::get_cmd_name() {
		return this->command_name;
	}

	std::string CommandEvalNode::stringify() const {
		std::string str = this->command_name;
		for (const auto& node : (*this)) {
			str += " ";
			str += node->stringify();
		}

		return str;
	}

	void CommandEvalNode::set_cmd_name(std::string name) {
		this->command_name = name;
	}

	CommandKeyNode* Parser::parse_key(Token& tok, CommandKeyNode* n) {
		CommandKeyNode *node = n != nullptr ? n : new CommandKeyNode;

		KeyNode knode(this->code.substr(tok.col, tok.len));

start:
		tok = this->lexer.parse_token();

		if (tok.type == TokenTypes::dot) {
			tok = this->lexer.parse_token();
			this->parse_key(tok, node);
		} else if (tok.type == TokenTypes::at) {
			tok = this->lexer.parse_token();
			knode.set_version(this->code.substr(tok.col, tok.len));
			goto start;
		} else if (tok.type == TokenTypes::lsquarebracket) {
			tok = this->lexer.parse_token();
			knode.set_array_index(atoi(this->code.substr(tok.col, tok.len).c_str()));
			tok = this->lexer.parse_token();
			if (tok.type == TokenTypes::dot) {
				tok = this->lexer.parse_token();

				if (tok.type == TokenTypes::dot) {
					tok = this->lexer.parse_token();
					knode.set_array_range(atoi(this->code.substr(tok.col, tok.len).c_str()));
					this->lexer.parse_token();
				}
			}
			goto start;
		} else {
			this->lexer.step_back(tok.len);
		}

		node->insert(node->begin(), knode);
		return node;
	}

	CommandValueNode* Parser::parse_value(Token& tok) {
		CommandValueNode* node = nullptr;
		std::string value_s = this->code.substr(tok.col, tok.len);

		switch (tok.type) {
			case TokenTypes::string:
			case TokenTypes::identifier:
				node = new CommandValueNode(ValueTypes::String);
				node->set_text(value_s);
				return node;
			case TokenTypes::integer:
				node = new CommandValueNode(ValueTypes::Integer);
				node->set_text(value_s);
				return node;
			case TokenTypes::floating:
				node = new CommandValueNode(ValueTypes::Floating);
				node->set_text(value_s);
				return node;
			case TokenTypes::boolean:
				node = new CommandValueNode(ValueTypes::Boolean);
				node->set_text(value_s);
				return node;
			case TokenTypes::lsquarebracket:
				node = new CommandValueNode(ValueTypes::Array);
				break;
			case TokenTypes::lsquiglybracket:
				node = new CommandValueNode(ValueTypes::Object);
				break;
			default:
				return node;
		}

		if (tok.type == TokenTypes::lsquarebracket) {
			while (true) {
				tok = this->lexer.parse_token();
				if (tok.type == TokenTypes::rsquarebracket) break;
				else if (tok.type == TokenTypes::comma) {
					value_s += ',';
					continue;
				} else if (tok.type == TokenTypes::eof)
					return node;

				auto val = this->parse_value(tok);
				if (val == nullptr) break;

				value_s += val->get_text();
				delete val;
			}
			value_s += ']';
			node->set_text(value_s);
		} else if (tok.type == TokenTypes::lsquiglybracket) {
			bool key_parsed = false;

			while (true) {
				tok = this->lexer.parse_token();
				if (key_parsed == false) {
					if (tok.type == TokenTypes::rsquiglybracket) break;
					else if (tok.type == TokenTypes::comma) {
						value_s+=',';
						continue;
					}else if (tok.type == TokenTypes::eof)
						return node;
				} else {
					if (tok.type == TokenTypes::colon) {
						value_s+=':';
						continue;
					} else if (tok.type == TokenTypes::rsquiglybracket || tok.type == TokenTypes::eof)
						return node;
				}

				key_parsed = !key_parsed;

				auto val = this->parse_value(tok);
				if (val == nullptr) break;

				value_s += val->get_text();
				delete val;
			}
			value_s += '}';
			node->set_text(value_s);
		}

		return node;
	}

	CommandEvalNode Parser::parse() {
		Token tok = this->lexer.parse_token();

		CommandEvalNode node(this->code.substr(tok.col, tok.len));

		while (tok.type != TokenTypes::eof && tok.type != TokenTypes::illegal) {
			tok = this->lexer.parse_token();

			switch (tok.type) {
				case TokenTypes::identifier:
				case TokenTypes::dollar:
					node.push_back(this->parse_key(tok, nullptr));
					break;
				case TokenTypes::string:
				case TokenTypes::integer:
				case TokenTypes::floating:
				case TokenTypes::boolean:
				case TokenTypes::lsquarebracket:
				case TokenTypes::lsquiglybracket:
					node.push_back(this->parse_value(tok));
					break;
				default:
					break;
			}
		}

		return node;
	}
}
