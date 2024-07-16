#ifndef View_default_h
#define View_default_h
#include "../abstract.hpp"

class View_default: public View {
private:
    sf::Texture img;

public:
    View_default(t_config* _config);
    ~View_default();

    void display();
    void capture(Key k);
    void clear();
};

#endif
