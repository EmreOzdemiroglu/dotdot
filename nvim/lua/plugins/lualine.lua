return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VeryLazy",
  init = function()
    vim.opt.showmode = false -- mod zaten statusline'da görünüyor
  end,
  opts = {
    options = {
      theme = "tokyonight",
      globalstatus = true,
      component_separators = "",
      section_separators = { left = "", right = "" },
      disabled_filetypes = { statusline = { "lazy" } },
    },
    sections = {
      lualine_a = { { "mode", separator = { left = "" }, right_padding = 2 } },
      lualine_b = { "branch", "diff" },
      lualine_c = {
        { "filetype", icon_only = true, padding = { left = 1, right = 0 } },
        { "filename", path = 1, symbols = { modified = " ●", readonly = " ", unnamed = "[İsimsiz]" } },
        {
          function()
            local list = require("harpoon"):list()
            local current = vim.fn.expand("%:.")
            for i, item in ipairs(list.items) do
              if item.value == current then return "󰛢 " .. i end
            end
            return ""
          end,
          color = { fg = "#ff9e64" },
        },
      },
      lualine_x = {
        { function() return "󰌌" end, cond = function() return vim.g.whichkey_auto end, color = { fg = "#bb9af7" } },
        { "diagnostics", symbols = { error = " ", warn = " ", info = " ", hint = "󰌵 " } },
        {
          function()
            local names = {}
            for _, c in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do table.insert(names, c.name) end
            return #names > 0 and (" " .. table.concat(names, ", ")) or ""
          end,
          color = { fg = "#7aa2f7" },
        },
      },
      lualine_y = { "progress" },
      lualine_z = { { "location", separator = { right = "" }, left_padding = 2 } },
    },
  },
}
