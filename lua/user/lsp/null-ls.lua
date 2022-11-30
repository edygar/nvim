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

null_ls.setup {
  debug = false,
  sources = {
    builtins.formatting.prettier_d_slim.with {
      extra_filetypes = { "toml", "solidity" },
    },
    builtins.formatting.eslint_d.with {
      condition = root_has_files { ".eslintrc*" },
    },
    builtins.formatting.stylua,
    builtins.formatting.shfmt,

    -- diagnostics
    builtins.diagnostics.eslint_d.with {
      condition = root_has_files {".eslintrc*" },
    },
    builtins.diagnostics.markdownlint,

    -- code actions
    builtins.code_actions.eslint_d.with {
      condition = root_has_files { ".eslintrc*" },
    },

    -- hover
    builtins.hover.dictionary,
  },
}
