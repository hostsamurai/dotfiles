## Neovim Configuration

### Initialization

The sole purpose of the `.vimrc` is to import the `lua` initialization script.
This script is responsible for initializing plugins and passing off the rest of
the initialization to `makyo`, my Vim configuration framework. `makyo` is
written in [Fennel][Fennel], a LISP dialect written in `lua`.
Aside from improving Vim's user experience, `makyo` is in charge of setting up
keymaps in a similar fashion to Spacemacs. For more information, consult its
[README](./fnl/makyo-fnl/README.md).

#### Plugins

This configuration makes use of two flavors of plugins: regular Vim/Neovim
plugins and extensions for [CoC][CoC]. Regular plugins are handled through [Packer][Packer]. One
important thing that happens during plugin configuration and initialization is
that the required dependency for `makyo`'s [Fennel][Fennel] source, [aniseed][aniseed], is set up.
This happens asynchronously. Packer is also asynchronous. Because of this, we
have to poll to ensure that `aniseed` has been initialized. Run `:PackerUpdate`
to update plugins. `:PackerCompile` is needed after making changes to the
plugin configuration file.

[CoC][CoC] extensions are handled through CoC itself. It takes care of setting up
everything as soon as [Packer][Packer] initializes it. No fancy setup is needed here. To
update extensions, run `:CocUpdate`.

#### Custom mappings

Most mappings are heavily inspired by [Spacemac's](http://spacemacs.org/)
keybindings. 

[Packer]: https://github.com/wbthomason/packer.nvim
[Fennel]: https://fennel-lang.org
[aniseed]: https://github.com/Olical/aniseed
[CoC]: https://github.com/neoclide/coc.nvim
[Spacemacs]: http://spacemacs.org/
