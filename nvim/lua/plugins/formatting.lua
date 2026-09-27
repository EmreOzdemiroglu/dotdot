-- JS/TS tarafı: projede biome.json varsa Biome, yoksa Prettier
local web = { "biome", "prettierd", "prettier", stop_after_first = true }

return {
  "stevearc/conform.nvim",
  event = "BufWritePre",
  cmd = "ConformInfo",
  keys = {
    { "<leader>f", function() require("conform").format({ async = true }) end, mode = { "n", "x" }, desc = "Formatla" },
    { "<leader>tf", function()
        vim.g.format_on_save = not vim.g.format_on_save
        vim.notify("Kaydederken formatlama: " .. (vim.g.format_on_save and "açık" or "kapalı"))
      end, desc = "Kaydederken formatlamayı aç/kapat" },
  },
  init = function()
    vim.g.format_on_save = true
  end,
  opts = {
    formatters_by_ft = {
      javascript = web, javascriptreact = web,
      typescript = web, typescriptreact = web,
      json = web, jsonc = web, css = web,
      html = { "prettierd", "prettier", stop_after_first = true },
      yaml = { "prettierd", "prettier", stop_after_first = true },
      markdown = { "prettierd", "prettier", stop_after_first = true },
      python = { "ruff_organize_imports", "ruff_format" },
      go = { "goimports", "gofmt" },
      lua = { "stylua" },
      sh = { "shfmt" }, bash = { "shfmt" }, zsh = { "shfmt" },
    },
    formatters = {
      -- Biome sadece projede biome.json varsa çalışsın
      biome = { require_cwd = true },
    },
    format_on_save = function(buf)
      if not vim.g.format_on_save then return end
      -- Obsidian notlarına dokunma
      if vim.api.nvim_buf_get_name(buf):find(vim.fn.expand("~/notes/"), 1, true) then return end
      return { timeout_ms = 1000, lsp_format = "fallback" }
    end,
  },
}
