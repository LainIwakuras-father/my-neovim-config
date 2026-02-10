return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		-- ВРЕМЕННО отключаем все зависимости
		require("nvim-treesitter.configs").setup({
			-- Только самые основные языки для теста
			ensure_installed = { "go", "lua", "vim", "bash", "python" },
			auto_install = true,
			sync_install = false,

			highlight = {
				enable = true,
				-- Отключаем для больших файлов
				disable = function(lang, buf)
					local max_filesize = 100 * 1024 -- 100KB
					local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
					if ok and stats and stats.size > max_filesize then
						return true
					end
					return false
				end,
				-- КРИТИЧНО: отключаем дополнительные фичи
				additional_vim_regex_highlighting = false,
			},

			-- ВРЕМЕННО отключаем остальные модули
			indent = { enable = false },
			incremental_selection = { enable = false },
			textobjects = { enable = false }, -- Источник проблем!
		})

		-- Убираем автокоманды для markdown (временно)
		-- vim.api.nvim_create_autocmd("FileType", {
		--   pattern = {"markdown"},
		--   callback = function(ev)
		--     require("treesitter-context").disable()
		--   end
		-- })
	end
}
