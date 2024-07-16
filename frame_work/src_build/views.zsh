echo -e "#ifndef View_abstract_h\n#define View_abstract_h\n#include \"../lib/frame/view/frame.hpp\"
class View {
protected:
    std::string v_id;
    Frame_view frame;
    vectKey allowed_keys;
    t_config* config;

public:
    View(std::string _id, t_config* config);
    ~View();

    sf::Sprite get_sprite();
    vectKey& get_allowed_keys();

    virtual void display() = 0;
    virtual void capture(Key k) = 0;
    virtual void clear() = 0;
};
#endif" &> $1/abstract.hpp

echo -e "#include \"./abstract.hpp\"

View::View(std::string _id, t_config* _config) {
    v_id = _id;
    config = _config;
};
View::~View() {};

vectKey& View::get_allowed_keys() {
    return allowed_keys;
};

sf::Sprite View::get_sprite() {
    return frame.get_sprite();
};
" &> $1/abstract.cpp