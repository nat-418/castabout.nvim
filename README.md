# Castabout

A fancier way to search in Neovim.

## Requirements

Castabout depends on
[dressing.nvim](https://github.com/stevearc/dressing.nvim).

## Installing

Install the plugin using your favorite package manager. For example,
with Packer:

```lua
return require('packer').startup(function(use)
  use {
    'https://github.com/nat-418/castabout.nvim',
    requires = 'https://github.com/stevearc/dressing.nvim'
  }
end)
```

## Using

There is no configuration. Just use `:Castabout forwards`
or `:Castabout backwards` to search like `/` or `?`.

You can 'improve' or override existing behavior like this:

```lua
vim.api.nvim_set_keymap('n', '/', ':Castabout forwards<CR>',  {noremap = true})
vim.api.nvim_set_keymap('n', '?', ':Castabout backwards<CR>', {noremap = true})
```
