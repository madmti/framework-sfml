echo -e "#ifndef Window_h\n#define Window_h\n#include \"../../views/include_views.hpp\"

class Window {
private:
    sf::RenderWindow win;
    std::map<std::string, View*> views;
    t_config config;
    bool should_close;

    bool check_allowed_keys(View* view, Key k);
    
    void display_view();
    void capture_view(sf::Event ev);
    void clear_view();

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
        if (it->second)
            delete it->second;
};

void Window::run() {
    setup();
    main_loop();
};

bool Window::check_allowed_keys(View* view, Key k) {
    vectKey allowed_keys = view->get_allowed_keys();
    for (Key key : allowed_keys)
        if (key == k)
            return true;
    return false;
};

void Window::display_view() {
    if (views.count(config.window.view_index) == 0) return;
    View* actual_view = views[config.window.view_index];
    actual_view->display();
    sf::Sprite view_sprite = actual_view->get_sprite();
    win.draw(view_sprite);
};
void Window::capture_view(sf::Event ev) {
    if (ev.type != sf::Event::KeyPressed ||
        views.count(config.window.view_index) == 0) return;

    View* actual_view = views[config.window.view_index];

    if (check_allowed_keys(actual_view, ev.key.code))
        actual_view->capture(ev.key.code);
};
void Window::clear_view() {
    if (views.count(config.window.view_index) == 0) return;
    View* actual_view = views[config.window.view_index];
    actual_view->clear();
};

void Window::display() {
    display_view();
    win.display();
};
void Window::capture() {
    sf::Event ev;
    while(win.pollEvent(ev)) {
        if (ev.type == sf::Event::Closed) win.close();
        capture_view(ev);
    };
};
void Window::clear() {
    clear_view();
    win.clear();
};
void Window::setup() {
    if (!valid_config()) exit(1);
    load_config(config);
    views = get_all_views(&config);
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