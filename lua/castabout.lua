local M = {}

M.search = function(tbl)
  local direction = '/'
  local prompt    = 'Search forwards in buffer: '

  if tbl.args == 'backwards' then
    direction = '?'
    prompt    = 'Search backwards in buffer: '
  end

  vim.ui.input({
    prompt  = prompt,
    default = ''
  }, function(input)
    if input then
      return vim.cmd(direction .. input)
    end
    return 0
  end)
end

M.setup = function()
  vim.api.nvim_create_user_command(
  'Castabout',
  function(opts) M.search(opts.args) end,
  {
    nargs = 1,
    complete = function(_,_)
      return {"forwards", "backwards"}
    end
  })
end

return M
