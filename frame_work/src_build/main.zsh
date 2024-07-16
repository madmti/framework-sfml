echo -e "#include \"./lib/window/window.hpp\"

Window win;

// Prevents memory leak at exit error
void clean_app() {
    win.clean();
};

int main() {
    atexit(clean_app);
    win.run();
    return 0;
};
" &> $1/src/main.cpp


CMAKE_VERSION=($(cmake --version | grep version))
echo -e "cmake_minimum_required(VERSION ${CMAKE_VERSION[2]})
project($2 VERSION 0.1.0 LANGUAGES CXX)

include(CTest)
enable_testing()

file(GLOB SOURCES
    src/*.hpp
    src/*.cpp
    src/**/*.hpp
    src/**/*.cpp
    src/**/**/*.hpp
    src/**/**/*.cpp
    src/**/**/**/*.hpp
    src/**/**/**/*.cpp
)

add_executable($2 $(echo $){SOURCES})

set(CPACK_PROJECT_NAME $(echo $){PROJECT_NAME})
set(CPACK_PROJECT_VERSION $(echo $){PROJECT_VERSION})
include(CPack)

file(COPY src/static DESTINATION $(echo $){PROJECT_BINARY_DIR})
file(COPY src/config DESTINATION $(echo $){PROJECT_BINARY_DIR})

find_package(SFML 2.6.1 COMPONENTS system window graphics audio REQUIRED)
target_link_libraries($2 sfml-graphics sfml-audio sfml-system sfml-window)

target_link_libraries($2 yaml-cpp)" &> $1/CMakeLists.txt