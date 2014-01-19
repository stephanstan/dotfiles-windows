# dotfiles-windows

Add some tweaks into current Windows user's home directory.
Inspired by <https://github.com/paulirish/dotfiles> for MacOS.

Get even more features with clink! See below.
## Features
### Syntax highlighting

* gvim highlights inline shell scripts in Vagrantfiles

### Tools

* **addtime**: show relative time stamp in stdout of another tool.
  Usage: anothertool | addtime
* **viewpath**: show PATH environemnt in gvim pretty printed
* **z**: change to one of your favorite project folder

### Aliases

* **n**: notepad 
* **e**: open explorer in current dir 
* **..**: one dir up
* **...**: two dirs up

### Vagrant

* default Vagrantfile for global settings. **Beware** save your previous Vagrantfile before calling sync -f

# Installation
    git clone https://github.com/StefanScherer/dotfiles-windows && cd dotfiles-windows && sync.bat

To update later on, just run the sync again.

To install clink with the chocolatey package, just type

    cinst devbox-clink

and then run the sync -f command again. Close current shell and open a new one. Then clink will do its magic.


# Licensing
Copyright (c) 2014 Stefan Scherer

MIT License, see LICENSE.txt for more details.
