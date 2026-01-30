return {
  "ray-x/go.nvim",
  dependencies = {
    "ray-x/guihua.lua",
    "neovim/nvim-lspconfig",
    "nvim-treesitter/nvim-treesitter",
  },
  ft = { "go", "gomod", "gowork", "gotmpl" },
  build = ':lua require("go.install").update_all_sync()',
  config = function()
    require("go").setup({
      goimport = "gopls",
      gofmt = "gofumpt",
      -- max_line_len теперь работает с golines
      -- если хотите ограничение строк, установите golines:
      -- go install github.com/segmentio/golines@latest
      -- и используйте:
      -- gofmt = "golines",  -- вместо gofumpt
      -- max_line_len = 120,
      fillstruct = "gopls",
      lsp_cfg = false,  -- Используем нашу конфигурацию из lsp.lua
      lsp_keymaps = false,
      lsp_diag_hdlr = false,  -- Отключаем обработку диагностики go.nvim
      diagnostic = {
        hdlr = false,
      },
      dap_debug = false,  -- Если нужно отладка, настройте отдельно
      textobjects = false,  -- Используем из treesitter-textobjects
    })
    
    -- Горячие клавиши для Go
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "go",
      callback = function()
        vim.keymap.set("n", "<leader>gt", "<cmd>GoTest<cr>", 
          { desc = "Go Test" })
        vim.keymap.set("n", "<leader>gf", "<cmd>GoFmt<cr>", 
          { desc = "Go Format" })
        vim.keymap.set("n", "<leader>gi", "<cmd>GoImport<cr>", 
          { desc = "Go Import" })
      end
    })
  end
}
