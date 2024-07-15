# Sources #
source $(dirname `dirname $0`)/dirs.txt
source $FW_DIR/bash/colors.txt

# Program #
if [ -d $SRC_DIR/views/$1 ]
    then
        echo -e "view $BBlue$1$RESET_COLOR already exists"
        exit 0
fi

mkdir $SRC_DIR/views/$1
echo -e "#ifndef View_${1}_h\n#define View_${1}_h\n#include \"../abstract.hpp\"\n
class View_${1}: public View {
private:
    vectKey allowed_keys;
public:
    View_${1}();
    ~View_${1}();

    void display();
    void capture(Key k);
    void clear();
};\n
#endif" &> $SRC_DIR/views/$1/view.hpp
echo -e "#include \"./view.hpp\"\n
View_${1}::View_${1}() : View(\"#$1\") {
    allowed_keys = vectKey{
        // Allowed keys for this view
    };
};
View_${1}::~View_${1}() {};

void View_${1}::display() {
    // Draw on the view frame
};
void View_${1}::capture(Key k) {
    switch(k) {
    
    };
};
void View_${1}::clear() {};
" &> $SRC_DIR/views/$1/view.cpp

# exec reload-views #
bash $FW_DIR/bash/reload-views/com.zsh