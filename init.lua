-- Отключаем устаревшие предупреждения (временно)
vim.deprecate = function() end

-- Basic
require('core.mapping')
require('core.plugins')
-- THEME
require('cybrvim').load()
--require('core.colors')
require('core.configs')
