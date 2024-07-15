# Sources #
source $(dirname `dirname $0`)/dirs.txt
source $FW_DIR/bash/colors.txt

# Program #
# config_type.hpp
echo -e "#ifndef Config_type_h\n#define Config_type_h\n#include \"./types.hpp\"
" &> $SRC_DIR/lib/config_type.hpp

for yaml in $(ls $SRC_DIR/config | grep .yaml)
do
name=(${yaml//./ })
echo -e "/*============================================
            $name CONFIG TYPE
============================================*/" &>> $SRC_DIR/lib/config_type.hpp
$FW_DIR/utils/yaml-to-inter ${name[0]} $SRC_DIR/config/$yaml &> $FW_DIR/inter/${name[0]}.txt
$FW_DIR/utils/inter-to-struct ${name[0]} $FW_DIR/inter/${name[0]}.txt &>> $SRC_DIR/lib/config_type.hpp
echo -e "bool valid_t_$name();
void load_t_$name(t_$name& $name);
void save_t_$name(t_$name& $name);\n" &>> $SRC_DIR/lib/config_type.hpp
done

echo -e "/*============================================
            GENERAL CONFIG TYPE
============================================*/
struct t_config {" &>> $SRC_DIR/lib/config_type.hpp
for yaml in $(ls $SRC_DIR/config | grep .yaml)
do
name=(${yaml//./ })
echo -e "\tt_${name[0]} ${name[0]};" &>> $SRC_DIR/lib/config_type.hpp
done
echo -e "};
bool valid_config();
void load_config(t_config& conf);
void save_config(t_config& conf);" &>> $SRC_DIR/lib/config_type.hpp
echo -e "\n#endif" &>> $SRC_DIR/lib/config_type.hpp



# config_type.cpp
echo -e "#include \"./config_type.hpp\"
bool is_int(const std::string& s) {
	std::string::const_iterator it = s.begin();
	while (it != s.end() && std::isdigit(*it)) ++it;
	return !s.empty() && it == s.end();
};
bool is_bool(const std::string& s) {
	return s == \"true\" || s == \"false\" || s == \"True\" || s == \"False\" || s == \"TRUE\" || s == \"FALSE\";
};

void assing(int& ref, YAML::Node node) {
    int num = std::stoi(node.as<std::string>().c_str());
    ref = num;
};
void assing(std::string& ref, YAML::Node node) {
    ref = node.as<std::string>();
};
void assing(sf::Font& ref, YAML::Node node) {
    std::string path = node["path"].as<std::string>();
    ref.loadFromFile(path);
};
void assing(sf::Color& ref, YAML::Node node) {
	int alpha;
	assing(alpha, node["alpha"]);
	std::vector<int> rgb;
	for (auto it = node.begin(); it != node.end(); it++) {
		int val;
		assing(val, it->second);
		rgb.push_back(val);
	};
	sf::Uint32 rgba = pack_rgba(rgb[0], rgb[1], rgb[2], alpha);
	ref = sf::Color{ rgba };
};
void assing_list(std::vector<int>& ref, YAML::Node node) {
	for (auto it = node.begin(); it != node.end(); it++) {
		int val;
		assing(val, it->second);
		ref.push_back(val);
	};
};
void assing_list(std::vector<std::string>& ref, YAML::Node node) {
	for (auto it = node.begin(); it != node.end(); it++) {
		std::string val;
		assing(val, it->second);
		ref.push_back(val);
	};
};
" &> $SRC_DIR/lib/config_type.cpp
for yaml in $(ls $SRC_DIR/config | grep .yaml)
do
name=(${yaml//./ })
echo -e "/*============================================
            $name CONFIG FUNCS
============================================*/" &>> $SRC_DIR/lib/config_type.cpp
$FW_DIR/utils/inter-to-valid_conf ${name[0]} $FW_DIR/inter/${name[0]}.txt &>> $SRC_DIR/lib/config_type.cpp
$FW_DIR/utils/inter-to-load_conf ${name[0]} $FW_DIR/inter/${name[0]}.txt &>> $SRC_DIR/lib/config_type.cpp
$FW_DIR/utils/inter-to-save_conf ${name[0]} $FW_DIR/inter/${name[0]}.txt &>> $SRC_DIR/lib/config_type.cpp
done

echo -e "/*============================================
            GENERAL CONFIG FUNCS
============================================*/

bool valid_config() {
\treturn true" &>> $SRC_DIR/lib/config_type.cpp
for yaml in $(ls $SRC_DIR/config | grep .yaml)
do
name=(${yaml//./ })
echo -e "\t&& valid_t_$name()" &>> $SRC_DIR/lib/config_type.cpp
done
echo -e "\t;\n};" &>> $SRC_DIR/lib/config_type.cpp

echo -e "void load_config(t_config& conf) {" &>> $SRC_DIR/lib/config_type.cpp
for yaml in $(ls $SRC_DIR/config | grep .yaml)
do
name=(${yaml//./ })
echo -e "\tload_t_$name(conf.$name);" &>> $SRC_DIR/lib/config_type.cpp
done
echo -e "};" &>> $SRC_DIR/lib/config_type.cpp

echo -e "void save_config(t_config& conf) {" &>> $SRC_DIR/lib/config_type.cpp
for yaml in $(ls $SRC_DIR/config | grep .yaml)
do
name=(${yaml//./ })
echo -e "\tsave_t_$name(conf.$name);" &>> $SRC_DIR/lib/config_type.cpp
done
echo -e "};" &>> $SRC_DIR/lib/config_type.cpp