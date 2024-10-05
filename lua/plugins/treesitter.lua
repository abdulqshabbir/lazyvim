return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "css",
        "diff",
        "gitignore",
        "html",
        "http",
        "javascript",
        "json",
        "json5",
        "jsonc",
        "lua",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "yaml",
      },
      config = function(_, opts)
        require("nvim-treesitter.configs").setup(opts)
      end,
    },
  },
  {
    "nvim-treesitter/playground",
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    enabled = false,
  },
}
