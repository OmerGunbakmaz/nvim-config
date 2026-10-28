-- This file simply bootstraps the installation of Lazy.nvim and then calls other files for execution
-- This file doesn't necessarily need to be touched, BE CAUTIOUS editing this file and proceed at your own risk.
local lazypath = vim.env.LAZY or vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not (vim.env.LAZY or (vim.uv or vim.loop).fs_stat(lazypath)) then
  -- stylua: ignore
  local result = vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
  if vim.v.shell_error ~= 0 then
    -- stylua: ignore
    vim.api.nvim_echo({ { ("Error cloning lazy.nvim:\n%s\n"):format(result), "ErrorMsg" }, { "Press any key to exit...", "MoreMsg" } }, true, {})
    vim.fn.getchar()
    vim.cmd.quit()
  end
end

vim.opt.rtp:prepend(lazypath)
vim.opt.clipboard = "unnamedplus"

-- validate that lazy is available
if not pcall(require, "lazy") then
  -- stylua: ignore
  vim.api.nvim_echo({ { ("Unable to load lazy from: %s\n"):format(lazypath), "ErrorMsg" }, { "Press any key to exit...", "MoreMsg" } }, true, {})
  vim.fn.getchar()
  vim.cmd.quit()
end

vim.cmd("iab mainab int main(int ac, const char *av[]) {}")
vim.cmd("iab incab #include <>")

vim.keymap.set("n", "<A-Up>", ":m-2<CR>==")
vim.keymap.set("n", "<A-Down>", ":m+1<CR>==")
vim.opt.relativenumber = false

-- Fonksiyon: boş satırdaysa üst satırın sonuna git, değilse sol ok
function _G.smart_left()
    local line = vim.api.nvim_get_current_line()
    local mode = vim.api.nvim_get_mode().mode

    if line == "" then
        if mode == "i" then
            -- Insert modda: önce normal moda geç, hareket et, tekrar insert mod
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>k$a", true, false, true), "n", false)
        else
            -- Normal veya visual modda: üst satırın sonuna git
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("k$", true, false, true), "n", false)
        end
    else
        -- Normal sol ok davranışı
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Left>", true, false, true), "n", false)
    end
end

-- Keymap: her mod için sol ok
for _, mode in ipairs({"n","i","v"}) do
    vim.keymap.set(mode, "<Left>", "<cmd>lua _G.smart_left()<CR>", { noremap = true, silent = true })
end

-- Visual mode
vim.keymap.set("v", "<A-Up>", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "<A-Down>", ":m '>+1<CR>gv=gv")

require "lazy_setup"
require "polish"

vim.g.neovide_fullscreen = false

vim.opt.number = true
vim.opt.relativenumber = false
