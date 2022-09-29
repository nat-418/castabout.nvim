return vim.api.nvim_create_user_command('Castabout', function(tbl)
  local direction = '/'
  local prompt = 'Search forwards in buffer'
  if tbl.args == 'backwards' then
    direction = '?'
    prompt = 'Search backwards in buffer'
  end
  vim.ui.input({
    prompt = prompt,
    default = ''
  }, function(input)
    if input then
      vim.api.nvim_feedkeys(
        ':' .. direction .. input .. vim.api.nvim_eval('"\\<CR>"'),
        'm',
        true
      )
    end
  end)
end, {
  nargs = 1,
  complete = function(_,_)
    return {"forwards", "backwards"}
  end
})

