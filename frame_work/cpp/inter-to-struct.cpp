#include <fstream>
#include <string>
#include <iostream>
#include <map>
using namespace std;

template<typename T>
class Stack {
private:
    struct Node {
        Node* next = nullptr;
        T val;
        Node() {};
        Node(T _val) { val = _val; };
    };
    Node* head = nullptr;
    int n = 0;
public:
    Stack();
    ~Stack();

    void clear();
    int size();

    void push(T val);

    bool pop(T& val);
    bool pop();
};

template<typename T>
Stack<T>::Stack() {};

template<typename T>
Stack<T>::~Stack() {
    clear();
};

template<typename T>
void Stack<T>::clear() {
    Node* temp = head;
    Node* ante;
    while (temp != nullptr) {
        ante = temp;
        temp = temp->next;
        delete ante;
    };
    head = nullptr;
};

template<typename T>
int Stack<T>::size() {
    return n;
};

template<typename T>
void Stack<T>::push(T val) {
    if (n == 0) head = new Node(val);
    else {
        Node* temp = head;
        head = new Node(val);
        head->next = temp;
    };
    n++;
};

template<typename T>
bool Stack<T>::pop(T& val) {
    if (n == 0) return false;
    Node* temp = head;
    head = head->next;
    val = temp->val;
    delete temp;
    n--;
    return true;
};

template<typename T>
bool Stack<T>::pop() {
    if (n == 0) return false;
    Node* temp = head;
    head = head->next;
    delete temp;
    n--;
    return true;
};

Stack<std::string> orden;
std::map<std::string, std::string>  code;

std::string getType(std::string& line) {
    int idx = line.find('=');
    return line.substr(idx + 1, line.size() - idx - 1);
};

std::string getParent(std::string& line) {
    int idx_n = line.find('=');
    int idx_f = line.find_last_of('|', idx_n);
    int idx_i = line.find_last_of('|', idx_f - 1);
    if (idx_f == -1) return std::string();
    if (idx_i == -1) return line.substr(0, idx_f);
    return line.substr(idx_i + 1, idx_f - idx_i - 1);
};

std::string getName(std::string& line) {
    int idx_f = line.find('=');
    int idx_i = line.find_last_of('|', idx_f);
    if (idx_i == -1) return line.substr(0, idx_f);
    return line.substr(idx_i + 1, idx_f - idx_i - 1);
};

void do_map(std::string& tp, std::string& name, std::string& parent) {
    if (!parent.empty()) {
        code[parent] += "\tt_" + name + " " + name + ";\n";
    };
    code.insert_or_assign(name, "struct t_" + name + " {\n");
    orden.push(name);
};

void do_list(std::string& tp, std::string& name, std::string& parent) {
    if (!parent.empty()) {
        code[parent] += "\tt_" + name + " " + name + ";\n";
    };
    code.insert_or_assign(name, "typedef std::vector<");
    orden.push(name);
};

void do_first_value(std::string& tp, std::string& name, std::string& parent) {
    code[parent] += tp + "> t_" + parent + ";\n";
};

void do_value(std::string& tp, std::string& name, std::string& parent) {
    if (!parent.empty()) {
        code[parent] += "\t" + tp + " " + name + ";\n";
    };
};

void process(std::string& line) {
    std::string tp = getType(line);
    std::string name = getName(line);
    std::string parent = getParent(line);

    if (name == "0") do_first_value(tp, name, parent);
    else
        if (tp == "map") do_map(tp, name, parent);
        else if (tp == "list") do_list(tp, name, parent);
        else do_value(tp, name, parent);
};

void print_structs() {
    while (orden.size()) {
        std::string name;
        orden.pop(name);
        if (code[name].find("typedef") == -1)
            cout << code[name] << "};\n";
        else
            cout << code[name];
    };
};

int main(int argc, char** argv) {
    ifstream file;
    file.open(argv[2]);
    string line;
    while (getline(file, line))
        process(line);
    file.close();
    print_structs();
};