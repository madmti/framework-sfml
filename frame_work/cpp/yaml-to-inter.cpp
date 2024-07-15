#include <iostream>
#include <string>
#include <yaml-cpp/yaml.h>
using namespace std;

bool is_number(const std::string& s) {
    std::string::const_iterator it = s.begin();
    while (it != s.end() && std::isdigit(*it)) ++it;
    return !s.empty() && it == s.end();
};

void print_type(std::string str) {
    int idx = str.find('$');
    if (idx != -1) cout << str.substr(idx + 1, str.size() - 1 - idx);
    else
        if (is_number(str))
            cout << "int";
        else if (str == "true" || str == "false" || str == "True" || str == "False" || str == "TRUE" || str == "FALSE")
            cout << "bool";
        else
            cout << "std::string";
};

void search_rec(std::string before, YAML::detail::iterator_value node);

void search_rec(std::string before, YAML::iterator it) {
    cout << before;
    cout << "=";

    if (it->IsMap()) {
        cout << "map";
        cout << endl;
        for (auto i : it->second)
            search_rec(before + "|" + it->first.as<std::string>(), i);
    }
    else if (it->IsSequence()) {
        cout << "list";
        for (auto i = it->second.begin(); i != it->second.end(); i++) {
            const YAML::Node& n = *i;
            cout << endl;
            search_rec(before + "|" + it->first.as<std::string>() + "|0", i);
            break;
        };
    }
    else {
        print_type(it->as<std::string>());
        cout << endl;
    };
};

void search_rec(std::string before, YAML::detail::iterator_value node) {
    if (before.empty()) cout << node.first;
    else cout << before << "|" << node.first;

    cout << "=";

    if (node.second.IsMap()) {
        cout << "map";
        cout << endl;
        for (auto it : node.second)
            if (before.empty()) search_rec(node.first.as<std::string>(), it);
            else search_rec(before + "|" + node.first.as<std::string>(), it);
    }
    else if (node.second.IsSequence()) {
        cout << "list";
        for (auto it = node.second.begin(); it != node.second.end(); it++) {
            cout << endl;
            search_rec(before + "|" + node.first.as<std::string>() + "|0", it);
            break;
        };
    }
    else {
        print_type(node.second.as<std::string>());
        cout << endl;
    };

};

int main(int argc, char** argv) {
    YAML::Node yaml = YAML::LoadFile(argv[2]);
    for (auto node : yaml) search_rec("", node);
    return 0;
};