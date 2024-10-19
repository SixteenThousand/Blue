# Blue

*It is unusual tonight. The moon is blue. The system is changing. It is time 
to start again.*

This is Blue, where I store all of my dotfiles and anything else I might 
need when using a new system, i.e., once in a Blue Moon.

---

## Interesting Features

- Hand written shell prompts for bash, fish, zsh...and python 
- Command-line colour scheme switchers for Alacritty and WezTerm
- A complete failure to set a colour scheme in tmux (seriously, if you know 
  how to do that, please contact me)

## Dependencies

- GNU stow
- GNU make

## Getting Started

If you're reading this and you're not me from the future, then...I'm not 
sure why you're reading this? But anyway, to use this repository on a new 
system, clone the repo and in a terminal, in the project top level, run
```bash
git submodule init
git submodule update
make install
```
This will run `make install` in every subdirectory of `./configs`.
