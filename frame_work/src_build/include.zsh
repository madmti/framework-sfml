echo -e "#ifndef Include_h\n#define Include_h\n
#include <SFML/Graphics.hpp>
#include <yaml-cpp/yaml.h>
#include <fstream>
#include <string>
#include <vector>

static const std::string STATIC_DIR = \"./static\";
static const std::string CONFIG_DIR = \"./config\";
\n#endif" &> $1/include.hpp
echo -e "#ifndef Types_h\n#define Types_h\n#include \"./include.hpp\"\n#define pack_rgba(r, g, b, a) (sf::Uint32)(r<<24|g<<16|b<<8|a)\n
typedef sf::Keyboard::Key Key;
typedef std::vector<Key> vectKey;
\n#endif" &> $1/types.hpp
