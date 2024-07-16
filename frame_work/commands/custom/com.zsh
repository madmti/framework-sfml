# Sources #
source $(dirname `dirname $0`)/dirs.txt
source $FW_DIR/bash/colors.txt

# Program #
if ! [ -d $SRC_DIR/.custom ]
    then
    echo -e "${Red}[INIT ERROR]$RESET_COLOR"
    echo -e "Custom commands were not initialized"
    echo -e "use the comand ${Blue}custom-init$RESET_COLOR"
    exit 1
fi

if [ -z $1 ]
    then
    echo -e "${Red}[INVALID ARGS]$RESET_COLOR"
    echo -e "usage mode:"
    cat $FW_DIR/bash/custom/use.txt
    exit 1
fi

if [ -d $SRC_DIR/.custom/$1 ]
    then
    echo -e "${Red}[ALREADY EXISTS]$RESET_COLOR"
    echo -e "A command with that name already exists"
    echo -e "You want to replace it? [y/n]"
    echo -e "omision = y"
    read -r res
    if [ $res == "y" ] || [ -z $res ]; then rm -rf $SRC_DIR/.custom/$1; else exit 1; fi
fi

mkdir $SRC_DIR/.custom/$1
echo -e "# sources #
source $FW_DIR/bash/colors.txt
SRC_DIR=$SRC_DIR

# Program #\n" &>> $SRC_DIR/.custom/$1/com.zsh
echo -e "${Blue}$1 ${Red}<args>$RESET_COLOR\t\t\t Usage mode for $1" &>> $SRC_DIR/.custom/$1/use.txt
echo -e "Instrucction for $1 command here" &>> $SRC_DIR/.custom/$1/help.txt
