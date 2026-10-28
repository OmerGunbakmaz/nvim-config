return {
  "akinsho/toggleterm.nvim",
  opts = {
    open_mapping = [[<C-t>]],
    toggle_mapping = [[<C-t>]],
    direction = "float",
    float_opts = {
      border = "curved",
      width = vim.o.columns,
    },
  },
}
