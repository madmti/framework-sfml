# ABSTRACT HPP #
echo -e "#ifndef Frame_abstract_h\n#define Frame_abstract_h\n#include \"../config_type.hpp\"\n
class Frame {
protected:
    sf::Vector2f pos;
    sf::Vector2i size;
    sf::Vector2f scale;
    sf::RenderTexture tex;
    bool valid;
public:
    Frame(sf::Vector2f pos, sf::Vector2i size);
    Frame(sf::Vector2i size);
    Frame();

    virtual void draw(sf::RectangleShape _shape) = 0;
    virtual void draw(sf::Text _shape) = 0;
    virtual void draw(sf::Sprite _shape) = 0;
    virtual void clear() = 0;
    void display();

    void mul_scale(float k);
    void set_scale(float k);
    void set_size(sf::Vector2i new_size);
    void set_pos(sf::Vector2f new_pos);

    sf::Sprite get_sprite();
    void set_config(sf::Vector2f pos, sf::Vector2i size);
    void set_config(sf::Vector2i size);
};
\n#endif" &> $1/abstract.hpp
# ABSTRACT CPP #
echo -e "#include \"abstract.hpp\"\n
Frame::Frame(sf::Vector2f _pos, sf::Vector2i _size) : scale{ 1, 1 } {
    tex.create(_size.x, _size.y);
    pos = _pos;
    size = _size;
    valid = true;
};
Frame::Frame(sf::Vector2i _size) : scale{ 1, 1 }, pos{ 0, 0 } {
    tex.create(_size.x, _size.y);
    size = _size;
    valid = true;
};
Frame::Frame() : size{ 0, 0 }, scale{ 1, 1 }, pos{ 0, 0 } {
    valid = false;
};
void Frame::display() {
    tex.display();
};
void Frame::set_scale(float k) {
    scale = sf::Vector2f(k, k);
};
void Frame::mul_scale(float k) {
    scale = sf::Vector2f(
        scale.x * k,
        scale.y * k
    );
};
void Frame::set_size(sf::Vector2i new_size) {
    scale = sf::Vector2f(
        (new_size.x / size.x) * scale.x,
        (new_size.y / size.y) * scale.y
    );
};
void Frame::set_pos(sf::Vector2f new_pos) {
    pos = new_pos;
};
sf::Sprite Frame::get_sprite() {
    display();
    sf::Sprite tempSprite(tex.getTexture(), sf::IntRect(sf::Vector2i(0, 0), size));
    tempSprite.scale(scale);
    tempSprite.setPosition(pos);
    return sf::Sprite(tempSprite);
};
void Frame::set_config(sf::Vector2f _pos, sf::Vector2i _size) {
    pos = _pos;
    tex.create(_size.x, _size.y);
    size = _size;
    valid = true;
};
void Frame::set_config(sf::Vector2i _size) {
    tex.create(_size.x, _size.y);
    size = _size;
    valid = true;
};" &> $1/abstract.cpp
# VIEW FRAME HPP #
echo -e "#ifndef Frame_view_h\n#define Frame_view_h\n#include \"../abstract.hpp\"\n
class Frame_view: public Frame {
private:

public:
    Frame_view();
    ~Frame_view();

    void draw(sf::RectangleShape _shape);
    void draw(sf::Text _shape);
    void draw(sf::Sprite _shape);
    void clear();
};
#endif" &> $1/view/frame.hpp
# VIEW FRAME CPP #
echo -e "#include \"./frame.hpp\"
Frame_view::Frame_view() :Frame() {};
Frame_view::~Frame_view() {};

void Frame_view::draw(sf::RectangleShape _shape) {
    if (!valid) return;
    tex.draw(_shape);
};
void Frame_view::draw(sf::Text _shape) {
    if (!valid) return;
    tex.draw(_shape);
};
void Frame_view::draw(sf::Sprite _shape) {
    if (!valid) return;
    tex.draw(_shape);
};

void Frame_view::clear() {
    tex.clear(sf::Color::Black);
};" &> $1/view/frame.cpp
