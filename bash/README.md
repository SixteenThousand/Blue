# My Bash Config

These are my configuration files for the Bourne Again Shell, aka Bash, 
possibly one of the most annoying pieces of software to configure.


## Shell "fun"

### Startup files & tmux

Tmux (the Terminal MUltipleXer) has to load a new shell every time you open 
a new tab or pane. Unfortunately, unlike in an actual terminal, it starts 
bash as a "login shell". This means that bash uses `~/.profile` for startup 
instead of the usual `~/.bashrc`. If you search for this online, you will 
likely find suggestions that you change your `~/.profile` to deal with 
behaviour likely adding something along the lines of
```sh
case "$-" in
    *i*) [ -s "$HOME/bashrc" ] && source "$HOME/bashrc";;
esac
```
that loads your `.bashrc` if the shell is interactive.

However, instead of changing bash to fix tmux's odd behaviour, I think it's 
better to set the `default-command` option in tmux to `bash -i`, which just 
explicitly tells bash to use the `.bashrc`.


### Inputrc & key names

Bash may have been Bourne Again, but it remembers its previous life. This 
means it has some interesting quirks, like the fact that the software used 
to read input from the user is actually a completely different piece of 
software from bash itself. This has its own quirky config file, 
`~/.inputrc`, which has its own quirks within the greater quirk, namely 
that:
    - Escape == Alt, so Alt is represented by `\e`
    - Return == Carriage Return *only*, so Return cannot be represented by 
      `\n`, and is only represented by `\r`


### Shell integration with other applications

Some applications give you stuff to add to your `.bashrc`. Inevitably they 
want to make sure that this stuff can use the correct values of `$PATH`, 
etc., and so they tell you to put *their* thing at the end of your 
`.bashrc`, blissfully unaware of the other developers who had the same idea. 
I currently have 2 or 3 different pieces of shell script that all have to be 
at the end of my `.bashrc`. This has been difficult to achieve.
