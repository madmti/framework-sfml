# SFML FRAMEWORK FOR 2D GENERAL APPS

Not released yet

## Installation

1. clone repo

```sh
git clone https://github.com/madmti/framework-sfml.git
```

2. add the alias

```sh
alias sfmlfw="bash <fullpath to sfmlfw.zsh>"
```

## Usage

- `sfmlfw new` to create a new project with the preconfigured settings
- `sfmlfw del` to remove the files from the project

## After creating
after creating a project you will have a command program in binary that also has little commands to make easy the creations of views and other things.

## After creating commands

- `./comands` will display the usage mode and the available commands
- `./comands help <command>` will display the instrucctions of the given command
- `./comands create-view <name>` will create a folder in src/views with the necesary class to make a view
- `./comands reload-views` will include all the views inside src/views into include_views.hpp
- `./comands yaml-build` will create a hpp file with a struct of the configuration type defined in the yaml files inside src/config
