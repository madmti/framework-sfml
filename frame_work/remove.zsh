FW_DIR=$(cd `dirname $0` && pwd)
SRC_DIR=$(pwd)

# Colors #
source $FW_DIR/colors.txt

# Program #
echo -e "${BRed}Removing...$RESET_COLOR"
rm -rf $SRC_DIR/src $SRC_DIR/.framework CMakeLists.txt $SRC_DIR/build