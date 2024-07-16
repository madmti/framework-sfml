echo -e "#ifndef Window_h\n#define Window_h\n#include \"../../views/include_views.hpp\"

class Window {
private:
    sf::RenderWindow win;
    std::map<std::string, View*> views;
    t_config config;
    bool should_close;

    void display();
    void capture();
    void clear();

    void main_loop();
    void setup();
public:
    Window();
    ~Window();

    void run();
    void clean();
};
#endif" &> $1/window.hpp
echo -e "#include \"./window.hpp\"

Window::Window() {};
Window::~Window() {
    clean();
};

void Window::clean() {
    for (auto it = views.begin(); it != views.end(); it++)
        if (it->second != nullptr)
            delete it->second;
};

void Window::run() {
    setup();
    main_loop();
};

void Window::display() {
    // <- display view
    win.display();
};
void Window::capture() {
    sf::Event ev;
    while(win.pollEvent(ev)) {
        if (ev.type == sf::Event::Closed) win.close();
        // <- else check keys and capture view
    };
};
void Window::clear() {
    // <- clear view
    win.clear();
};
void Window::setup() {
    if (!valid_config()) exit(1);
    load_config(config);
    should_close = false;
    sf::VideoMode win_mode(config.window.width, config.window.height);
    win.create(win_mode, \"$2\");
};
void Window::main_loop() {
    while(win.isOpen() && !should_close) {
        capture();
        clear();
        display();
        sf::sleep(sf::milliseconds(sf::Uint32(1000/config.window.fps_limit)));
    };
};" &> $1/window.cpp