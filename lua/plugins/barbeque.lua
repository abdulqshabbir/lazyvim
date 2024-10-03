return {
  "utilyre/barbecue.nvim",
  name = "barbecue",
  version = "*",
  dependencies = {
    "SmiteshP/nvim-navic",
    "nvim-tree/nvim-web-devicons", -- optional dependency
  },
  config = function()
    require("barbecue").setup({
      theme = {
        -- this highlight is used to override other highlights
        -- you can take advantage of its `bg` and set a background throughout your winbar
        -- (e.g. basename will look like this: { fg = "#c0caf5", bold = true })
        normal = { fg = "#c0caf5" },

        -- these highlights correspond to symbols table from config
        ellipsis = { fg = "#737aa2" },
        separator = { fg = "#737aa2" },
        modified = { fg = "#737aa2" },

        -- these highlights represent the _text_ of three main parts of barbecue
        dirname = { fg = "#737aa2" },
        basename = { bold = true },
        context = {},

        -- these highlights are used for context/navic icons
        context_file = { fg = "#ac8fe4" },
        context_module = { fg = "#ac8fe4" },
        context_namespace = { fg = "#ac8fe4" },
        context_package = { fg = "#ac8fe4" },
        context_class = { fg = "#ac8fe4" },
        context_method = { fg = "#ac8fe4" },
        context_property = { fg = "#ac8fe4" },
        context_field = { fg = "#ac8fe4" },
        context_constructor = { fg = "#ac8fe4" },
        context_enum = { fg = "#ac8fe4" },
        context_interface = { fg = "#ac8fe4" },
        context_function = { fg = "#ac8fe4" },
        context_variable = { fg = "#ac8fe4" },
        context_constant = { fg = "#ac8fe4" },
        context_string = { fg = "#ac8fe4" },
        context_number = { fg = "#ac8fe4" },
        context_boolean = { fg = "#ac8fe4" },
        context_array = { fg = "#ac8fe4" },
        context_object = { fg = "#ac8fe4" },
        context_key = { fg = "#ac8fe4" },
        context_null = { fg = "#ac8fe4" },
        context_enum_member = { fg = "#ac8fe4" },
        context_struct = { fg = "#ac8fe4" },
        context_event = { fg = "#ac8fe4" },
        context_operator = { fg = "#ac8fe4" },
        context_type_parameter = { fg = "#ac8fe4" },
      },
    })
    require("barbecue.ui").toggle(false)
    vim.keymap.set("n", "<leader>bt", ":lua require('barbecue.ui').toggle()<cr>", { desc = "Toggle bbq" })
    vim.keymap.set("n", ";1", ":lua require('barbecue.ui').navigate(-1)<cr>", { desc = "Go to #1 bbq" })
    vim.keymap.set("n", ";2", ":lua require('barbecue.ui').navigate(-2)<cr>", { desc = "Go to #2 bbq" })
    vim.keymap.set("n", ";3", ":lua require('barbecue.ui').navigate(-3)<cr>", { desc = "Go to #3 bbq" })
    vim.keymap.set("n", ";4", ":lua require('barbecue.ui').navigate(-4)<cr>", { desc = "Go to #4 bbq" })
  end,
}
