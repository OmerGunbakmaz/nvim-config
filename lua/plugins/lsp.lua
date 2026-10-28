
-- 1️⃣ Mevcut LSP config
return {
  {
    "AstroNvim/astrolsp",
    opts = {
      config = {
        clangd = {
          capabilities = {
            textDocument = {
              completion = {
                completionItem = {
                  snippetSupport = false,
                },
              },
            },
          },
        },
      },
    },
  },

  -- 2️⃣ Signature plugin’i
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function()
      require("lsp_signature").setup({
        bind = true,
        floating_window = true,
        hint_enable = true,
        handler_opts = { border = "rounded" },
      })
    end,
  },
}
