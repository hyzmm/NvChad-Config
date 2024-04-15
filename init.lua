vim.g.base46_cache = vim.fn.stdpath "data" .. "/nvchad/base46/"
vim.g.mapleader = " "
vim.wo.relativenumber = true

if vim.g.neovide then
  vim.g.neovide_transparency = 0.0
  vim.g.transparency = 0.8
  vim.g.neovide_transparency = 0;
  vim.g.neovide_window_blurred = true;
  vim.g.neovide_floating_blur_amount_x = 2.0;
  vim.g.neovide_floating_blur_amount_y = 2.0;
  vim.g.neovide_transparency = 0.8;
  vim.g.neovide_hide_mouse_when_typing = true;
  vim.g.neovide_refresh_rate = 60;
  vim.g.neovide_remember_window_size = true;
  vim.g.neovide_input_macos_alt_is_meta = true;

  vim.g.neovide_cursor_animation_length = 0.1;
  vim.g.neovide_cursor_trail_size = 0.8;
  vim.g.neovide_cursor_animate_in_insert_mode = true;
  vim.g.neovide_cursor_animate_command_line = true;
  vim.g.neovide_cursor_smooth_blink = true;
  vim.g.neovide_cursor_vfx_mode = "railgun";
  vim.g.neovide_cursor_vfx_particle_lifetime = 1.2;
end

local function set_ime(args)
    if args.event:match("Enter$") then
        vim.g.neovide_input_ime = true
    else
        vim.g.neovide_input_ime = false
    end
end

local ime_input = vim.api.nvim_create_augroup("ime_input", { clear = true })

vim.api.nvim_create_autocmd({ "InsertEnter", "InsertLeave" }, {
    group = ime_input,
    pattern = "*",
    callback = set_ime
})

vim.api.nvim_create_autocmd({ "CmdlineEnter", "CmdlineLeave" }, {
    group = ime_input,
    pattern = "[/\\?]",
    callback = set_ime
})

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
    local repo = "https://github.com/folke/lazy.nvim.git"
    vim.fn.system {"git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath}
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({{
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
    config = function()
        require "options"
    end
}, {
    import = "plugins"
}}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "nvchad.autocmds"

vim.schedule(function()
    require "mappings"
end)
