return {
	{
		"stevearc/aerial.nvim",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons"
		},
		opts = {
			-- Приоритет бэкендов (LSP будет использоваться если доступен)
			backends = { "lsp", "treesitter", "markdown", "man" },

			layout = {
				-- Максимальная ширина панели
				max_width = { 40, 0.3 },
				min_width = 30,

				-- Положение панели (prefer_right - предпочитать справа)
				default_direction = "prefer_right",
				placement = "edge",
			},

			-- Прикреплять к текущему окну
			attach_mode = "window",

			-- Автоматически открывать при входе в буфер
			open_automatic = function(bufnr)
				-- Открывать только если файл больше 10 строк
				return vim.api.nvim_buf_line_count(bufnr) > 10
			end,

			-- Закрывать при переключении буфера
			close_automatic_events = { "switch_buffer", "unfocus" },

			-- Какие типы символов показывать
			filter_kind = {
				"Class",
				"Constructor",
				"Enum",
				"Function",
				"Interface",
				"Method",
				"Module",
				"Struct",
			},

			-- Иконки для символов
			nerd_font = "auto",

			-- Подсвечивать символ под курсором
			highlight_on_hover = true,
			highlight_closest = true,

			-- Настройки для LSP
			lsp = {
				diagnostics_trigger_update = true,
				update_when_errors = true,
			},

			-- Настройки для Treesitter
			treesitter = {
				update_delay = 300,
			},
		},
		config = function(_, opts)
			require("aerial").setup(opts)

			-- Клавиши для управления Aerial
			vim.keymap.set("n", "<leader>ao", "<cmd>AerialToggle!<CR>", { desc = "Aerial toggle" })
			vim.keymap.set("n", "<leader>af", "<cmd>AerialNavToggle<CR>", { desc = "Aerial focus" })
			vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { desc = "Previous symbol" })
			vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { desc = "Next symbol" })
			vim.keymap.set("n", "[[", "<cmd>AerialPrevUp<CR>", { desc = "Previous up" })
			vim.keymap.set("n", "]]", "<cmd>AerialNextUp<CR>", { desc = "Next up" })
		end,
	}
}
