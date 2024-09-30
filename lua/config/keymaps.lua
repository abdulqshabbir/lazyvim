-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- leader key
vim.g.mapleader = " "

-- load color scheme
vim.cmd("colorscheme kanagawa-dragon")

local keymap = vim.keymap
local Util = require("lazyvim.util")

keymap.set("n", "<C-h>", "<Cmd>NvimTmuxNavigateLeft<CR>", { silent = true })
keymap.set("n", "<C-j>", "<Cmd>NvimTmuxNavigateDown<CR>", { silent = true })
keymap.set("n", "<C-k>", "<Cmd>NvimTmuxNavigateUp<CR>", { silent = true })
keymap.set("n", "<C-l>", "<Cmd>NvimTmuxNavigateRight<CR>", { silent = true })

-- Borderless lazygit
vim.keymap.set("n", "<leader>lg", function()
  Util.terminal({ "lazygit" }, { cwd = Util.root(), esc_esc = false, ctrl_hjkl = false, border = "none" })
end, { desc = "Lazygit (root dir)" })


-- Telescope colors
local hl_bg = "#8b5cf6"
local hl_fg = "#faf5ff"
vim.api.nvim_set_hl(0, 'TelescopeSelection', { bg = hl_bg, fg = hl_fg })
vim.api.nvim_set_hl(0, 'TelescopeMatching', { bg = hl_bg, fg = hl_fg })
vim.api.nvim_set_hl(0, 'TelescopePreviewLine', { bg = hl_bg, fg = hl_fg })

-- search and replavim
-- copy all contents of filevim
keymap.set("n", "<leader>.", ":GrugFar<cr>")

-- file explorer
-- keymap.set("n", "<leader>b", "<cmd>Ex<CR>")

-- centering on jumps
keymap.set("n", "<C-p>", "<cmd>cnext<CR>zz")
keymap.set("n", "<C-n>", "<cmd>cprev<CR>zz")
keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")
keymap.set("n", "J", "mzJ`z")
keymap.set("n", "<C-d>", "<C-d>zz")
keymap.set("n", "<C-u>", "<C-u>zz")
keymap.set("n", "n", "nzzzv")
keymap.set("n", "N", "Nzzzv")

-- move lines up and down
keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- clear search highlights
keymap.set("n", "<leader>es", ":nohlsearch<CR>", { desc = "Clear search highlights" })

-- window management
keymap.set("n", "<leader>qq", "<cmd>q<CR>", { desc = "Quit current window" })
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })     -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })   -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })      -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window
keymap.set("n", ";;", "<cmd>close<CR>", { desc = "Close pane" })

-- generzal saving/closing keymaps
keymap.set("n", ";j", "<cmd>w<CR>")
keymap.set("n", ";q", "<cmd>wqa<CR>")

-- vim maximizer
--keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>") -- toggle split window maximization

-- Git Keymaps
keymap.set("n", "<leader>gtb", "<cmd>Gitsigns blame_line<cr>")
keymap.set("n", "<leader>gsh", "<cmd>Gitsigns stage_hunk<cr>")
keymap.set("n", "<leader>gph", "<cmd>Gitsigns preview_hunk<cr>")
keymap.set("n", "<leader>gwd", "<cmd>Gitsigns toggle_word_diff<cr>")
keymap.set("n", "<leader>grh", "<cmd>Gitsigns reset_hunk<cr>")
keymap.set("n", "<leader>guh", "<cmd>Gitsigns undo_stage_hunk<cr>")
keymap.set("n", "<leader>gl", "<cmd>LazyGit<cr>")

-- Quickfix keymaps
keymap.set("n", "<C-n>", ":cnext<CR>zz") -- jump to next quickfix list item
keymap.set("n", "<C-p>", ":cprev<CR>zz") -- jump to prev quickfix list item

-- undo tree
-- keymap.set("n", "<leader>u", ":UndotreeToggle<CR>")

-- Telescope import
keymap.set("n", "<leader>fi", ":Telescope import<cr>")

-- Snippets
-- keymap.set({ "n", "v" }, "<leader>sa", ":ScissorsAddNewSnippet<cr>")
-- keymap.set("n", "<leader>sc", ":ScissorsEditSnippet<cr>")
-- keymap.set("n", "<leader>ss", ":ScissorsSave<cr>")

-- Oil
keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- Smart rename
keymap.set("n", "<leader>rn", ":IncRename ")

-- TS organize imports
--keymap.set("n", "<leader>oi", "<cmd>OrganizeImports<cr>")

-- barbeque
keymap.set("n", "<leader>l", "<cmd>Barbecue toggle<CR>") -- toggle split window maximization
