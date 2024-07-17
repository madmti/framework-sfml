FW_DIR=$(cd `dirname $0` && pwd)
SRC_DIR=$(pwd)
rm -rf $FW_DIR/temp/*
# Colors #
source $FW_DIR/colors.txt

# First prompt #
if [ -z $1 ]
then
echo -e "Insert the app name:"
read -r NAME
else
NAME=$1
fi
clear

# Create src folder #
echo -e "$BBlue[BUILDING]$RESET_COLOR"
echo -e "Creating source folder for ${BBlue}$NAME${RESET_COLOR}..."

mkdir $SRC_DIR/src $SRC_DIR/src/views $SRC_DIR/src/config $SRC_DIR/src/static $SRC_DIR/src/lib $SRC_DIR/src/lib/window $SRC_DIR/src/lib/frame $SRC_DIR/src/lib/frame/view
mkdir $SRC_DIR/.framework $SRC_DIR/.framework/bash $SRC_DIR/.framework/utils $SRC_DIR/.framework/cpp_refs $SRC_DIR/.framework/inter

# .framework/bash files #
cp -r $FW_DIR/commands/* $SRC_DIR/.framework/bash
cp $FW_DIR/colors.txt $SRC_DIR/.framework/bash
echo -e "FW_DIR=$SRC_DIR/.framework\nSRC_DIR=$SRC_DIR/src" &> $SRC_DIR/.framework/bash/dirs.txt

# .framework/cpp_refs #
cp -r $FW_DIR/cpp/* $SRC_DIR/.framework/cpp_refs

# build .framework cpps #
for cpp in $(ls $SRC_DIR/.framework/cpp_refs)
do
name=(${cpp//./ })
echo -e "============================================================================" &>> $FW_DIR/temp/build
echo -e "${name[0]}" &>> $FW_DIR/temp/build
echo -e "============================================================================" &>> $FW_DIR/temp/build
if [ $cpp == "commands.cpp" ]
then
g++ -o $SRC_DIR/src/${name[0]} $SRC_DIR/.framework/cpp_refs/$cpp &>> $FW_DIR/temp/build
else
g++ -l yaml-cpp -o $SRC_DIR/.framework/utils/${name[0]} $SRC_DIR/.framework/cpp_refs/$cpp &>> $FW_DIR/temp/build
fi
done

# Create cpp files for src/views #
echo -e "Loading ${BGreen}views/$RESET_COLOR..."
bash $FW_DIR/src_build/views.zsh $SRC_DIR/src/views
cp -r $FW_DIR/sample_view/* $SRC_DIR/src/views
bash $SRC_DIR/.framework/bash/reload-views/com.zsh

# Create files for src/static #
echo -e "Loading ${BGreen}static/$RESET_COLOR..."
bash $FW_DIR/src_build/static.zsh $FW_DIR/sample_statics $SRC_DIR/src/static

# Create yaml files for src/config #
echo -e "Loading ${BGreen}config/$RESET_COLOR..."
bash $FW_DIR/src_build/yaml.zsh $SRC_DIR/src/config $NAME $SRC_DIR/src/static

# Create cpp files for src/lib #
# window
echo -e "Loading ${BGreen}lib/$RESET_COLOR..."
bash $FW_DIR/src_build/window.zsh $SRC_DIR/src/lib/window $NAME
# include and types
bash $FW_DIR/src_build/include.zsh $SRC_DIR/src/lib
# frame
bash $FW_DIR/src_build/frame.zsh $SRC_DIR/src/lib/frame

# Build config type #
echo -e "Building ${BPurple}Config type struct$RESET_COLOR..."
bash $SRC_DIR/.framework/bash/yaml-build/com.zsh

# Create main.cpp file #
bash $FW_DIR/src_build/main.zsh $SRC_DIR/src

# CMAKE #
bash $FW_DIR/cmake/lists.zsh $SRC_DIR $NAME
bash $FW_DIR/cmake/source_bin.zsh $SRC_DIR

# Final message #
echo -e "${BGreen}[READY]$RESET_COLOR ${BBlue}$NAME$RESET_COLOR app was succesfully build at:\n${BPurple}$SRC_DIR/src$RESET_COLOR"
