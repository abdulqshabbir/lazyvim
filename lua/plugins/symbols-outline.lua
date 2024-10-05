return {
  "simrat39/symbols-outline.nvim",
  opts = {
    keymaps = { -- These keymaps can be a string or a table for multiple keys
      close = { "<Esc>", "q" },
      goto_location = "<Cr>",
      focus_location = "o",
      toggle_preview = "K",
      rename_symbol = "r",
      code_actions = "a",
      fold = "zc",
      unfold = "zo",
      fold_all = "W",
      unfold_all = "E",
      fold_reset = "R",
    },
  },
  keys = {
    { "<leader>ss", "<cmd>SymbolsOutline<CR>", { desc = "Open symbols map" } },
  },
}
