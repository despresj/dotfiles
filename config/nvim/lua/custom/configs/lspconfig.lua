local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities
local lspconfig = require("lspconfig")
local util = require "lspconfig/util"

lspconfig.rust_analyzer.setup({
  on_attach = on_attach,require,
  capabilities = capabilities,
  filetypes = {"rust"},
  root_dir = util.root_pattern("Cargo.toml"),
  settings = {
['rust_analyzer'] = {
       assist = {
        importEnforceGranularity = true,
        importPrefix = "crate",
      },
    cargo = {
      allFeatures = true,
    }
  }
  }
})

