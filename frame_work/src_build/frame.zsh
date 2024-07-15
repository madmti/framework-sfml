echo -e "#ifndef Frame_h\n#define Frame_h\n#include \"../types.hpp\"\n

\n#endif" &> $1/frame.hpp
echo -e "#include \"frame.hpp\"\n
" &> $1/frame.cpp
