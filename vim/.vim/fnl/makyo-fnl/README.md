# Makyo-FNL

## Overview 

Makyo is a Vim configuration and keymapping framework. The brunt of Makyo is
written in [Fennel][Fennel] with a dash of Lua and [Teal][Teal]. Lua is used to
initialize all plugins, especially [aniseed][aniseed], which is what makes it
possible to run Fennel. Teal is used for registering the key maps.

## Configuration

The entire initialization process starts with the
[`init.lua`](../../lua/init.lua) file, which is responsible for importing
pre-init and post-init hooks. Most importantly, it kicks off [Packer][Packer]'s
plugin initialization process. This process is asynchronous. When Packer notices
the [aniseed][aniseed] dependency, it loads it and `aniseed` stars. We set a
flag to denote that `aniseed` is ready before continuing with the Makyo
[Fennel][Fennel] source.

The Fennel source sets various user experience settings and configures the
keymaps. The registration of the keymaps happens in the
[translator](../../lua/makyo/plugins/translator.tl). The translator's job is to
not only register them but also provide a description, if one is provided, for
the [which_key][which_key] plugin that supplies visual menus based on them.

## Plugins

As previously state, Makyo uses [Packer][Packer] to manage plugins. Packer gives us the
ability to lazy load plugins, as well as load them only when needed. The plugin
configuration [file](../../lua/makyo/plugins.lua) groups plugins by their function. 

[CoC][CoC] is one plugin that manages its own extensions. That is, users can install
extensions by issuing the appropriate commands; configuration by hand is rarely
needed. See its helpdoc for more details.

Plugins that require extensive configuration have their own config files.
`fzf.vim` is one such plugin that requires more than a couple [lines](./plugins/fzf.fnl) of code to
customize its behavior.

## Mappings

Makyo draws inspiration from [Spacemacs][Spacemacs] and uses the [`which_key`][which_key] plugin to mimic
its key binding display. The mappings are meant to be as mnemonic as possible
based on your esteemed author's preferences. 

Like FZF mentioned earlier, mappings are defined in the plugin module for
`which_key`. This makes it possible to reload the mappings without having to
restart the editor. The plugin module passes the list of mappings, and those to
ignore, preventing them from appearing on the OSD, to the translator. The
translator executes the registration function attached to each mapping and
creates a description of the command for `which_key` if one is given.

[Teal]: https://github.com/teal-language/tl
[Fennel]: https://fennel-lang.org
[Packer]: https://github.com/wbthomason/packer.nvim
[aniseed]: https://github.com/Olical/aniseed
[CoC]: https://github.com/neoclide/coc.nvim
[Spacemacs]: http://spacemacs.org/
[which_key]: https://github.com/liuchengxu/vim-which-key
