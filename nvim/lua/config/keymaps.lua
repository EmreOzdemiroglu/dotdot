
-- Yarım sayfa kaydırınca imleç ekranın ortasında kalsın
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Arama sonuçlarında gezerken de ortada kalsın
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Cheatsheet
vim.keymap.set("n", "<leader>cs", function() require("config.cheatsheet").open() end, { desc = "Cheatsheet aç" })
vim.keymap.set("n", "<leader>ce", function() vim.cmd.edit(require("config.cheatsheet").path) end, { desc = "Cheatsheet düzenle" })

-- Visual modda seçili satırları J / K ile aşağı / yukarı taşı
vim.keymap.set("x", "J", ":m '>+1<CR>gv=gv", { silent = true, desc = "Satırı aşağı taşı" })
vim.keymap.set("x", "K", ":m '<-2<CR>gv=gv", { silent = true, desc = "Satırı yukarı taşı" })

-- Girinti verince seçim kaybolmasın
vim.keymap.set("x", "<", "<gv")
vim.keymap.set("x", ">", ">gv")

-- J ile satır birleştirirken imleç yerinde kalsın
vim.keymap.set("n", "J", "mzJ`z")

-- Seçimin üstüne yapıştır ama kopyalanan şey kaybolmasın
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Yapıştır (register'ı koru)" })

-- İmleçteki kelimeyi tüm dosyada değiştir
vim.keymap.set("n", "<leader>r", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Kelimeyi dosyada değiştir" })

-- Esc ile arama vurgusunu kaldır
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Option+Backspace: insert ve komut satırında önceki kelimeyi sil
vim.keymap.set({ "i", "c" }, "<M-BS>", "<C-w>", { desc = "Kelime sil" })
