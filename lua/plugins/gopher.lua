return {
  "olexsmir/gopher.nvim",
  ft = { "go", "gomod", "gotmpl" },
  build = function()
    vim.cmd [[silent! GoInstallDeps]]
  end,
  config = function()
    require("gopher").setup({})
    
    -- Полезные keymaps для Go
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "go",
      callback = function()
        local map = vim.keymap.set
        local opts = { buffer = true, desc = "Go tools" }
        
        map("n", "<leader>gt", "<cmd>GoTest<cr>", opts)
        map("n", "<leader>gf", "<cmd>GoTestFile<cr>", opts)
        map("n", "<leader>ga", "<cmd>GoAlt<cr>", opts)
        map("n", "<leader>gie", "<cmd>GoIfErr<cr>", opts)
        map("n", "<leader>gim", "<cmd>GoImpl<cr>", opts)
      end
    })
  end
}
