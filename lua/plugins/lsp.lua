-- Disable "No information available" notification on hover
-- plus define border for hover window
vim.lsp.handlers["textDocument/hover"] = function(_, result, ctx, config)
  config = config
    or {
      border = {
        { "╭", "Comment" },
        { "─", "Comment" },
        { "╮", "Comment" },
        { "│", "Comment" },
        { "╯", "Comment" },
        { "─", "Comment" },
        { "╰", "Comment" },
        { "│", "Comment" },
      },
    }
  config.focus_id = ctx.method
  if not (result and result.contents) then
    return
  end
  local markdown_lines = vim.lsp.util.convert_input_to_markdown_lines(result.contents)
  markdown_lines = vim.lsp.util.trim_empty_lines(markdown_lines)
  if vim.tbl_isempty(markdown_lines) then
    return
  end
  return vim.lsp.util.open_floating_preview(markdown_lines, "markdown", config)
end

return {
  {
    "neovim/nvim-lspconfig",
    keys = {
      {
        "<leader>oi",
        LazyVim.lsp.action["source.organizeImports"],
        desc = "Organize Imports",
      },
      {
        "<leader>ai",
        LazyVim.lsp.action["source.addMissingImports.ts"],
        desc = "Add missing imports",
      },
      {
        "<leader>ri",
        LazyVim.lsp.action["source.removeUnused.ts"],
        desc = "Remove unused imports",
      },
      {
        "<leader>fa",
        LazyVim.lsp.action["source.fixAll.ts"],
        desc = "Fix all diagnostics",
      },
      {
        "<leader>rn",
        vim.lsp.buf.rename,
        { noremap = true, silent = true },
      },
    },
    opts = {
      servers = {
        vtsls = {
          settings = {
            typescript = {
              inlayHints = {
                enumMemberValues = { enabled = false },
                functionLikeReturnTypes = { enabled = false },
                parameterNames = { enabled = false },
                parameterTypes = { enabled = false },
                propertyDeclarationTypes = { enabled = false },
                variableTypes = { enabled = false },
              },
            },
          },
        },
      },
    },
  },
}
