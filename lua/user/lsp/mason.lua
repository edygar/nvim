local status_ok, mason = pcall(require, "mason")
if not status_ok then
  return
end

local status_ok_1, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status_ok_1 then
  return
end

mason.setup {
  ui = {
    border = "rounded",
    icons = {
      package_installed = "◍",
      package_pending = "◍",
      package_uninstalled = "◍",
    },
  },
  log_level = vim.log.levels.INFO,
  max_concurrent_installers = 4,
}
mason_lspconfig.setup {
  ensure_installed = {
    "cssls",
    "cssmodules_ls",
    "emmet_ls",
    "html",
    "jdtls",
    "jsonls",
    "solc",
    "solidity_ls",
    "sumneko_lua",
    "tflint",
    "terraformls",
    "tsserver",
    "pyright",
    "yamlls",
    "bashls",
    "clangd",
    "taplo",
    "zk@v0.10.1",
    "lemminx",
  },
  automatic_installation = true,
}

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
  return
end

mason_lspconfig.setup_handlers {
  -- The first entry (without a key) will be the default handler
  -- and will be called for each installed server that doesn't have
  -- a dedicated handler.
  function(server_name) -- default handler (optional)
    local opts = {
      on_attach = require("user.lsp.handlers").on_attach,
      capabilities = require("user.lsp.handlers").capabilities,
    }

    server_name = vim.split(server_name, "@")[1]

    if server_name == "jsonls" then
      local jsonls_opts = require "user.lsp.settings.jsonls"
      vim.tbl_deep_extend("force", jsonls_opts, opts)
      opts = jsonls_opts
    end

    if server_name == "yamlls" then
      local yamlls_opts = require "user.lsp.settings.yamlls"
      vim.tbl_deep_extend("force", yamlls_opts, opts)
      opts = yamlls_opts
    end

    if server_name == "sumneko_lua" then
      local l_status_ok, lua_dev = pcall(require, "lua-dev")
      if not l_status_ok then
        return
      end
      -- local sumneko_opts = require "user.lsp.settings.sumneko_lua"
      -- opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
      -- opts = vim.tbl_deep_extend("force", require("lua-dev").setup(), opts)
      local luadev = lua_dev.setup {
        --   -- add any options here, or leave empty to use the default settings
        -- lspconfig = opts,
        lspconfig = {
          on_attach = opts.on_attach,
          capabilities = opts.capabilities,
          --   -- settings = opts.settings,
        },
      }
      lspconfig.sumneko_lua.setup(luadev)
      return
    end

    if server_name == "pyright" then
      local pyright_opts = require "user.lsp.settings.pyright"
      vim.tbl_deep_extend("force", pyright_opts, opts)
      opts = pyright_opts
    end

    if server_name == "solc" then
      local solc_opts = require "user.lsp.settings.solc"
      vim.tbl_deep_extend("force", solc_opts, opts)
      opts = solc_opts
    end

    if server_name == "emmet_ls" then
      local emmet_ls_opts = require "user.lsp.settings.emmet_ls"
      vim.tbl_deep_extend("force", emmet_ls_opts, opts)
      opts = emmet_ls_opts
    end

    if server_name == "zk" then
      local zk_opts = require "user.lsp.settings.zk"
      vim.tbl_deep_extend("force", zk_opts, opts)
      opts = zk_opts
    end

    lspconfig[server_name].setup(opts)
  end,
}
