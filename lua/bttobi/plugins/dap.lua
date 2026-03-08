return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "mxsdev/nvim-dap-vscode-js",
    "nvim-neotest/nvim-nio",
  },
  config = function()
    local dap = require "dap"
    local dapui = require "dapui"

    dap.adapters["pwa-node"] = {
      type = "server",
      host = "localhost",
      port = "${port}",
      executable = {
        command = "node",
        args = { "/path/to/js-debug/src/dapDebugServer.js", "${port}" },
      },
    }

    for _, adapter in pairs { "pwa-node", "pwa-chrome" } do
      dap.adapters[adapter] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
          command = "js-debug-adapter",
          args = { "${port}" },
        },
      }
    end

    local enter_launch_url = function()
      local co = coroutine.running()
      return coroutine.create(function()
        vim.ui.input({ prompt = "Enter URL: ", default = "http://localhost:" }, function(url)
          if url == nil or url == "" then
            return
          else
            coroutine.resume(co, url)
          end
        end)
      end)
    end

    for _, language in ipairs { "typescript", "javascript", "typescriptreact", "javascriptreact", "vue" } do
      dap.configurations[language] = {
        {
          type = "pwa-node",
          request = "launch",
          name = "Launch file using Node.js (nvim-dap)",
          program = "${file}",
          cwd = "${workspaceFolder}",
        },
        {
          type = "pwa-node",
          request = "attach",
          name = "Attach to process using Node.js (nvim-dap)",
          processId = require("dap.utils").pick_process,
          cwd = "${workspaceFolder}",
        },
        -- requires ts-node to be installed globally or locally
        {
          type = "pwa-node",
          request = "launch",
          name = "Launch file using Node.js with ts-node/register (nvim-dap)",
          program = "${file}",
          cwd = "${workspaceFolder}",
          runtimeArgs = { "-r", "ts-node/register" },
        },
        {
          type = "pwa-chrome",
          request = "launch",
          name = "Launch Chrome (nvim-dap)",
          url = enter_launch_url,
          webRoot = "${workspaceFolder}",
          sourceMaps = true,
        },
        {
          type = "pwa-msedge",
          request = "launch",
          name = "Launch Edge (nvim-dap)",
          url = enter_launch_url,
          webRoot = "${workspaceFolder}",
          sourceMaps = true,
        },
      }
    end

    dapui.setup()
  end,
}
