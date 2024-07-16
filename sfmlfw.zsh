FW_DIR=$(cd `dirname $0` && cd ./frame_work && pwd)
SRC_DIR=$(pwd)

# Colors #
source $FW_DIR/colors.txt

# Funcs #
usage_msg() {
    echo -e "usage mode:
    sfmlfw $Blue<comand>$RESET_COLOR
Aviable commands:
    ${Blue}new$RESET_COLOR             creates a new sfml project
    ${Blue}del$RESET_COLOR             deletes the src/ and .framework/ folders"
}

# Program #
if [ $# -lt 1 ] || [ $# -gt 2 ]
then
usage_msg
exit 1
fi

if [ $1 == "new" ]; then bash $FW_DIR/build.zsh $2 && exit 0;fi
if [ $1 == "del" ]; then bash $FW_DIR/remove.zsh && exit 0;fi

echo -e "${BRed}Command $BBlue$1${BRed} not found!$RESET_COLOR"
usage_msg
exit 1