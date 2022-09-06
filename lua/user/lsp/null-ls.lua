local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  return
end

local builtins = null_ls.builtins

local root_has_files = function(...)
  local files = ...
  return function(utils)
    return utils.root_has_file(files)
  end
end

-- https://github.com/prettier-solidity/prettier-plugin-solidity
-- npm install --save-dev prettier prettier-plugin-solidity
null_ls.setup {
  debug = false,
  sources = {
    builtins.formatting.prettierd.with {
      extra_filetypes = { "toml", "solidity" },
      condition = function(utils)
        return not utils.root_has_file { "deno.json", "deno.jsonc" }
      end,
    },
    builtins.formatting.eslint_d.with {
      condition = root_has_files { "package.json", ".eslintrc*" },
    },
    builtins.formatting.stylua,
    builtins.formatting.shfmt,

    -- diagnostics
    builtins.diagnostics.eslint_d.with {
      condition = root_has_files { "package.json", ".eslintrc*" },
    },
    builtins.diagnostics.markdownlint,

    -- code actions
    builtins.code_actions.eslint_d.with {
      condition = root_has_files { "package.json", ".eslintrc*" },
    },
    builtins.code_actions.refactoring,

    -- hover
    builtins.hover.dictionary,
  },
}
