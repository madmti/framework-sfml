# Sources #
source $(dirname `dirname $0`)/dirs.txt
source $FW_DIR/bash/colors.txt

# HPP #
echo -e "#ifndef Include_views_h\n#define Include_views_h\n" &> $SRC_DIR/views/include_views.hpp
for dir in $(ls -d $SRC_DIR/views/*/)
do
name=(${dir//// })
echo -e "#include \"./${name[-1]}/view.hpp\"\n" &>> $SRC_DIR/views/include_views.hpp
done
echo -e "std::map<std::string, View*> get_all_views(t_config* config);\n#endif" &>> $SRC_DIR/views/include_views.hpp

# CPP #
echo -e "#include \"include_views.hpp\"\n
std::map<std::string, View*> get_all_views(t_config* config) {
\tstd::map<std::string, View*> views;" &> $SRC_DIR/views/include_views.cpp
for dir in $(ls -d $SRC_DIR/views/*/)
do
name=(${dir//// })
echo -e "\t//${name[-1]}" &>> $SRC_DIR/views/include_views.cpp
echo -e "\tviews.insert_or_assign(\"#${name[-1]}\", new View_${name[-1]}(config));" &>> $SRC_DIR/views/include_views.cpp
done
echo -e "\treturn views;\n};" &>> $SRC_DIR/views/include_views.cpp
