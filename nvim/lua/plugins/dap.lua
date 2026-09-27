return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
    "theHamsta/nvim-dap-virtual-text",
    "leoluz/nvim-dap-go",
    "mfussenegger/nvim-dap-python",
  },
  keys = {
    { "<F5>", function() require("dap").continue() end, desc = "Debug: başlat / devam" },
    { "<F10>", function() require("dap").step_over() end, desc = "Debug: sonraki satır" },
    { "<F11>", function() require("dap").step_into() end, desc = "Debug: içine gir" },
    { "<F12>", function() require("dap").step_out() end, desc = "Debug: dışına çık" },
    { "<leader>b", function() require("dap").toggle_breakpoint() end, desc = "Breakpoint koy / kaldır" },
    { "<leader>B", function() require("dap").set_breakpoint(vim.fn.input("Koşul: ")) end, desc = "Koşullu breakpoint" },
    { "<leader>dc", function() require("dap").continue() end, desc = "Başlat / devam" },
    { "<leader>dl", function() require("dap").run_last() end, desc = "Son debug'ı tekrar çalıştır" },
    { "<leader>dq", function() require("dap").terminate() end, desc = "Debug'ı durdur" },
    { "<leader>du", function() require("dapui").toggle() end, desc = "Debug panelleri aç / kapat" },
    { "<leader>de", function() require("dapui").eval() end, mode = { "n", "x" }, desc = "Değeri göster" },
    { "<leader>dt", function()
        if vim.bo.filetype == "go" then require("dap-go").debug_test()
        elseif vim.bo.filetype == "python" then require("dap-python").test_method() end
      end, desc = "İmleçteki testi debug et" },
  },
  config = function()
    local dap, dapui = require("dap"), require("dapui")
    local mason = vim.fn.stdpath("data") .. "/mason"

    dapui.setup()
    require("nvim-dap-virtual-text").setup({})

    -- Debug başlayınca paneller açılsın, bitince kapansın
    dap.listeners.after.event_initialized.dapui = dapui.open
    dap.listeners.before.event_terminated.dapui = dapui.close
    dap.listeners.before.event_exited.dapui = dapui.close

    vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DiagnosticError" })
    vim.fn.sign_define("DapBreakpointCondition", { text = "◆", texthl = "DiagnosticWarn" })
    vim.fn.sign_define("DapStopped", { text = "▶", texthl = "DiagnosticOk", linehl = "Visual" })

    -- Go (delve)
    require("dap-go").setup({ delve = { path = mason .. "/bin/dlv" } })

    -- Python (debugpy)
    require("dap-python").setup(mason .. "/packages/debugpy/venv/bin/python")

    -- JavaScript / TypeScript (Node)
    dap.adapters["pwa-node"] = {
      type = "server",
      host = "localhost",
      port = "${port}",
      executable = {
        command = mason .. "/bin/js-debug-adapter",
        args = { "${port}" },
      },
    }
    for _, ft in ipairs({ "javascript", "typescript", "javascriptreact", "typescriptreact" }) do
      dap.configurations[ft] = {
        {
          type = "pwa-node",
          request = "launch",
          name = "Bu dosyayı çalıştır",
          program = "${file}",
          cwd = "${workspaceFolder}",
          runtimeExecutable = ft:match("^typescript") and "npx" or "node",
          runtimeArgs = ft:match("^typescript") and { "tsx" } or nil,
          sourceMaps = true,
        },
        {
          type = "pwa-node",
          request = "attach",
          name = "Çalışan process'e bağlan (--inspect)",
          processId = require("dap.utils").pick_process,
          cwd = "${workspaceFolder}",
          sourceMaps = true,
        },
      }
    end
  end,
}
