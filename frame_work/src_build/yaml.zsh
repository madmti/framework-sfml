echo -e "#Window config
window:
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
    default:
      name: SLK
      path: $3/fonts/SLK/regular.ttf
      !sf::Font: !font
  
  colors:
    primary:
      rgb: [ 0, 255, 0 ]
      alpha: 255
    secondary:
      rgb: [ 255, 255, 255 ]
      alpha: 100
      
" &> $1/theme.yaml

echo -e "#User config
user:
  name: guess
" &> $1/user.yaml