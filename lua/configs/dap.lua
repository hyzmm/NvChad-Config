local dap, dapui = require "dap", require "dapui"
dap.listeners.before.attach.dapui_config = function()
  dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
  dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
  dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
  dapui.close()
end

-- command = vim.env.HOME .. "/.local/share/nvim/mason/packages/codelldb",
dap.adapters.cargo = {
  type = "executable",
  command = vim.env.HOME .. "/.cargo/bin/cargo",
  args = { "run" },
  name = "Cargo run",
  mode = "terminal",
  console = "internalTerminal",
}
dap.adapters.lldb = {
  type = "executable",
  command = vim.env.HOME .. "/.local/share/nvim/mason/packages/codelldb",
  name = "lldb",
}

dap.configurations.rust = {
  {
    name = "Cargo",
    type = "cargo",
    request = "launch",
    console = "internalTerminal",
    mode = "terminal",
    -- program = "${fileDirname}",
  },
  {
    name = "Launch",
    type = "lldb",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
    args = {},

    -- 💀
    -- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
    --
    --    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
    --
    -- Otherwise you might get the following error:
    --
    --    Error on launch: Failed to attach to the target process
    --
    -- But you should be aware of the implications:
    -- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
    -- runInTerminal = false,
  },
}
