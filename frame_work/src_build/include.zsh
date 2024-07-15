echo -e "#ifndef Include_h\n#define Include_h\n
#include <SFML/Graphics.hpp>
#include <string>
#include <vector>
\n#endif" &> $1/include.hpp
echo -e "#ifndef Types_h\n#define Types_h\n#include \"./include.hpp\"\n
typedef sf::Keyboard::Key Key;
typedef std::vector<Key> vectKey;
\n#endif" &> $1/types.hpp
