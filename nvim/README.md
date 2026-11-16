# Neovimm

It's an editor. I think it's pretty good.


## Features

- Hand-written HTML tag completion (see `./lua/settings/custom.lua -> tag_mode` 
  for the code)
- Key bindings to run unit tests or build a project
- Good error checking for plugin loading (always good if you want to drop 
  your config onto a new machine)

---

## Notes

### Installing Language Servers

For future reference, here is how I installed the language servers that I have 
used:
* pyrefly has been built from source code
* [typescript-language-server](https://github.com/typescript-language-server/typescript-language-server) 
  was installed globally via pnpm
* [gopls](https://github.com/golang/tools) was installed using my system 
  package manager
* [clangd](https://clangd.llvm.org/installation) was installed by my system 
  package manager; the package is `clang-tools-extra` on Fedora, `clangd` on 
  Debian


### Installing new plugins

This should be as simple as putting the git repo for a plugin in the right 
folder (see `lua/plugins`) and restarting vim.

You will need to run `:helptags {plugin name}|ALL` to get the docs up though.


### Debugging

* `:redir` is useful for putting vim command output into a file
* `:Inspect` will show what syntax group the thing under the cursor is in
* `:scriptnames` & `:verbose set` can give you an idea of where a bad setting is 
  coming from
