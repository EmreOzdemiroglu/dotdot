local parsers = {
  "lua", "vim", "vimdoc", "query", "bash", "markdown", "markdown_inline",
  "javascript", "typescript", "tsx", "html", "css", "json", "yaml", "toml",
  "python", "go", "rust", "c", "regex", "diff", "gitcommit",
}

return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      local ts = require("nvim-treesitter")
      ts.install(parsers)

      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
          local lang = vim.treesitter.language.get_lang(args.match)
          if not lang then return end
          -- Listede olmayan dilleri ilk açılışta otomatik kur
          if not vim.list_contains(ts.get_installed(), lang)
            and vim.list_contains(ts.get_available(), lang) then
            ts.install(lang)
            return
          end
          if pcall(vim.treesitter.start, args.buf, lang) then
            vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    config = function()
      require("nvim-treesitter-textobjects").setup({
        select = { lookahead = true },
        move = { set_jumps = true },
      })

      local select = require("nvim-treesitter-textobjects.select")
      local move = require("nvim-treesitter-textobjects.move")

      local objects = {
        f = "function", c = "class", a = "parameter",
        i = "conditional", l = "loop",
      }
      for key, name in pairs(objects) do
        vim.keymap.set({ "x", "o" }, "a" .. key, function()
          select.select_textobject("@" .. name .. ".outer", "textobjects")
        end, { desc = name .. " (dış)" })
        vim.keymap.set({ "x", "o" }, "i" .. key, function()
          select.select_textobject("@" .. name .. ".inner", "textobjects")
        end, { desc = name .. " (iç)" })
      end

      local jumps = { f = "function", c = "class" }
      for key, name in pairs(jumps) do
        vim.keymap.set({ "n", "x", "o" }, "]" .. key, function()
          move.goto_next_start("@" .. name .. ".outer", "textobjects")
        end, { desc = "Sonraki " .. name })
        vim.keymap.set({ "n", "x", "o" }, "[" .. key, function()
          move.goto_previous_start("@" .. name .. ".outer", "textobjects")
        end, { desc = "Önceki " .. name })
      end
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    opts = { max_lines = 3 },
  },
}
