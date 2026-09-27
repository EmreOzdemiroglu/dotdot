return {
  "folke/trouble.nvim",
  cmd = "Trouble",
  opts = { focus = true },
  keys = {
    { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Projedeki tüm hatalar" },
    { "<leader>xb", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Bu dosyadaki hatalar" },
    { "<leader>xs", "<cmd>Trouble symbols toggle win.position=right<cr>", desc = "Semboller (yan panel)" },
    { "<leader>xr", "<cmd>Trouble lsp toggle win.position=right<cr>", desc = "Tanım / kullanım (LSP)" },
    { "<leader>xq", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix listesi" },
    { "]x", function() require("trouble").next({ skip_groups = true, jump = true }) end, desc = "Sonraki Trouble öğesi" },
    { "[x", function() require("trouble").prev({ skip_groups = true, jump = true }) end, desc = "Önceki Trouble öğesi" },
  },
}
