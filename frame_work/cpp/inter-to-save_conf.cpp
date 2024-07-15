#include <fstream>
#include <string>
#include <iostream>
#include <vector>
using namespace std;

string name;

std::string getType(string& line) {
    int idx = line.find('=');
    return line.substr(idx + 1, line.size() - idx - 1);
};

string getParent(string& line) {
    int idx_n = line.find('=');
    int idx_f = line.find_last_of('|', idx_n);
    int idx_i = line.find_last_of('|', idx_f - 1);
    if (idx_f == -1) return string();
    if (idx_i == -1) return line.substr(0, idx_f);
    return line.substr(idx_i + 1, idx_f - idx_i - 1);
};

string getName(string& line) {
    int idx_f = line.find('=');
    int idx_i = line.find_last_of('|', idx_f);
    if (idx_i == -1) return line.substr(0, idx_f);
    return line.substr(idx_i + 1, idx_f - idx_i - 1);
};

vector<string> getFullParentPath(string& line) {
    int idx = 0;
    vector<string> parents = { "" };
    for (char c : line)
        if (c == '=') break;
        else if (c == '|') {
            idx++;
            parents.push_back("");
        }
        else {
            parents[idx].push_back(c);
        };
    parents.pop_back();
    return parents;
};

void print_path(string& name, vector<string>& parent_path) {
    if (parent_path.size())
        for (string parent : parent_path)
            cout << "[\"" << parent << "\"]";
    if (name == "0") cout << "[" << name << "]";
    else cout << "[\"" << name << "\"]";
};

void print_path_dot(string& name, vector<string>& parent_path) {
    if (parent_path.size())
        for (string parent : parent_path)
            cout << parent << ".";
    cout << name;
};

void proccess(string& line) {
    string tp = getType(line);
    string name = getName(line);
    if (tp == "map" || name == "0" ||
        !(tp == "std::string" || tp == "int" || tp == "bool" || tp == "list")) return;
    vector<string> parent_path = getFullParentPath(line);
    cout << "\t// " << line << endl;
    cout << "\tyaml";
    print_path(name, parent_path);
    cout << " = ";
    print_path_dot(name, parent_path);
    cout << ";" << endl;
};

int main(int argc, char** argv) {
    name = argv[1];
    ifstream file;
    file.open(argv[2]);
    string line;

    cout << "void save_t_" << name << "(t_" << name << "& " << name << ") {" << endl;
    cout << "\tYAML::Node yaml = YAML::LoadFile(\"./config/" << name << ".yaml\");" << endl;

    while (getline(file, line))
        proccess(line);
    file.close();

    cout << "\tstd::ofstream file_out(\"./config/" << name << ".yaml\");" << endl;
    cout << "\tfile_out << yaml;" << endl;
    cout << "\tfile_out.close();" << endl;
    cout << "};" << endl;
};