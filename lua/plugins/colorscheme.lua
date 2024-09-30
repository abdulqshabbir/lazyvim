return {
  {
    "rebelot/kanagawa.nvim",
    name = "kanagawa",
    opts = {
      theme = "dragon",
    },
    config = function()
      local k = require("kanagawa")
      k.setup({
        colors = {
          theme = {
            dragon = {
              ui = {
                bg_visual = "#581c87",
              },
              diff = {
                add = "#065f46",
                delete = "#be123c",
                change = "#92400e",
              }
            },
            all = {
              ui = {
                bg_gutter = "none"
              }
            }
          }
        },
      })
    end
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "kanagawa",
    },
  },
}
