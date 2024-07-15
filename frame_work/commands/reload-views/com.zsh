# Sources #
source $(dirname `dirname $0`)/dirs.txt
source $FW_DIR/bash/colors.txt

# Program #
echo -e "#ifndef Include_views_h\n#define Include_views_h\n" &> $SRC_DIR/views/include_views.hpp
for dir in $(ls -d $SRC_DIR/views/*/)
do
name=(${dir//// })
echo -e "#include \"./${name[-1]}/view.hpp\"\n" &>> $SRC_DIR/views/include_views.hpp
done
echo -e "#endif" &>> $SRC_DIR/views/include_views.hpp