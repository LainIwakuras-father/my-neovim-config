return {
  {
    "psf/black",  -- Форматтер Python
    ft = "python",
    config = function()
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*.py",
        callback = function() vim.cmd("Black") end
      })
    end
  },
  {
    "Vimjas/vim-python-pep8-indent",  -- Умные отступы для Python
    ft = "python"
  },
  {
    "microsoft/python-type-stubs",  -- Заглушки типов для автодополнения
    ft = "python"
  }
}
