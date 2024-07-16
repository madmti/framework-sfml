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

public:
    View_${1}(t_config* _config);
    ~View_${1}();

    void display();
    void capture(Key k);
    void clear();
};\n
#endif" &> $SRC_DIR/views/$1/view.hpp
echo -e "#include \"./view.hpp\"\n
View_${1}::View_${1}(t_config* _config) : View(\"#$1\", _config) {
    frame.set_config(
        // delta pos
        sf::Vector2f(_config->window.delta.x, _config->window.delta.y),
        // frame size
        sf::Vector2i(_config->window.width, _config->window.height)
    );
    allowed_keys = vectKey{
        // Allowed keys for this view
    };

};
View_${1}::~View_${1}() {};

void View_${1}::display() {
    sf::Text title(\"$1\", config->theme.fonts.system.font);
    title.setCharacterSize(150);
    title.setPosition(100, 0);
    title.setFillColor(config->theme.colors.primary.src);

    frame.draw(title);
};
void View_${1}::capture(Key k) {
    switch(k) {
    
    };
};
void View_${1}::clear() {
    frame.clear();
};
" &> $SRC_DIR/views/$1/view.cpp

# exec reload-views #
bash $FW_DIR/bash/reload-views/com.zsh