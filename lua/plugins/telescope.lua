return {
  "nvim-telescope/telescope.nvim",
  cmd = "Telescope",
  enabled = function()
    return LazyVim.pick.want() == "telescope"
  end,
  version = false, -- telescope did only one release, so use HEAD for now
  dependencies = {
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = have_make and "make"
          or
          "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
      enabled = have_make or have_cmake,
      config = function(plugin)
        LazyVim.on_load("telescope.nvim", function()
          local ok, err = pcall(require("telescope").load_extension, "fzf")
          if not ok then
            local lib = plugin.dir .. "/build/libfzf." .. (LazyVim.is_win() and "dll" or "so")
            if not vim.uv.fs_stat(lib) then
              LazyVim.warn("`telescope-fzf-native.nvim` not built. Rebuilding...")
              require("lazy").build({ plugins = { plugin }, show = false }):wait(function()
                LazyVim.info("Rebuilding `telescope-fzf-native.nvim` done.\nPlease restart Neovim.")
              end)
            else
              LazyVim.error("Failed to load `telescope-fzf-native.nvim`:\n" .. err)
            end
          end
        end)
      end,
    },
  },
  keys = {
    -- telescope
    { "<leader>p",  "<cmd>Telescope find_files<cr>",               { desc = "Fuzzy find files in cwd" } },
    { "<leader>fo", "<cmd>Telescope oldfiles<cr>",                 { desc = "Fuzzy find recent files" } },
    { "<leader>ff", "<cmd>Telescope live_grep<cr>",                { desc = "Find string in cwd" } },
    { "<leader>fc", "<cmd>Telescope grep_string<cr>",              { desc = "Find string under cursor in cwd" } },
    { "<leader>fb", "<cmd>Telescope buffers<cr>" },                   -- list open buffers in current neovim instance
    { "<leader>ft", "<cmd>Telescope help_tags<cr>" },                 -- list available help tags
    { "<leader>fr", "<cmd>Telescope lsp_references<cr>" },            -- find all references of variable
    { "<leader>fh", "<cmd>Telescope find_files hidden=true<cr>" },
    { "<leader>fd", "<cmd>Telescope diagnostics bufnr=0<cr>" },       -- show diagnostics for current buffer
    { "<leader>fD", "<cmd>Telescope diagnostics<cr>" },               -- show diagnostics for all buffers
    { "<leader>fs", "<cmd>Telescope current_buffer_fuzzy_find<cr>" }, -- fuzzy find in current buffer

    -- git telescope
    { "<leader>gb", "<cmd>Telescope git_branches<CR>" }, -- search for git branches
    { "<leader>gc", "<cmd>Telescope git_commits<CR>" },  -- search for git commits
    { "<leader>gs", "<cmd>Telescope git_stash<CR>" },    -- search for git stashes
    { "<leader>:",  "<cmd>Telescope command_history<cr>",          desc = "Command History" },

    -- search
    { "<leader>sr", "<cmd>Telescope registers<cr>",                desc = "Registers" },
    { "<leader>sk", "<cmd>Telescope keymaps<cr>",                  desc = "Key Maps" },
    { "<leader>sm", "<cmd>Telescope marks<cr>",                    desc = "Jump to Mark" },
    { "<leader>sq", "<cmd>Telescope quickfix<cr>",                 desc = "Quickfix List" },
    {
      "<leader>ss",
      function()
        require("telescope.builtin").lsp_document_symbols({
          symbols = LazyVim.config.get_kind_filter(),
        })
      end,
      desc = "Goto Symbol",
    },
    {
      "<leader>sS",
      function()
        require("telescope.builtin").lsp_dynamic_workspace_symbols({
          symbols = LazyVim.config.get_kind_filter(),
        })
      end,
      desc = "Goto Symbol (Workspace)",
    },
    { "<leader>uC", LazyVim.pick("colorscheme", { enable_preview = true }), desc = "Colorscheme with Preview" },

  },
  opts = function()
    local actions = require("telescope.actions")

    local open_with_trouble = function(...)
      return require("trouble.sources.telescope").open(...)
    end
    local find_files_no_ignore = function()
      local action_state = require("telescope.actions.state")
      local line = action_state.get_current_line()
      LazyVim.pick("find_files", { no_ignore = true, default_text = line })()
    end
    local find_files_with_hidden = function()
      local action_state = require("telescope.actions.state")
      local line = action_state.get_current_line()
      LazyVim.pick("find_files", { hidden = true, default_text = line })()
    end

    local function find_command()
      if 1 == vim.fn.executable("rg") then
        return { "rg", "--files", "--color", "never", "-g", "!.git" }
      elseif 1 == vim.fn.executable("fd") then
        return { "fd", "--type", "f", "--color", "never", "-E", ".git" }
      elseif 1 == vim.fn.executable("fdfind") then
        return { "fdfind", "--type", "f", "--color", "never", "-E", ".git" }
      elseif 1 == vim.fn.executable("find") and vim.fn.has("win32") == 0 then
        return { "find", ".", "-type", "f" }
      elseif 1 == vim.fn.executable("where") then
        return { "where", "/r", ".", "*" }
      end
    end

    local hl_bg = "#8b5cf6"
    local hl_fg = "#faf5ff"

    vim.api.nvim_set_hl(0, 'TelescopeSelection', { bg = hl_bg, fg = hl_fg })
    -- telescope file matching styling
    vim.api.nvim_set_hl(0, 'TelescopeMatching', { bg = hl_bg, fg = hl_fg })

    -- telescope preview matching styling
    vim.api.nvim_set_hl(0, 'TelescopePreviewLine', { bg = hl_bg, fg = hl_fg })

    return {
      defaults = {
        layout_strategy = "vertical",
        layout_config = {
          vertical = {
            width = 0.9,
            height = 0.9,
            preview_height = 0.5,
          },
        },
        ignore_patterns = { "node_modules", ".git", "yarn.lock", "package-lock.json" },
        path_display = { "truncate " },
        prompt_prefix = " ",
        selection_caret = " ",
        -- open files in the first window that is an actual file.
        -- use the current window if no other window is available.
        get_selection_window = function()
          local wins = vim.api.nvim_list_wins()
          table.insert(wins, 1, vim.api.nvim_get_current_win())
          for _, win in ipairs(wins) do
            local buf = vim.api.nvim_win_get_buf(win)
            if vim.bo[buf].buftype == "" then
              return win
            end
          end
          return 0
        end,
        mappings = {
          i = {
            ["<c-t>"] = open_with_trouble,
            ["<a-t>"] = open_with_trouble,
            ["<a-i>"] = find_files_no_ignore,
            ["<a-h>"] = find_files_with_hidden,
            ["<C-u>"] = actions.preview_scrolling_down,
            ["<C-d>"] = actions.preview_scrolling_up,

            ["<C-k>"] = actions.move_selection_previous, -- move to prev result
            ["<C-j>"] = actions.move_selection_next,     -- move to next result
            ["<C-qf>"] = actions.send_selected_to_qflist + actions.open_qflist,
            ["<CR>"] = actions.select_default + actions.center,
          },
          n = {
            ["q"] = actions.close,
            ["<CR>"] = actions.select_default + actions.center,
          },
        },
      },
      pickers = {
        find_files = {
          find_command = find_command,
          hidden = true,
        },
      },
      extensions = {
        import = {
          -- Imports can be added at a specified line whilst keeping the cursor in place
          insert_at_top = true,
        },
      },
    }
  end,
}
