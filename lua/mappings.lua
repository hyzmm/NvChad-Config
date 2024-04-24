require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

map("n", "K", function()
  vim.lsp.buf.hover()
end, { desc = "Hover documentation" })
map("n", "gd", function()
  vim.lsp.buf.definition()
end, { desc = "Go to definition" })
map("n", "gD", function()
  vim.lsp.buf.declaration()
end, { desc = "Go to declaration" })
map("n", "gi", function()
  vim.lsp.buf.implementation()
end, { desc = "Go to implementation" })
map("n", "go", function()
  vim.lsp.buf.type_definition()
end, { desc = "Go to type definition" })
map("n", "gr", function()
  vim.lsp.buf.references()
end, { desc = "Go to reference" })
map("n", "gs", function()
  vim.lsp.buf.signature_help()
end, { desc = "Show function signature" })
map("n", "<F2>", function()
  vim.lsp.buf.rename()
end, { desc = "Rename symbol" })
map("n", "<F3>", function()
  vim.lsp.buf.format { async = true }
end, { desc = "Format file" })
map("x", "<F3>", function()
  vim.lsp.buf.format { async = true }
end, { desc = "Format selection" })
map("n", "<F4>", function()
  vim.lsp.buf.code_action()
end, { desc = "Execute code action" })

if vim.lsp.buf.range_code_action then
  map("x", "<F4>", function()
    vim.lsp.buf.range_code_action()
  end, { desc = "Execute code action" })
else
  map("x", "<F4>", function()
    vim.lsp.buf.code_action()
  end, { desc = "Execute code action" })
end

map("n", "gl", function()
  vim.diagnostic.open_float()
end, { desc = "Show diagnostic" })
map("n", "[d", function()
  vim.diagnostic.goto_prev()
end, { desc = "Previous diagnostic" })
map("n", "]d", function()
  vim.diagnostic.goto_next()
end, { desc = "Next diagnostic" })

map("n", "<F5>", function()
  require("dap").continue()
end)
map("n", "<Leader>r", function()
  local overseer = require "overseer"
  local tasks = overseer.list_tasks { recent_first = true }
  if vim.tbl_isempty(tasks) then
    overseer.run_template { name = "cargo run" }
  else
    overseer.run_action(tasks[1], "restart")
  end
end, { desc = "Cargo run" })
map("n", "<F10>", function()
  require("dap").step_over()
end)
map("n", "<F11>", function()
  require("dap").step_into()
end)
map("n", "<F12>", function()
  require("dap").step_out()
end)
map("n", "<Leader>b", function()
  require("dap").toggle_breakpoint()
end)
map("n", "<Leader>B", function()
  require("dap").set_breakpoint()
end)
map("n", "<Leader>lp", function()
  require("dap").set_breakpoint(nil, nil, vim.fn.input "Log point message: ")
end)
map("n", "<Leader>dr", function()
  require("dap").repl.open()
end)
map("n", "<Leader>dl", function()
  require("dap").run_last()
end)
map({ "n", "v" }, "<Leader>dh", function()
  require("dap.ui.widgets").hover()
end)
map({ "n", "v" }, "<Leader>dp", function()
  require("dap.ui.widgets").preview()
end)
map("n", "<Leader>df", function()
  local widgets = require "dap.ui.widgets"
  widgets.centered_float(widgets.frames)
end)
map("n", "<Leader>ds", function()
  local widgets = require "dap.ui.widgets"
  widgets.centered_float(widgets.scopes)
end)

-- Telescope
local builtin = require "telescope.builtin"
map("n", "<Leader>fs", function()
  builtin.lsp_document_symbols()
end)
map("n", "<Leader>fS", function()
  builtin.lsp_workspace_symbols()
end)
