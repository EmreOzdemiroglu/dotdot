return {
  "obsidian-nvim/obsidian.nvim",
  version = "*",
  -- Her yerden Space o ile notlara ulaşabilmek için komut/tuşlarda yükle
  cmd = "Obsidian",
  event = {
    "BufReadPre " .. vim.fn.expand("~") .. "/notes/*.md",
    "BufNewFile " .. vim.fn.expand("~") .. "/notes/*.md",
  },
  keys = {
    { "<leader>oo", "<cmd>Obsidian quick_switch<cr>", desc = "Not aç (ara)" },
    { "<leader>os", "<cmd>Obsidian search<cr>", desc = "Notların içinde ara" },
    { "<leader>on", "<cmd>Obsidian new<cr>", desc = "Yeni not" },
    { "<leader>od", "<cmd>Obsidian today<cr>", desc = "Bugünün günlüğü" },
    { "<leader>oy", "<cmd>Obsidian yesterday<cr>", desc = "Dünün günlüğü" },
    { "<leader>oD", "<cmd>Obsidian dailies<cr>", desc = "Tüm günlükler" },
    { "<leader>ob", "<cmd>Obsidian backlinks<cr>", desc = "Bu nota link verenler" },
    { "<leader>ol", "<cmd>Obsidian links<cr>", desc = "Bu nottaki linkler" },
    { "<leader>ot", "<cmd>Obsidian tags<cr>", desc = "Etiketler" },
    { "<leader>or", "<cmd>Obsidian rename<cr>", desc = "Notu yeniden adlandır (linkleri de)" },
    { "<leader>oc", "<cmd>Obsidian toc<cr>", desc = "İçindekiler" },
    { "<leader>ox", "<cmd>Obsidian toggle_checkbox<cr>", desc = "Checkbox işaretle" },
    { "<leader>oa", "<cmd>Obsidian open<cr>", desc = "Obsidian uygulamasında aç" },
    { "<leader>ok", "<cmd>Obsidian link<cr>", mode = "x", desc = "Seçimi mevcut nota linkle" },
    { "<leader>oK", "<cmd>Obsidian link_new<cr>", mode = "x", desc = "Seçimden yeni not + link" },
  },
  opts = {
    legacy_commands = false,
    workspaces = { { name = "notes", path = "~/notes" } },
    notes_subdir = nil,
    new_notes_location = "current_dir",
    daily_notes = { folder = "Journal/Daily", date_format = "%Y-%m-%d" },
    -- Not adı = dosya adı (Obsidian'daki gibi), rastgele ID yok
    note_id_func = function(title) return title or tostring(os.time()) end,
    frontmatter = { enabled = false },
    completion = { min_chars = 2 },
    picker = { name = "telescope.nvim" },
    ui = { enable = false }, -- render-markdown zaten render ediyor
    checkbox = { order = { " ", "x" } },
    attachments = { folder = "Ekler" },
    statusline = { enabled = false },
    footer = { enabled = false },
  },
}
