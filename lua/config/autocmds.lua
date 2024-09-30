-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
-- -- Disable autoformat for lua files

local api = vim.api
local override = 'DiffAddAsDelete'

function fix_highlight()
  local nr = api.nvim_win_get_buf(0)
  local name = api.nvim_buf_get_name(nr)
  local winhl = vim.wo.winhl

  if not vim.wo.diff or winhl:match(override) then
    return
  end

  if winhl == '' then
    vim.wo.winhl = 'DiffAdd:' .. override
  else
    vim.wo.winhl = winhl .. ',DiffAdd:' .. override
  end
end

vim.cmd('autocmd ColorScheme * hi DiffAddAsDelete guibg=#f2e3cd')
vim.cmd('autocmd BufNew fugitive://* lua fix_highlight()')
