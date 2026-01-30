return {
  "stevearc/conform.nvim",  -- Универсальный форматтер
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("conform").setup({
      formatters_by_ft = {
        python = { "black" },
        go = { "gofumpt", "golines" },  -- или только "gofumpt"
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        lua = { "stylua" },
        html = { "prettier" },
        css = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
    })
    
    -- Горячая клавиша для форматирования
    vim.keymap.set({ "n", "v" }, "<leader>f", function()
      require("conform").format({ async = true, lsp_fallback = true })
    end, { desc = "Format file" })
  end
}
