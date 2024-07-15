# Sources #
source $(dirname `dirname $0`)/dirs.txt
source $FW_DIR/bash/colors.txt

# Program #
echo -e "#ifndef Config_type_h\n#define Config_type_h\n#include \"./types.hpp\"
" &> $SRC_DIR/lib/config_type.hpp

echo -e "\n#endif" &>> $SRC_DIR/lib/config_type.hpp