vim.o.scrolloff = 8
vim.o.colorcolumn = "80"
vim.cmd([[set wrap!]])
vim.cmd([[ autocmd BufWritePre <buffer> lua vim.lsp.buf.format() ]])
