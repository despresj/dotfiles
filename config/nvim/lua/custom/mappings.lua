local M = {}

M.dap = {
  n = {
    ["<leader>db"] = {
      "<cmd> DapToggleBreakpoint <CR>",
      "Toggle Breakpoint"
    },
    ["<leader>dus"] = {
      function ()
        local widgets = require('dap.ui.widgets');
        local sidebar = widgets.sidebar(widgets.scopes);
        sidebar.open();
      end,
      "Open debugging sidebar"
    },
["<C-]>"] = {
  function()
    local cmd = "cargo run"
    require("nvterm.terminal").toggle("horizontal", cmd)
  end,
  "toggle term",
},
  },

}

return M
