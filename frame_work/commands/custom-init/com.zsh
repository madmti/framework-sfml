# Sources #
source $(dirname `dirname $0`)/dirs.txt
source $FW_DIR/bash/colors.txt

if [ -d $SRC_DIR/.custom ]
then
exit 0
fi

mkdir $SRC_DIR/.custom
echo -e "To create a custom command just create a folder with the name, then add the \"com.zsh\" (the command it self) file inside,
also create use.txt and help.txt files.
src/.custom/
|
+- <comand_name>/
|   |
|   +- com.zsh          Command file
|   +- use.txt          Usage of the command (in one line)
|   +- help.txt         Instrucctions for the help command

or you can use the preset to create it automaticly with:
\tcustom <command_name>" &>> $SRC_DIR/.custom/README.txt