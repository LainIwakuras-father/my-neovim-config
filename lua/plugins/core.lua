return {
      -- Менеджер LSP, линтеров и форматтеров
        {
            "williamboman/mason.nvim",
                 config = function()
                       require("mason").setup()
                           end
        }
}
