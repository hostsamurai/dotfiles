## Neovim Configuration

### Initialization

The `.vimrc` is terse for a reason - Vim provides us a means of splitting things
out through its `autoload` functionality. This makes it possible to split out
any complex configuration into parts. All of my configuration lives in
`autoload/makyo`. Everything is set up in the order that it appears in my
`.vimrc`. Custom mappings are configured when the `VimEnter` event fires, in
order to guarantee that nothing else overrides them.

#### Plugins

Plugins are managed via [dein](https://github.com/Shougo/dein.vim/) through a
TOML [plugin configuration file](https://github.com/hostsamurai/dotfiles/blob/master/vim/.vim/rc/dein.toml).
Because this setup uses [coc.nvim](https://github.com/neoclide/coc.nvim), its
extensions are managed via `:CocUpdate`.

#### Remote plugin

Custom mode key mappings are configured through a JSON5
[file](https://github.com/hostsamurai/dotfiles/blob/new-vim/vim/.vim/autoload/makyo/keymap.json5).
A node.js [remote plugin](https://github.com/hostsamurai/dotfiles/tree/new-vim/vim/.vim/rplugin/node/keymap)
is in charge of reading that configuration and executing the appropriate Vim
commands.

For this to work, Neovim has to know of the existence of the
remote plugin. This is possible via `:UpdateRemotePlugins`. The
[node-client](https://github.com/neovim/node-client) has a mechanism through
which debugging is possible. You want to specify the path to a log file where
all of the output from the node.js plugin can be redirected to, along with
address of the RPC server for the running Neovim instance:

```sh
mkfifo /tmp/nvim-pipe
NVIM_NODE_LOG_FILE=./rplugin.log nyaovim --listen /tmp/nvim-pipe
```

In the plugin, setting `alwaysInit: true` will allow you to test your changes
easily after executing `:UpdateRemotePlugins`.

#### Custom mappings

Most mappings are heavily inspired by [Spacemac's](http://spacemacs.org/)
keybindings. A minority are also taken out of my Atom configuration.
