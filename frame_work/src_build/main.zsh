echo -e "#include \"./lib/window/window.hpp\"

Window win;

int main() {
    win.run();
    return 0;
};
" &> $1/main.cpp
