echo -e "#include \"./lib/window/window.hpp\"

int main() {
    Window win;
    win.run();
    return 0;
};
" &> $1/main.cpp