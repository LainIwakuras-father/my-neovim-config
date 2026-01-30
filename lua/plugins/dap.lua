return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "leoluz/nvim-dap-go",      -- Адаптер для Go
    "mfussenegger/nvim-dap-python",  -- Адаптер для Python
  },
  config = function()
    -- Настройка для Python
    require('dap-python').setup('~/.virtualenvs/debugpy/bin/python')
    
    -- Настройка для Go
    require('dap-go').setup()
    
    -- Горячие клавиши для отладки
    vim.keymap.set('n', '<F5>', require('dap').continue)
    vim.keymap.set('n', '<F9>', require('dap').toggle_breakpoint)
    vim.keymap.set('n', '<F10>', require('dap').step_over)
  end
}
