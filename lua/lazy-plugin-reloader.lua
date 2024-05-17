local function get_keys(t)
  local keys = {}
  for key, _ in pairs(t) do
    table.insert(keys, key, vim.inspect(t[key][1]))
  end
  return keys
end

local Popup = require 'nui.popup'
local buf = vim.api.nvim_create_buf(false, true)
local plugins_with_table = require('lazy').plugins()
plugins = get_keys(plugins_with_table)
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
popup:mount()
