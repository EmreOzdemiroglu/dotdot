return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.g.whichkey_auto = false -- varsayılan: menü kendiliğinden açılmaz
  end,
  opts = {
    preset = "modern",
    -- Mod kapalıyken bekleme süresi "sonsuz": menü sadece Space ? ile açılır
    delay = function()
      return vim.g.whichkey_auto and 300 or 1e9
    end,
    spec = {
      { "<leader>c", group = "Cheatsheet / Code" },
      { "<leader>d", group = "Debug / Semboller" },
      { "<leader>g", group = "Git" },
      { "<leader>h", group = "Git hunk" },
      { "<leader>o", group = "Obsidian notlar" },
      { "<leader>p", group = "Proje (dosya, arama)" },
      { "<leader>s", group = "Ara" },
      { "<leader>t", group = "Aç / Kapat" },
      { "<leader>w", group = "Workspace" },
      { "<leader>x", group = "Trouble (listeler)" },
    },
  },
  keys = {
    { "<leader>?", function() require("which-key").show() end, desc = "Kısayol menüsü" },
    { "<leader>tk", function()
        vim.g.whichkey_auto = not vim.g.whichkey_auto
        vim.notify("Kısayol menüsü: " .. (vim.g.whichkey_auto and "otomatik" or "kapalı (Space ? ile aç)"))
      end, desc = "Otomatik kısayol menüsünü aç/kapat" },
  },
}
