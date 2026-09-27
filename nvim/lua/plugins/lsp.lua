-- Mason'ın otomatik kurup açacağı language server'lar
local servers = {
  "vtsls",         -- TypeScript / JavaScript / TSX
  "basedpyright",  -- Python (tip kontrolü, go-to-definition)
  "ruff",          -- Python (lint + format)
  "gopls",         -- Go
  "lua_ls",        -- Lua (nvim config)
  "jsonls",        -- JSON (package.json, tsconfig şemaları)
  "yamlls",        -- YAML
  "html",
  "cssls",
  "bashls",
}

return {
  {
    "mason-org/mason.nvim",
    opts = { ui = { border = "rounded" } },
  },
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      "mason-org/mason.nvim",
      "neovim/nvim-lspconfig",
      "b0o/SchemaStore.nvim",
      "saghen/blink.cmp",
    },
    config = function()
      vim.lsp.config("*", {
        capabilities = require("blink.cmp").get_lsp_capabilities(),
      })

      local schemastore = require("schemastore")
      vim.lsp.config("jsonls", {
        settings = { json = { schemas = schemastore.json.schemas(), validate = { enable = true } } },
      })
      vim.lsp.config("yamlls", {
        settings = { yaml = { schemaStore = { enable = false, url = "" }, schemas = schemastore.yaml.schemas() } },
      })

      -- Python: tip kontrolü basedpyright'ta, lint/format ruff'ta
      vim.lsp.config("basedpyright", {
        settings = { basedpyright = { analysis = { typeCheckingMode = "standard" } } },
      })

      require("mason-lspconfig").setup({
        ensure_installed = servers,
        automatic_enable = true,
      })

      vim.diagnostic.config({
        severity_sort = true,
        float = { border = "rounded", source = true },
        virtual_text = { spacing = 2, prefix = "●" },
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "E",
            [vim.diagnostic.severity.WARN] = "W",
            [vim.diagnostic.severity.INFO] = "I",
            [vim.diagnostic.severity.HINT] = "H",
          },
        },
      })

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local builtin = require("telescope.builtin")
          local function map(keys, fn, desc, mode)
            vim.keymap.set(mode or "n", keys, fn, { buffer = args.buf, desc = desc })
          end

          map("gd", builtin.lsp_definitions, "Tanıma git")
          map("gD", vim.lsp.buf.declaration, "Deklarasyona git")
          map("gr", builtin.lsp_references, "Kullanıldığı yerler")
          map("gI", builtin.lsp_implementations, "Implementasyona git")
          map("gy", builtin.lsp_type_definitions, "Tip tanımına git")
          map("K", function() vim.lsp.buf.hover({ border = "rounded" }) end, "Dokümantasyon")
          map("<leader>ca", vim.lsp.buf.code_action, "Code action", { "n", "x" })
          map("<leader>ds", builtin.lsp_document_symbols, "Dosyadaki semboller")
          map("<leader>ws", builtin.lsp_dynamic_workspace_symbols, "Projedeki semboller")
          map("<leader>e", vim.diagnostic.open_float, "Hatayı göster")
          map("<leader>pd", builtin.diagnostics, "Tüm hatalar")
          map("<C-k>", function() vim.lsp.buf.signature_help({ border = "rounded" }) end, "Parametre bilgisi", "i")
        end,
      })
    end,
  },
  {
    "saghen/blink.cmp",
    version = "1.*",
    opts = {
      keymap = { preset = "default" },
      appearance = { nerd_font_variant = "mono" },
      completion = {
        documentation = { auto_show = true, auto_show_delay_ms = 200, window = { border = "rounded" } },
        menu = { border = "rounded" },
      },
      signature = { enabled = true, window = { border = "rounded" } },
      sources = {
        default = { "lazydev", "lsp", "path", "snippets", "buffer" },
        providers = {
          lazydev = { name = "LazyDev", module = "lazydev.integrations.blink", score_offset = 100 },
        },
      },
      fuzzy = { implementation = "prefer_rust_with_warning" },
    },
  },
  {
    -- nvim config'i yazarken `vim.` API'sini tanısın
    "folke/lazydev.nvim",
    ft = "lua",
    opts = { library = { { path = "${3rd}/luv/library", words = { "vim%.uv" } } } },
  },
}
