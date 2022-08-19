local status_ok, mason = pcall(require, "mason")
if not status_ok then
  return
end

local status_ok_1, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status_ok_1 then
  return
end

local servers = {
  "awk_ls",
  "angularls",
  "ansiblels",
  "apex_ls",
  "arduino_language_server",
  "asm_lsp",
  "astro",
  "bashls",
  "beancount",
  "bicep",
  "clangd",
  "csharp_ls",
  "omnisharp",
  "omnisharp_mono",
  "clangd",
  "cmake",
  "cssls",
  "cssmodules_ls",
  "clarity_lsp",
  "clojure_lsp",
  "codeqlls",
  "crystalline",
  "cucumber_language_server",
  "dagger",
  "denols",
  "dhall_lsp_server",
  "diagnosticls",
  "serve_d",
  "dockerls",
  "dotls",
  "efm",
  "eslint",
  "elixirls",
  "elmls",
  "ember",
  "emmet_ls",
  "erlangls",
  "fsautocomplete",
  "flux_lsp",
  "foam_ls",
  "fortls",
  "golangci_lint_ls",
  "gopls",
  "grammarly",
  "graphql",
  "groovyls",
  "html",
  "hls",
  "haxe_language_server",
  "hoon_ls",
  "jsonls",
  "jdtls",
  "quick_lint_js",
  "tsserver",
  "jsonnet_ls",
  "julials",
  "kotlin_language_server",
  "ltex",
  "texlab",
  "lelwel_ls",
  "sumneko_lua",
  "marksman",
  "prosemd_lsp",
  "remark_ls",
  "zk",
  "mm0_ls",
  "nickel_ls",
  "nimls",
  "rnix",
  "ocamllsp",
  "bsl_ls",
  "opencl_ls",
  "intelephense",
  "phpactor",
  "psalm",
  "perlnavigator",
  "powershell_es",
  "prismals",
  "puppet",
  "purescriptls",
  "jedi_language_server",
  "pyright",
  "sourcery",
  "pylsp",
  "r_language_server",
  "rescriptls",
  "reason_ls",
  "robotframework_ls",
  "rome",
  "solargraph",
  "rust_analyzer",
  "sqlls",
  "sqls",
  "salt_ls",
  "theme_check",
  "slint_lsp",
  "solang",
  "solc",
  "sorbet",
  "esbonio",
  "stylelint_lsp",
  "svelte",
  "svlangserver",
  "svls",
  "verible",
  "taplo",
  "tailwindcss",
  "teal_ls",
  "terraformls",
  "tflint",
  "tsserver",
  "vls",
  "vala_ls",
  "vimls",
  "visualforce",
  "volar",
  "vuels",
  "lemminx",
  "yamlls",
  "zls",
}

local settings = {
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

mason.setup(settings)
mason_lspconfig.setup {
  ensure_installed = servers,
  automatic_installation = true,
}

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
  return
end

local opts = {}

for _, server in pairs(servers) do
  opts = {
    on_attach = require("user.lsp.handlers").on_attach,
    capabilities = require("user.lsp.handlers").capabilities,
  }

  server = vim.split(server, "@")[1]

  if server == "jsonls" then
    local jsonls_opts = require "user.lsp.settings.jsonls"
    opts = vim.tbl_deep_extend("force", jsonls_opts, opts)
  end

  if server == "yamlls" then
    local yamlls_opts = require "user.lsp.settings.yamlls"
    opts = vim.tbl_deep_extend("force", yamlls_opts, opts)
  end

  if server == "sumneko_lua" then
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
    goto continue
  end

  if server == "tsserver" then
    local tsserver_opts = require "user.lsp.settings.tsserver"
    opts = vim.tbl_deep_extend("force", tsserver_opts, opts)
  end

  if server == "pyright" then
    local pyright_opts = require "user.lsp.settings.pyright"
    opts = vim.tbl_deep_extend("force", pyright_opts, opts)
  end

  if server == "solc" then
    local solc_opts = require "user.lsp.settings.solc"
    opts = vim.tbl_deep_extend("force", solc_opts, opts)
  end

  if server == "emmet_ls" then
    local emmet_ls_opts = require "user.lsp.settings.emmet_ls"
    opts = vim.tbl_deep_extend("force", emmet_ls_opts, opts)
  end

  if server == "zk" then
    local zk_opts = require "user.lsp.settings.zk"
    opts = vim.tbl_deep_extend("force", zk_opts, opts)
  end

  if server == "jdtls" then
    goto continue
  end

  if server == "rust_analyzer" then
    local rust_opts = require "user.lsp.settings.rust"
    -- opts = vim.tbl_deep_extend("force", rust_opts, opts)
    local rust_tools_status_ok, rust_tools = pcall(require, "rust-tools")
    if not rust_tools_status_ok then
      return
    end

    rust_tools.setup(rust_opts)
    goto continue
  end

  lspconfig[server].setup(opts)
  ::continue::
end

-- TODO: add something to installer later
-- require("lspconfig").motoko.setup {}
