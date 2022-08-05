local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  return
end

local builtins = null_ls.builtins

-- https://github.com/prettier-solidity/prettier-plugin-solidity
-- npm install --save-dev prettier prettier-plugin-solidity
null_ls.setup {
  debug = false,
  sources = {
    builtins.formatting.prettierd.with {
      extra_filetypes = { "toml", "solidity" },
    },
    builtins.formatting.eslint_d,
    builtins.formatting.stylua,
    builtins.formatting.shfmt,

    -- diagnostics
    builtins.diagnostics.eslint_d,
    builtins.diagnostics.markdownlint,
    builtins.diagnostics.shellcheck,

    -- code actions
    builtins.code_actions.gitsigns,
    builtins.code_actions.eslint_d,
    builtins.code_actions.refactoring,

    -- hover
    builtins.hover.dictionary,
  },
}
