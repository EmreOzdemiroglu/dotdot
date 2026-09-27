return {
  "nvim-telescope/telescope.nvim",
  branch = "master",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  config = function()
    local telescope = require("telescope")
    telescope.setup({})
    pcall(telescope.load_extension, "fzf")

    local builtin = require("telescope.builtin")
    vim.keymap.set("n", "<leader>pf", builtin.find_files, { desc = "Dosya ara" })
    vim.keymap.set("n", "<leader>ps", builtin.live_grep, { desc = "İçerikte ara (grep)" })
    vim.keymap.set("n", "<C-p>", builtin.git_files, { desc = "Git dosyaları" })
    vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "Kısayollarda ara" })
  end,
}
