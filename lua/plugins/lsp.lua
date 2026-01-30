return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    -- Настройка Mason
    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = { 
        "pyright", 
        "gopls", 
        "typescript-language-server",  -- Заменили tsserver
        "html",
        "cssls",
        "lua_ls"  -- Добавили для Lua
      }
    })

    -- Общие настройки LSP
    local capabilities = require('cmp_nvim_lsp').default_capabilities()
    
    local on_attach = function(client, bufnr)
      local opts = { buffer = bufnr, remap = false }
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
      vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
      vim.keymap.set("n", "<leader>fd", vim.lsp.buf.format, opts)
      
      -- Подсветка ссылок при удержании курсора
      if client.server_capabilities.documentHighlightProvider then
        vim.api.nvim_create_autocmd({"CursorHold", "CursorHoldI"}, {
          buffer = bufnr,
          callback = function() vim.lsp.buf.document_highlight() end
        })
        vim.api.nvim_create_autocmd({"CursorMoved", "CursorMovedI"}, {
          buffer = bufnr,
          callback = function() vim.lsp.buf.clear_references() end
        })
      end
    end

    -- Настройка каждого LSP сервера через новое API
    local lsp = require('lspconfig')
    
    -- Python (pyright)
    lsp.pyright.setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        pyright = { autoImportCompletion = true },
        python = {
          analysis = {
            typeCheckingMode = "basic",
            autoSearchPaths = true,
            useLibraryCodeForTypes = true
          }
        }
      }
    })

    -- Go (gopls)
    lsp.gopls.setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        gopls = {
          analyses = {
            unusedparams = true,
            shadow = true,
          },
          staticcheck = true,
          gofumpt = true,
          hints = {
            assignVariableTypes = true,
            compositeLiteralFields = true,
            constantValues = true,
            functionTypeParameters = true,
            parameterNames = true,
            rangeVariableTypes = true,
          }
        }
      }
    })

    -- TypeScript/JavaScript
    lsp.tsserver.setup({  -- Пока оставляем tsserver, но можно заменить на typescript-language-server
      capabilities = capabilities,
      on_attach = on_attach,
      filetypes = { 
        "javascript", 
        "typescript", 
        "javascriptreact", 
        "typescriptreact",
        "vue",
        "svelte"
      },
      init_options = {
        preferences = {
          disableSuggestions = false,
          importModuleSpecifierPreference = "relative"
        }
      }
    })

    -- Lua
    lsp.lua_ls.setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        Lua = {
          runtime = { version = 'LuaJIT' },
          diagnostics = { globals = { 'vim' } },
          workspace = { 
            library = vim.api.nvim_get_runtime_file("", true),
            checkThirdParty = false
          },
          telemetry = { enable = false }
        }
      }
    })

    -- Настройка символов в левой колонке
    vim.fn.sign_define('DiagnosticSignError', 
      { text = '', texthl = 'DiagnosticSignError' })
    vim.fn.sign_define('DiagnosticSignWarn', 
      { text = '', texthl = 'DiagnosticSignWarn' })
    vim.fn.sign_define('DiagnosticSignInfo', 
      { text = '', texthl = 'DiagnosticSignInfo' })
    vim.fn.sign_define('DiagnosticSignHint', 
      { text = '', texthl = 'DiagnosticSignHint' })
  end
}
