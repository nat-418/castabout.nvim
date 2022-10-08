-- A common convention for Neovim plugins written in Lua is to build and ship
-- a single `M` table via a `return M` at the end of the file.
local M = {}

M.search = function(direction)
  local command = '/' -- Assume a forwards search
  local message = 'Search forwards in buffer: '

  -- Modify the search if explicitly asked
  if direction ~= nil and direction == 'backwards' then
    command = '?'
    message = 'Search backwards in buffer: '
  end

  local callback = function(input) -- What to do after we get search terms
    if input then return vim.cmd(command .. input) end
    print('No input given')
    return 0
  end

  return vim.ui.input({prompt = message, default = ''}, callback)
end

-- A common convention for Neovim plugins written in Lua is to wrap the
-- loading of commands and any user configuration into a `setup` function.
-- This way, the end-user has more control over when and where they are loaded.
M.setup = function()
  -- Custom command completion requires a callback that takes three arguments.
  -- In this case, we don't care what they are and just want to return a list
  -- of subcommands.
  local completion = function(_, _, _) return {'forwards', 'backwards'} end

  return vim.api.nvim_create_user_command(
    'Castabout',                         -- Name of the command
    function(args) M.search(args) end,   -- Function defining what it does
    {nargs = '?', complete = completion} -- Additional options
    -- nargs can take '*' for any number of arguments, '?' for one or none,
    -- and an integer value for exact numbers of arguments.
  )
end

return M
