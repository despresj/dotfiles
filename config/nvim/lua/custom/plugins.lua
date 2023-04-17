local plugins = {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "rust-analyzer",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    config = function ()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },
  {
    "rust-lang/rust.vim",
    ft = "rust",
    init = function ()
      vim.g.rustfmt_autosave = 1
    end
  },
{
      "simrat39/rust-tools.nvim",
  ft = "rust",
  requires = {"neovim/nvim-lspconfig"},
  config = function()
    local dap = {
      adapter = function()
        local extension_path = vim.env.HOME .. '/.vscode/extensions/vadimcn.vscode-lldb-1.9.0/'
        local codelldb_path = extension_path .. 'adapter/codelldb'
        local liblldb_path = extension_path .. 'lldb/lib/liblldb.dylib'
        return require('rust-tools.dap').get_codelldb_adapter(codelldb_path, liblldb_path)
      end,
    }
    require('rust-tools').setup({dap = dap})
  end
},
  {
    "mfussenegger/nvim-dap",
  },
  {
    "saecki/crates.nvim",
    ft = {"rust", "toml"},
    config = function (_, opts)
      local crates = require("crates")
      crates.setup(opts)
      crates.show()
    end
  },
  {
    "hrsh7th/nvim-cmp",
    opts = function ()
      local M = require "plugins.configs.cmp"
      table.insert(M.sources, {name = "crates"})
      return M
    end,
  }

}
return plugins
