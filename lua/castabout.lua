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

  return vim.ui.input({prompt = message, default = '' }, callback)
end

M.setup = function()
  local completion = function(_, _, _) return {'forwards', 'backwards'} end

  return vim.api.nvim_create_user_command(
    'Castabout',
    function(args) M.search(args) end,
    {nargs = '?', complete = completion}
  )
end

return M
