return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  opts = {
    menu = {
      width = vim.api.nvim_win_get_width(0) - 4,
    },
    settings = {
      save_on_toggle = true,
    },
  },
  keys = function()
    local keys = {
      {
        "<leader>hm",
        function()
          require("harpoon"):list():add()
        end,
        desc = "Harpoon File",
      },
      {
        "<leader>hui",
        function()
          local harpoon = require("harpoon")
          harpoon.ui:toggle_quick_menu(harpoon:list())
        end,
        desc = "Harpoon Quick Menu",
      },
      {
        ";a",
        function()
          require("harpoon"):list():select(1)
        end,
        desc = "Get first file",
      },
      {
        ";s",
        function()
          require("harpoon"):list():select(2)
        end,
        desc = "Get first file",
      },
      {
        ";d",
        function()
          require("harpoon"):list():select(3)
        end,
        desc = "Get first file",
      },
      {
        ";f",
        function()
          require("harpoon"):list():select(4)
        end,
        desc = "Get first file",
      },
      {
        ";g",
        function()
          require("harpoon"):list():select(5)
        end,
        desc = "Get first file",
      },
    }
    return keys
  end,
}
