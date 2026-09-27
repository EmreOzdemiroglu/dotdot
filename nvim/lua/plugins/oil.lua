return {
  {
    -- Oil'de dosyaların git durumunu (M, A, ??) solda göster
    "refractalize/oil-git-status.nvim",
    dependencies = { "stevearc/oil.nvim" },
    lazy = false,
    config = true,
  },
  {
  "stevearc/oil.nvim",
  lazy = false, -- `nvim .` ile klasör açınca da Oil gelsin
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    { "<leader>pv", "<cmd>Oil<cr>", desc = "Dosya gezgini (Oil)" },
    { "-", "<cmd>Oil<cr>", desc = "Üst klasör (Oil)" },
  },
  opts = {
    default_file_explorer = true,
    delete_to_trash = true,
    skip_confirm_for_simple_edits = true,
    view_options = {
      show_hidden = true,
      is_always_hidden = function(name) return name == ".git" or name == ".." end,
    },
    columns = { "icon" },
    win_options = { signcolumn = "yes:2" }, -- git durumu için iki sütun
    keymaps = {
      ["<C-h>"] = false, -- Harpoon'un Ctrl+h'sini ezmesin
      ["<C-t>"] = false, -- Harpoon'un Ctrl+t'sini ezmesin
      ["<C-s>"] = false, -- Harpoon'un Ctrl+s'sini ezmesin
      ["<C-l>"] = false,
      ["<C-v>"] = { "actions.select", opts = { vertical = true }, desc = "Dikey bölmede aç" },
      ["<C-r>"] = "actions.refresh",
      ["q"] = "actions.close",
    },
  },
}
}
