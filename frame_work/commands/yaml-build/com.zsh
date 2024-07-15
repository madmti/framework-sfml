# Sources #
source $(dirname `dirname $0`)/dirs.txt
source $FW_DIR/bash/colors.txt

# Program #
echo -e "#ifndef Config_type_h\n#define Config_type_h\n#include \"./types.hpp\"
" &> $SRC_DIR/lib/config_type.hpp

for yaml in $(ls $SRC_DIR/config | grep .yaml)
do
name=(${yaml//./ })
$FW_DIR/utils/yaml-to-inter ${name[0]} $SRC_DIR/config/$yaml &> $FW_DIR/inter/${name[0]}.txt
$FW_DIR/utils/inter-to-struct ${name[0]} $FW_DIR/inter/${name[0]}.txt &>> $SRC_DIR/lib/config_type.hpp
done

echo -e "struct t_config {" &>> $SRC_DIR/lib/config_type.hpp
for yaml in $(ls $SRC_DIR/config | grep .yaml)
do
name=(${yaml//./ })
echo -e "\tt_${name[0]} ${name[0]};" &>> $SRC_DIR/lib/config_type.hpp
done
echo -e "};" &>> $SRC_DIR/lib/config_type.hpp
echo -e "\n#endif" &>> $SRC_DIR/lib/config_type.hpp