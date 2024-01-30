#include <cstdio>
#include <string>
#include <unit_tester.hpp>
#include <zql2/parser.hpp>

using namespace ZeonDB::ZQL;

std::string test1() {
	KeyNode key("hey");
	return key.stringify();
}

std::string test2() {
	KeyNode key("hello");
	key.set_version("hmm");
	return key.stringify();
}

std::string test3() {
	KeyNode key("hello");
	key.set_version("hmm");
	key.set_array_index(7);
	return key.stringify();
}

std::string test4() {
	KeyNode key("ahoj");
	key.set_version("cau");
	key.set_array_index(4);
	key.set_array_range(10);
	return key.stringify();
}

std::string test5() {
	KeyNode key("hey");
	key.set_array_index(0);
	return key.stringify();
}

std::string test6() {
	KeyNode key("hey");
	key.set_array_index(0);
	key.set_array_range(0);
	return key.stringify();
}

std::string test7() {
	CommandKeyNode key_node;
	return key_node.stringify();
}

std::string test8() {
	CommandKeyNode key_node;
	KeyNode key1("hey");
	key1.set_version("lol");
	key1.set_array_index(7);
	key_node.push_back(key1);

	KeyNode key2("hm");
	key2.set_array_index(3);
	key2.set_array_range(4);
	key_node.push_back(key2);

	KeyNode key3("oven");
	key3.set_version("employees");
	key_node.push_back(key3);
	key_node.push_back(key1);
	key_node.push_back(key2);

	return key_node.stringify();
}

std::string test9() {
	CommandValueNode vnode(ValueTypes::String);
	vnode.set_text("\"Ale cau\"");

	return vnode.stringify();
}

std::string test10() {
	CommandEvalNode enode("set");
	auto knode = new CommandKeyNode();
	auto vnode = new CommandValueNode(ValueTypes::Array);
	vnode->set_text("[{name: \"Jarred Sumner\"}, {name: \"Dave Caruso\"}]");

	KeyNode key("oven");
	key.set_version("employees");
	knode->push_back(key);

	enode.push_back(knode);
	enode.push_back(vnode);

	return enode.stringify();
}

int main() {
	match(test1, std::string("hey"));
	match(test2, std::string("hello@hmm"));
	match(test3, std::string("hello@hmm[7]"));
	match(test4, std::string("ahoj@cau[4..10]"));
	match(test5, std::string("hey[0]"));
	match(test6, std::string("hey[0..0]"));
	match(test7, std::string(""));
	match(test8, std::string("hey@lol[7].hm[3..4].oven@employees.hey@lol[7].hm[3..4]"));
	match(test9, std::string("\"Ale cau\""));
	match(test10, std::string("set oven@employees [{name: \"Jarred Sumner\"}, {name: \"Dave Caruso\"}]"));
	return 0;
}
