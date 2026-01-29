return {
  "ray-x/navigator.lua",
  dependencies = {
    "ray-x/guihua.lua",
    "ray-x/go.nvim",
    "ray-x/lsp_signature.nvim",
    "williamboman/mason.nvim",        -- Менеджер для установки LSP
    "williamboman/mason-lspconfig.nvim", -- Мост между Mason и LSP
    "neovim/nvim-lspconfig",
  },
  config = function()
    -- Сначала настройка Mason для управления LSP-серверами
    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = { "pyright", "gopls", "lua_ls", "bashls" },
      automatic_installation = true,  -- Автоматически ставить недостающие серверы
    })
    
    -- Затем настройка Navigator
    require("navigator").setup({
      lsp_signature_help = true,
      lsp = {
        format_on_save = true,
        disable_format_cap = { "tsserver" },
      },
      default_mapping = false,
    })
    
    -- Настройка Go-специфичных инструментов
    require("go").setup({
      goimport = "gopls",
      gofmt = "gofumpt",
    })
    
    -- Остальные настройки остаются без изменений
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
    vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Show documentation" })
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code actions" })
    vim.keymap.set("n", "<leader>fm", vim.lsp.buf.format, { desc = "Format code" })
    
    -- Go-специфичные горячие клавиши
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "go" },
      group = vim.api.nvim_create_augroup("go_keymaps", { clear = true }),
      callback = function()
        vim.keymap.set("n", "<C-i>", "<cmd>GoImport<CR>", { buffer = true, desc = "Go: Add imports" })
        vim.keymap.set("n", "<C-b>", "<cmd>GoBuild<CR>", { buffer = true, desc = "Go: Build package" })
        vim.keymap.set("n", "<C-t>", "<cmd>GoTestPkg<CR>", { buffer = true, desc = "Go: Run tests" })
        vim.keymap.set("n", "<C-c>", "<cmd>GoCoverage -p<CR>", { buffer = true, desc = "Go: Show coverage" })
        vim.keymap.set("n", "T", "<cmd>lua require('go.alternate').switch(true, 'vsplit')<CR>", 
                      { buffer = true, desc = "Go: Open test in vsplit" })
        vim.keymap.set("n", "S", "<cmd>lua require('go.alternate').switch(true, 'split')<CR>", 
                      { buffer = true, desc = "Go: Open test in split" })
      end,
    })
    
    -- Python-специфичные горячие клавиши
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "python" },
      group = vim.api.nvim_create_augroup("python_keymaps", { clear = true }),
      callback = function()
        vim.keymap.set("n", "<leader>pr", "<cmd>!python %<CR>", 
                      { buffer = true, desc = "Python: Run file" })
        vim.keymap.set("n", "<leader>pt", "<cmd>!pytest<CR>", 
                      { buffer = true, desc = "Python: Run pytest" })
        vim.keymap.set("n", "<leader>pv", "<cmd>lua require('navigator.definition').definition()<CR>", 
                      { buffer = true, desc = "Python: Go to definition" })
      end,
    })
  end
}
