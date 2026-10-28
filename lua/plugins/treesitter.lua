
-- Customize Treesitter

---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = {
      "lua",
      "vim",
      "verilog", -- SystemVerilog (gmlarumbe grammar, mapped to .sv files)
      -- add more arguments for adding more treesitter parsers
    },
  },
}
