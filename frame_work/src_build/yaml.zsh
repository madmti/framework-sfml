echo -e "#Window config
window:
  view_index: \"#default\"
  label: $2
  fps_limit: 60
  width: 1920
  height: 1080
  delta:
    x: 0
    y: 0
" &> $1/window.yaml

echo -e "#Theme config
theme:
  fonts:
    system:
      name: SLK
      path: $3/fonts/SLK/regular.ttf
      font: $(echo $)sf::Font
  
  colors:
    primary:
      src: $(echo $)sf::Color
      rgba: [ 0, 255, 0, 255 ]
    secondary:
      src: $(echo $)sf::Color
      rgba: [ 255, 255, 255, 200 ]
      
" &> $1/theme.yaml

echo -e "#User config
user:
  name: guess
" &> $1/user.yaml