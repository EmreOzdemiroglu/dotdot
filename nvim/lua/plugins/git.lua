return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add = { text = "▎" }, change = { text = "▎" }, delete = { text = "" },
        topdelete = { text = "" }, changedelete = { text = "▎" }, untracked = { text = "▎" },
      },
      current_line_blame_opts = { delay = 300 },
      on_attach = function(buf)
        local gs = require("gitsigns")
        local function map(mode, keys, fn, desc)
          vim.keymap.set(mode, keys, fn, { buffer = buf, desc = desc })
        end

        map("n", "]h", function() gs.nav_hunk("next") end, "Sonraki değişiklik")
        map("n", "[h", function() gs.nav_hunk("prev") end, "Önceki değişiklik")
        map("n", "<leader>hp", gs.preview_hunk, "Değişikliği önizle")
        map({ "n", "x" }, "<leader>hs", function()
          if vim.fn.mode():match("[vV]") then
            gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
          else
            gs.stage_hunk()
          end
        end, "Değişikliği stage et / geri al")
        map({ "n", "x" }, "<leader>hr", function()
          if vim.fn.mode():match("[vV]") then
            gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
          else
            gs.reset_hunk()
          end
        end, "Değişikliği geri al (reset)")
        map("n", "<leader>hS", gs.stage_buffer, "Tüm dosyayı stage et")
        map("n", "<leader>hR", gs.reset_buffer, "Tüm dosyayı reset et")
        map("n", "<leader>hb", function() gs.blame_line({ full = true }) end, "Bu satırı kim yazdı")
        map("n", "<leader>tb", gs.toggle_current_line_blame, "Satır blame aç/kapat")
        map({ "o", "x" }, "ih", gs.select_hunk, "Değişiklik (hunk)")
      end,
    },
  },
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Tüm değişiklikler (diff)" },
      { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "Dosya geçmişi" },
      { "<leader>gH", "<cmd>DiffviewFileHistory<cr>", desc = "Proje geçmişi" },
      { "<leader>gq", "<cmd>DiffviewClose<cr>", desc = "Diff kapat" },
    },
    opts = { enhanced_diff_hl = true },
  },
  {
    "kdheepak/lazygit.nvim",
    cmd = "LazyGit",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = { { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" } },
  },
}
