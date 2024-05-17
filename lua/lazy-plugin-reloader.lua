local function table_format(t)
  local keys = {}
  for key, _ in pairs(t) do
    value = string.match(vim.inspect(t[key][1]), '.-/([^/]+)$', 1):gsub('"', '')
    table.insert(keys, key, value)
  end
  return keys
end

local Popup = require 'nui.popup'
local buf = vim.api.nvim_create_buf(false, true)
local plugins_with_table = require('lazy').plugins()
local plugins = table_format(plugins_with_table)
vim.api.nvim_buf_set_lines(buf, 0, 100, false, plugins)
local popup = Popup {
  position = '50%',
  size = {
    width = 80,
    height = 40,
  },
  enter = true,
  focusable = true,
  zindex = 50,
  relative = 'editor',
  border = {
    padding = {
      top = 2,
      bottom = 2,
      left = 3,
      right = 3,
    },
    style = 'rounded',
    text = {
      top = ' I am top title ',
      top_align = 'center',
      bottom = 'I am bottom title',
      bottom_align = 'left',
    },
  },
  buf_options = {
    modifiable = false,
    readonly = false,
  },
  win_options = {
    winblend = 10,
    winhighlight = 'Normal:Normal,FloatBorder:FloatBorder',
  },
  bufnr = buf,
}
local ok = popup:map('n', 'l', function(bufnr)
  local r, c = vim.inspect(vim.api.nvim_win_get_cursor(0))
  print(r, c)

  vim.cmd('Lazy reload ' .. vim.api.nvim_get_current_line())
end, { noremap = true })
popup:mount()
