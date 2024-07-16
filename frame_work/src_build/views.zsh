echo -e "#ifndef View_abstract_h\n#define View_abstract_h\n#include \"../lib/frame/view/frame.hpp\"
class View {
protected:
    std::string v_id;
    Frame_view frame;

public:
    View(std::string _id);
    ~View();

    sf::Sprite getSprite();

    virtual void display() = 0;
    virtual void capture(Key k) = 0;
    virtual void clear() = 0;
};
#endif" &> $1/abstract.hpp

echo -e "#include \"./abstract.hpp\"

View::View(std::string _id) {
    v_id = _id;
};
View::~View() {};

sf::Sprite getSprite() {
    //| <- return frame sprite
};
" &> $1/abstract.cpp