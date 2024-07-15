#include <cstdio>
#include <iostream>
#include <memory>
#include <stdexcept>
#include <string>
#include <array>
#include <map>
#include <vector>

std::string BLUE = "\033[0;34m";
std::string RED = "\033[0;31m";
std::string GREEN = "\033[0;32m";
std::string RESET = "\033[0m";

std::string exec(const char* cmd) {
    std::array<char, 128> buffer;
    std::string result;
    std::unique_ptr<FILE, decltype(&pclose)> pipe(popen(cmd, "r"), pclose);
    if (!pipe) {
        throw std::runtime_error("popen() failed!");
    };
    while (fgets(buffer.data(), static_cast<int>(buffer.size()), pipe.get()) != nullptr) {
        result += buffer.data();
    };
    return result;
};

std::string get_bash_dir() {
    return exec("echo -e \"$(cd $(dirname `dirname $0`) && pwd)\"/.framework/bash");
};

int get_n_commands(std::string dir) {
    std::string com = "cd " + dir + "ls -d */ | wc -w";
    std::string str_num = exec(com.c_str());
    return std::stoi(str_num.c_str());
};

std::string get_folder_names(std::string dir) {
    std::string com = "cd " + dir + "ls -d */";
    return exec(com.c_str());
};

std::vector<std::string> get_commands_names(std::string dir) {
    int n_commands = get_n_commands(dir);
    std::string names = get_folder_names(dir);
    std::vector<std::string> list = { "" };
    int idx = 0;
    for (char c : names)
        if (c == '\n') {
            idx++;
            list.push_back("");
        }
        else if (c == '/') continue;
        else list[idx].push_back(c);
    return list;
};

std::map<std::string, std::string> get_commands(std::string dir) {
    std::vector<std::string> names = get_commands_names(dir);
    std::map<std::string, std::string> coms_map;
    for (std::string name : names) {
        if (name.empty()) continue;
        std::string com = "cd " + dir + "cd " + name + "\ncat use.txt";
        std::string usage = exec(com.c_str());
        coms_map.insert_or_assign(name, usage);
    };
    return coms_map;
};

void print_usage_message(std::map<std::string, std::string> coms) {
    std::cout << "usage mode:\n\t" << GREEN << "./commands " << BLUE << "<command>" << RED << " <args>" << RESET << "\nAvailable commands:" << std::endl;
    for (auto it = coms.begin(); it != coms.end(); it++)
        std::cout << "\t" << it->second << std::endl;
};

std::string all_args(int argc, char** argv) {
    std::string all;
    for (int i = 2; i < argc; i++) {
        all.push_back(' ');
        all.append(argv[i]);
    };
    return all;
};

int main(int argc, char** argv) {
    std::string BASH_DIR = get_bash_dir();
    std::map<std::string, std::string> coms = get_commands(BASH_DIR);
    if (argc < 2) {
        print_usage_message(coms);
        return EXIT_FAILURE;
    };

    int is_com = coms.count(argv[1]);
    if (!is_com) {
        std::cout << "[NOT FOUND] command " << argv[1] << " was not found" << std::endl;
        print_usage_message(coms);
        return EXIT_FAILURE;
    };
    std::string com = "cd " + BASH_DIR + "bash ./" + (std::string)argv[1] + "/com.zsh" + all_args(argc, argv);
    std::string res = exec(com.c_str());
    std::cout << res << std::endl;
    return EXIT_SUCCESS;
};