-- Install packer
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	is_bootstrap = true
	vim.fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
	vim.cmd([[packadd packer.nvim]])
end

require("packer").startup(function(use)
	-- Package manager
	use("wbthomason/packer.nvim")
	use("simrat39/rust-tools.nvim")
	-- other plugins...
	use("jose-elias-alvarez/null-ls.nvim")
	-- nvim tree
	use("nvim-tree/nvim-web-devicons") -- optional, for file icons
	use("nvim-tree/nvim-tree.lua")
	-- Completion framework:
	use("hrsh7th/nvim-cmp")
	-- LSP completion source:
	use("hrsh7th/cmp-nvim-lsp")
	use("feline-nvim/feline.nvim")
	-- Useful completion sources:
	use("hrsh7th/cmp-nvim-lua")
	use("hrsh7th/cmp-nvim-lsp-signature-help")
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/vim-vsnip")
	use("L3MON4D3/LuaSnip")
	use("windwp/nvim-autopairs")
	use("akinsho/toggleterm.nvim")
	use({
		-- LSP Configuration & Plugins
		"neovim/nvim-lspconfig",
		requires = {
			-- Automatically install LSPs to stdpath for neovim
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",

			-- Useful status updates for LSP
			"j-hui/fidget.nvim",

			-- Additional lua configuration, makes nvim stuff amazing
			"folke/neodev.nvim",
		},
	})

	local rt = require("rust-tools")
	---------------------------------
	-- Formatting
	---------------------------------
	local formatting = require("null-ls").builtins.formatting
	local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

	require("null-ls").setup({
		sources = {
			formatting.black,
			formatting.rustfmt,
			formatting.phpcsfixer,
			formatting.prettier,
			formatting.stylua,
		},
		on_attach = function(client, bufnr)
			if client.name == "tsserver" or client.name == "rust_analyzer" or client.name == "pyright" then
				client.resolved_capabilities.document_formatting = false
			end

			if client.supports_method("textDocument/formatting") then
				vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
				vim.api.nvim_create_autocmd("BufWritePre", {
					group = augroup,
					callback = function()
						vim.lsp.buf.format()
					end,
				})
			end
		end,
	})

	---------------------------------
	-- Auto commands
	---------------------------------
	vim.cmd([[ autocmd BufWritePre <buffer> lua vim.lsp.buf.format() ]])

	rt.setup({
		server = {
			on_attach = function(_, bufnr)
				-- Hover actions
				vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
				-- Code action groups
				vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group,
					{ buffer = bufnr })
			end,
		},
	})

	-- LSP Diagnostics Options Setup
	local sign = function(opts)
		vim.fn.sign_define(opts.name, {
			texthl = opts.name,
			text = opts.text,
			numhl = "",
		})
	end

	sign({ name = "DiagnosticSignError", text = "☠☠" })
	sign({ name = "DiagnosticSignWarn", text = "⚠⚠" })
	sign({ name = "DiagnosticSignHint", text = "" })
	sign({ name = "DiagnosticSignInfo", text = "" })

	vim.diagnostic.config({
		virtual_text = true, -- display diagnostics in text
		signs = true,
		update_in_insert = true,
		underline = true,
		severity_sort = false,
		float = {
			border = "rounded",
			source = "always",
			header = "",
			prefix = "",
		},
	})

	vim.cmd([[
set signcolumn=yes
autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
]])

	use({
		-- Highlight, edit, and navigate code
		"nvim-treesitter/nvim-treesitter",
		run = function()
			pcall(require("nvim-treesitter.install").update({ with_sync = true }))
		end,
	})

	use({
		-- Additional text objects via treesitter
		"nvim-treesitter/nvim-treesitter-textobjects",
		after = "nvim-treesitter",
	})

	-- Git related plugins
	use("tpope/vim-fugitive")
	use("tpope/vim-rhubarb")
	use("lewis6991/gitsigns.nvim")

	use("EdenEast/nightfox.nvim")
	-- autosave
	use("pocco81/auto-save.nvim")
	use("echasnovski/mini.indentscope")

	use("frazrepo/vim-rainbow")         -- Rainbow colored brackets
	use("lukas-reineke/indent-blankline.nvim") -- Add indentation guides even on blank lines
	use("numToStr/Comment.nvim")
	use("tpope/vim-sleuth")             -- Detect tabstop and shiftwidth automatically
	use("saadparwaiz1/cmp_luasnip")
	use("rafamadriz/friendly-snippets")
	-- Fuzzy Finder (files, lsp, etc)
	use({ "nvim-telescope/telescope.nvim", branch = "0.1.x", requires = { "nvim-lua/plenary.nvim" } })
	use("ruifm/gitlinker.nvim")
	-- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make", cond = vim.fn.executable("make") == 1 })

	-- Add custom plugins to packer from ~/.config/nvim/lua/custom/plugins.lua
	local has_plugins, plugins = pcall(require, "custom.plugins")
	if has_plugins then
		plugins(use)
	end

	if is_bootstrap then
		require("packer").sync()
	end
end)
-- Default options
require("nightfox").setup({
	palettes = {
		carbonfox = {
			red = "#ff0000",
			sel0 = "#3d2e27", -- visual select
		},
	},
	specs = {
		carbonfox = {
			syntax = {
				builtin0 = "#EE5396",
			},
			git = {
				changed = "#f4a261",
			},
		},
	},
})
vim.cmd("set termguicolors")
require("feline").setup()
require("mini.indentscope").setup( -- No need to copy this inside `setup()`. Will be used automatically.
	{
		-- Draw options
		draw = {
			-- Delay (in ms) between event and start of drawing scope indicator
			delay = 5,
			-- Animation rule for scope's first drawing. A function which, given
			-- next and total step numbers, returns wait time (in ms). See
			-- |MiniIndentscope.gen_animation| for builtin options. To disable
			-- animation, use `require('mini.indentscope').gen_animation.none()`.

			-- Symbol priority. Increase to display on top of more symbols.
			priority = 5,
		},
		options = {
			-- Type of scope's border: which line(s) with smaller indent to
			-- categorize as border. Can be one of: 'both', 'top', 'bottom', 'none'.
			border = "both",
			-- Whether to use cursor column when computing reference indent.
			-- Useful to see incremental scopes with horizontal cursor movements.
			indent_at_cursor = true,
			-- Whether to first check input line to be a border of adjacent scope.
			-- Use it if you want to place cursor on function header to get scope of
			-- its body.
			try_as_border = false,
		},
		-- Which character to use for drawing scope indicator
		symbol = "╎",
	}
)

-- setup must be called before loading
vim.cmd("colorscheme carbonfox")
require("gitlinker").setup({})
-- When we are bootstrapping a configuration, it doesn't
-- make sense to execute the rest of the init.lua.
--
-- You'll need to restart nvim, and then it will work.
if is_bootstrap then
	print("==================================")
	print("    Plugins are being installed")
	print("    Wait until Packer completes,")
	print("       then restart nvim")
	print("==================================")
	return
end

-- toggle term
require("toggleterm").setup({
	open_mapping = [[<c-\>]],
	hide_numbers = true,
	shade_filetypes = {},
	shade_terminals = true,
	shading_factor = 1,
	start_in_insert = true,
	insert_mappings = true,
	persist_size = true,
	direction = "float",
	close_on_exit = true,
	shell = vim.o.shell,
	auto_scroll = true,
	float_opts = {
		border = "double",
		winblend = 0,
		highlights = {
			border = "Normal",
			background = "Normal",
		},
	},
})
--autosave
require("auto-save").setup({
	execution_message = {
		message = function()
			return ("Autosaved at" .. vim.fn.strftime("%H:%M:%S"))
		end,
		cleaning_interval = 5000,
	},
	trigger_events = { "FocusLost", "Bufleave", "ExitPre" },
})
-- nvim tree
require("nvim-tree").setup({})
-- Automatically source and re-compile packer whenever you save this init.lua
local packer_group = vim.api.nvim_create_augroup("Packer", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
	command = "source <afile> | silent! LspStop | silent! LspStart | PackerCompile",
	group = packer_group,
	pattern = vim.fn.expand("$MYVIMRC"),
})

-- Set highlight on search
vim.o.hlsearch = true
vim.o.incsearch = true

vim.o.termguicolors = true

-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = "a"

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Decrease update time
vim.o.updatetime = 50
vim.wo.signcolumn = "yes"

-- from vimscript file
vim.o.scrolloff = 8
vim.o.colorcolumn = "80"
vim.opt.relativenumber = true

-- Set colorscheme
vim.o.termguicolors = true

vim.cmd([[set cursorline]])
vim.cmd([[set wrap!]])
-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"

-- [[ Basic Keymaps ]]
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local silent = { silent = true }
-- Keymapping
vim.api.nvim_set_keymap("n", "<leader>vi", ":e $VIMCONFIG<CR>", silent)
vim.api.nvim_set_keymap("n", "<leader>bo", "<cmd>%bd|e#<cr>", { desc = "Close all buffers but the current one" })

vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", silent)
-- move highlighted text with a J or K
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
-- make J not move cursor to the end of the line
vim.keymap.set("n", "J", "mzJ`z")
-- center on half page jumping
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
-- keep search terms in the middle of the screen
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
-- map cs to to clearing search highlights
vim.keymap.set("n", "<leader>cs", ":let @/ = ''<CR>", silent)
vim.keymap.set(
	{ "v" },
	"<leader>hy",
	'<cmd>lua requiregitlinker".get_buf_range_url("v", {action_callback = require"gitlinker.actions".copy_to_clipboard})<cr>',
	{ silent = true }
)
vim.keymap.set(
	{ "n" },
	"<leader>hy",
	'<cmd>lua require"gitlinker".get_buf_range_url("n", {action_callback = require"gitlinker.actions".copy_to_clipboard})<CR>',
	{ silent = true }
)
vim.keymap.set(
	{ "n" },
	"<leader>ht",
	'<cmd>lua require"gitlinker".get_buf_range_url("n", {action_callback = require"gitlinker.actions".open_in_browser})<CR>',
	{ silent = true }
)
vim.keymap.set(
	{ "v" },
	"<leader>ht",
	'<cmd>lua require"gitlinker".get_buf_range_url("v", {action_callback = require"gitlinker.actions".open_in_browser})<CR>',
	{ silent = true }
)
-- yank to system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
-- consider this for changing permission via leader x
--vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>")
vim.keymap.set({ "n", "v" }, "<leader>ww", [[:wa<CR>]])
vim.keymap.set({ "n", "v" }, "<leader>qq", [[:xa<CR>]])
-- window resizing
vim.keymap.set("n", "<C-=>", ":resize +2<CR>")
vim.keymap.set("n", "<C-->", ":resize -2<CR>")
vim.keymap.set("n", "<C-+>", ":vertical resize +2<CR>")
vim.keymap.set("n", "<C-_>", ":vertical resize -2<CR>")

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
-- Terminal --
-- Better terminal navigation
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<cr>", { silent = true })

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})

--toggle term
vim.keymap.set({ "n", "v" }, "<C-]>", ":wa<CR> | :TermExec cmd='[ -f \"Cargo.lock\" ] && cargo run' <CR>", silent)
vim.keymap.set({ "n", "v" }, "<C-'>", ":wa<CR> | :TermExec cmd='[ -f \"Cargo.lock\" ] && cargo test' <CR>", silent)
local status_ok, npairs = pcall(require, "nvim-autopairs")
if not status_ok then
	return
end

npairs.setup({
	check_ts = true,
	ts_config = {
		lua = { "string", "source" },
		javascript = { "string", "template_string" },
		java = false,
	},
	disable_filetype = { "TelescopePrompt", "spectre_panel" },
	fast_wrap = {
		map = "<M-e>",
		chars = { "{", "[", "(", '"', "'" },
		pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
		offset = 0, -- Offset from pattern match
		end_key = "$",
		keys = "qwertyuiopzxcvbnmasdfghjkl",
		check_comma = true,
		highlight = "PmenuSel",
		highlight_grey = "LineNr",
	},
})

local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
	return
end
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))
-- Enable Comment.nvim
require("Comment").setup()

require("indent_blankline").setup({
	char = "┊",
	show_trailing_blankline_indent = false,
})

-- Gitsigns
require("gitsigns").setup({
	signs = {
		add = { text = "+" },
		change = { text = "~" },
		delete = { text = "⤷" },
		topdelete = { text = "‾" },
		changedelete = { text = "~" },
		untracked = { text = "ⓤ" },
	},
	signcolumn = true,
	numhl = true,
	linehl = false,
	word_diff = false,
	-- Actions
	on_attach = function(bufnr)
		local function map(mode, l, r, opts)
			opts = opts or {}
			opts.buffer = bufnr
			vim.keymap.set(mode, l, r, opts)
		end

		-- Actions
		map({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>")
		map({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>")
		map({ "n", "v" }, "<leader>hd", ":Gitsigns toggle_deleted<CR>")
		map({ "n", "v" }, "<leader>ha", ":Gitsigns stage_buffer<CR>")
		map({ "n", "v" }, "<leader>hn", ":Gitsigns next_hunk<CR>")
		map({ "n", "v" }, "<leader>hb", ":Gitsigns toggle_current_line_blame<CR>")
		map({ "n", "v" }, "<leader>hp", ":STOP USE <leader>hv")
		map({ "n", "v" }, "<leader>hv", ":Gitsigns preview_hunk<CR>")
		map({ "n", "v" }, "<leader>hm", ":Git commit --amend --no-edit")
		map({ "n", "v" }, "<leader>hg", ":Git push")

		function GitCommit()
			local commit_message = vim.fn.input("Commit message > ")
			local git_cmd = '!git commit -m "' .. commit_message .. '"'
			vim.api.nvim_command(git_cmd)
		end

		vim.api.nvim_set_keymap("n", "<leader>hc", "<cmd>lua GitCommit()<cr>", { noremap = true })
	end,
})

local actions = require("telescope.actions")
require("telescope").setup({
	defaults = {
		mappings = {
			i = {
				["<C-u>"] = false,
				["<C-d>"] = false,
				["<esc>"] = actions.close,
			},
		},
	},
})

-- Enable telescope fzf native, if installed
pcall(require("telescope").load_extension, "fzf")

-- See `:help telescope.builtin`
vim.keymap.set("n", "<leader>?", require("telescope.builtin").oldfiles, { desc = "[?] Find recently opened files" })
-- vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set("n", "<leader>/", function()
	-- You can pass additional configuration to telescope to change theme, layout, etc.
	require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
		winblend = 5,
		previewer = false,
	}))
end, { desc = "[/] Fuzzily search in current buffer]" })

vim.keymap.set("n", "<leader>sf", require("telescope.builtin").find_files, { desc = "[S]earch [F]iles" })
vim.keymap.set("n", "<leader>sh", require("telescope.builtin").help_tags, { desc = "[S]earch [H]elp" })
vim.keymap.set("n", "<leader>sw", require("telescope.builtin").grep_string, { desc = "[S]earch current [W]ord" })
vim.keymap.set("n", "<leader>sg", require("telescope.builtin").git_status, { desc = "[S]earch by [G]it status" })
vim.keymap.set("n", "<leader><space>", require("telescope.builtin").live_grep, { desc = "[S]earch by [G]rep" })
vim.keymap.set("n", "<leader>sd", require("telescope.builtin").diagnostics, { desc = "[S]earch [D]iagnostics" })
vim.keymap.set("n", "d[", vim.diagnostic.goto_prev)
vim.keymap.set("n", "d]", vim.diagnostic.goto_next)
vim.api.nvim_set_keymap("n", "<leader>dd", "<cmd>Telescope diagnostics<CR>", { noremap = true, silent = true })

require("nvim-treesitter.configs").setup({
	ensure_installed = { "lua", "python", "rust", "vim" },
	highlight = { enable = true },
	indent = { enable = true, disable = { "python" } },
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<c-space>",
			node_incremental = "<c-space>",
			scope_incremental = "<c-s>",
			node_decremental = "<c-backspace>",
		},
	},
	textobjects = {
		select = {
			enable = true,
			lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
			keymaps = {
				-- You can use the capture groups defined in textobjects.scm
				["aa"] = "@parameter.outer",
				["ia"] = "@parameter.inner",
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				["ic"] = "@class.inner",
			},
		},
		move = {
			enable = true,
			set_jumps = true, -- whether to set jumps in the jumplist
			goto_next_start = {
				["]m"] = "@function.outer",
				["]]"] = "@class.outer",
			},
			goto_next_end = {
				["]M"] = "@function.outer",
				["]["] = "@class.outer",
			},
			goto_previous_start = {
				["[m"] = "@function.outer",
				["[["] = "@class.outer",
			},
			goto_previous_end = {
				["[M"] = "@function.outer",
				["[]"] = "@class.outer",
			},
		},
		swap = {
			enable = true,
			swap_next = {
				["<leader>a"] = "@parameter.inner",
			},
			swap_previous = {
				["<leader>A"] = "@parameter.inner",
			},
		},
	},
})

-- LSP settings.
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
	-- NOTE: Remember that lua is a real programming language, and as such it is possible
	-- to define small helper and utility functions so you don't have to repeat yourself
	-- many times.
	--
	-- In this case, we create a function that lets us more easily define mappings specific
	-- for LSP related items. It sets the mode, buffer and description for us each time.
	local nmap = function(keys, func, desc)
		if desc then
			desc = "LSP: " .. desc
		end

		vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
	end

	nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
	nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

	nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
	nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
	nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
	nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
	nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
	nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

	-- See `:help K` for why this keymap
	nmap("K", vim.lsp.buf.hover, "Hover Documentation")
	nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

	-- Lesser used LSP functionality
	nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
	nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
	nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
	nmap("<leader>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, "[W]orkspace [L]ist Folders")

	-- Create a command `:Format` local to the LSP buffer
	vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
		vim.lsp.buf.format()
	end, { desc = "Format current buffer with LSP" })
end

local servers = {
	pyright = {},
	r_language_server = {},
	rust_analyzer = {},
	sumneko_lua = {
		Lua = {
			workspace = { checkThirdParty = false },
			telemetry = { enable = false },
		},
	},
}

-- Setup neovim lua configuration
require("neodev").setup()
--
-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

-- Setup mason so it can manage external tooling
require("mason").setup()
-- Ensure the servers above are installed
local mason_lspconfig = require("mason-lspconfig")

mason_lspconfig.setup({
	ensure_installed = vim.tbl_keys(servers),
})

mason_lspconfig.setup_handlers({
	function(server_name)
		require("lspconfig")[server_name].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = servers[server_name],
		})
	end,
})
require("lspconfig").pyright.setup({})

require("lspconfig").rust_analyzer.setup({
	capabilities = capabilities,
	on_attach = on_attach,
	cmd = {
		"rustup",
		"run",
		"stable",
		"rust-analyzer",
	},
})

-- Turn on lsp status information
require("fidget").setup()

-- nvim-cmp setup
local cmp = require("cmp")

cmp.setup({
	mapping = {
		["<C-p>"] = cmp.mapping.select_prev_item(),
		["<C-n>"] = cmp.mapping.select_next_item(),
		-- Add tab support
		["<C-j>"] = cmp.mapping.scroll_docs(4),
		["<C-k>"] = cmp.mapping.scroll_docs(-4),
		["<C-e>"] = cmp.mapping.close(),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<Tab>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Insert,
			select = true,
		}),
	},
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	-- Installed sources:
	sources = {
		{ name = "path" },                         -- file paths
		{ name = "luasnip" },
		{ name = "nvim_lsp",               keyword_length = 3 }, -- from language server
		{ name = "nvim_lsp_signature_help" },      -- display function signatures with current parameter emphasized
		{ name = "nvim_lua",               keyword_length = 2 }, -- complete neovim's Lua runtime API such vim.lsp.*
		{ name = "buffer",                 keyword_length = 2 }, -- source current buffer
		{ name = "vsnip",                  keyword_length = 2 }, -- nvim-cmp source for vim-vsnip
		{ name = "calc" },                         -- source for math calculation
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	formatting = {
		fields = { "menu", "abbr", "kind" },
		format = function(entry, item)
			local menu_icon = {
				nvim_lsp = "λ",
				vsnip = "⋗",
				buffer = "Ω",
				path = "🖫",
			}
			item.menu = menu_icon[entry.source.name]
			return item
		end,
	},
})

local ls = require("luasnip")
-- some shorthands...
local snip = ls.snippet
local text = ls.text_node
local insert = ls.insert_node
local func = ls.function_node

local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
keymap("i", "<c-j>", "<cmd>lua require'luasnip'.jump(1)<CR>", opts)
keymap("s", "<c-j>", "<cmd>lua require'luasnip'.jump(1)<CR>", opts)
keymap("s", "<Tab>", "<cmd>lua require'luasnip'.jump(1)<CR>", opts)
keymap("i", "<c-k>", "<cmd>lua require'luasnip'.jump(-1)<CR>", opts)
keymap("s", "<c-k>", "<cmd>lua require'luasnip'.jump(-1)<CR>", opts)

local date = function()
	return { os.date("%Y-%m-%d") }
end
ls.add_snippets(nil, {
	all = {
		snip({
			trig = "date",
			namr = "Date",
			dscr = "Date in the form of YYYY-MM-DD",
		}, {
			func(date, {}),
		}),
		snip({
			trig = "println(a = {:?}, a)",
			namr = "print line macro in rust",
			dscr = "print variable debug in rust",
		}, {
			text('println!("'),
			insert(1, "a"),
			text(' = {:?}", '),
			insert(2, "a"),
			text(");"),
		}),
		snip({
			trig = "println(a = {:?}, b = {:?}, a, b)",
			namr = "print line macro in rust",
			dscr = "print variable debug in rust",
		}, {
			text('println!(a = {:?}, b = {:?}", '),
			insert(1, "a"),
			text(", "),
			insert(2, "b"),
			text(");"),
		}),
		snip({
			trig = "dbg!",
			namr = "print debug",
			dscr = "print variable debug in rust",
		}, {
			text("dbg!("),
			insert(1, "var"),
			text(");"),
		}),
	},
})
