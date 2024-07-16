#include "./view.hpp"

View_default::View_default(t_config* _config) : View("#default", _config) {
    frame.set_config(
        // delta pos
        sf::Vector2f(_config->window.delta.x, _config->window.delta.y),
        // frame size
        sf::Vector2i(_config->window.width, _config->window.height)
    );
    allowed_keys = vectKey{
        // Allowed keys for this view
    };

    // setup your things
    img.loadFromFile("./static/img/madmti.png");
};
View_default::~View_default() {};

void View_default::display() {
    sf::Vector2f center(
        config->window.width / 2 - 400,
        config->window.height / 2 - 200
    );

    sf::Sprite logo(img);
    logo.setPosition(10 + center.x, 60 + center.y);
    logo.scale(0.022f, 0.022f);

    frame.draw(logo);

    sf::Text title("default", config->theme.fonts.system.font);
    title.setCharacterSize(150);
    title.setPosition(100 + center.x, 0 + center.y);
    title.setFillColor(config->theme.colors.primary.src);

    frame.draw(title);
};
void View_default::capture(Key k) {
    switch(k) {
    
    };
};
void View_default::clear() {
    frame.clear();
};

