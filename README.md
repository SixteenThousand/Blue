# Blue

*It is unusual tonight. The moon is blue. The system is changing. It is time 
to start again.*

This is Blue, where I store all of my dotfiles<sup>1</sup>, i.e., things I 
might need when using a new system, once in a Blue Moon.


## Interesting Features

- Hand written shell prompts for bash, fish, zsh...and python 
- A Command-line colour scheme switcher for WezTerm
- A complete failure to set a colour scheme in tmux (seriously, if you know 
  how to do that, please contact me)
- A hand-rolled neovim configuration
- A shell history search tool for bash (search for `stale`)

More interesting features can be found by reading the `README.md` files in 
each of the subdirectories of this repository.


## Dependencies & Using This Repository

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

If you are me in the future, you may be able to skip all of that by just 
running `make install` from without `cd`'ing first, which just runs `make 
install` for all of the apps that I currently use.


---

## Footnotes

1. https://www.freecodecamp.org/news/dotfiles-what-is-a-dot-file-and-how-to-create-it-in-mac-and-linux/
