return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim", -- Менеджер LSP-серверов
		"williamboman/mason-lspconfig.nvim", -- Мост между Mason и lspconfig
		"hrsh7th/cmp-nvim-lsp",  -- Источник автодополнения для LSP
	},
	config = function()
		-- Настройка Mason для установки LSP-серверов
		require("mason").setup()
		require("mason-lspconfig").setup({
			ensure_installed = { "pyright", "gopls", "tsserver", "html", "cssls" }
		})

		local lspconfig = require("lspconfig")
		local capabilities = require('cmp_nvim_lsp').default_capabilities()

		-- Общая конфигурация для всех LSP
		local on_attach = function(client, bufnr)
			local opts = { buffer = bufnr, remap = false }
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
			vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
			vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
		end

		-- Настройка для Python
		lspconfig.pyright.setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = { python = { analysis = { typeCheckingMode = "basic" } } }
		})

		-- Настройка для Go
		lspconfig.gopls.setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = { gopls = { analyses = { unusedparams = true } } }
		})

		-- Настройка для JavaScript/TypeScript
		lspconfig.tsserver.setup({
			capabilities = capabilities,
			on_attach = on_attach,
			filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact" }
		})
	end
}
