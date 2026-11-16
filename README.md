# Blue

*It is unusual tonight. The moon is blue. The system is changing. It is time 
to start again.*

This is Blue, where I store all of my configuration files, i.e., things I might 
need when using a new system, once in a Blue Moon.

## Setup

This requires:
- GNU stow
- GNU make

Make is used to setup each set of dotfiles; for example, if you want to try 
out my bash configuration, clone this repository and run this in your 
terminal:
```
cd bash
make install
```
This will then run a script that uses Stow to make symlinks between the 
files here and where the actual configuration files should go.

You can also skip all of that by just running `make install` without `cd`'ing 
first, which just runs `make install` for all of the directories here.
