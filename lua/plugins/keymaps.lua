return {
  {
    "AstroNvim/astrocore",
    opts = {
      mappings = {
        n = {
          -- Undo/Redo
          ["<C-z>"] = { "u", desc = "Undo" },

          -- Copy/Paste
          ["<C-v>"] = { '"+p', desc = "Paste" },

          -- Delete without yank
          ["dd"] = { '"_dd', desc = "Delete without yank" },
          ["d"] = { '"_d', desc = "Delete without yank" },

          -- File Explorer (Ctrl+Q)
          ["<C-q>"] = { "<cmd>Neotree toggle<cr>", desc = "Toggle Explorer" },

          -- Duplicate line (Ctrl+D)
          ["<C-d>"] = { "yyp", desc = "Duplicate line" },

          -- Tab switching (Ctrl+1-9)
          -- Tab switching (Alt+1-9)
            ["<C-1>"] = { "<cmd>lua vim.api.nvim_set_current_buf(vim.fn.getbufinfo({buflisted=1})[1].bufnr)<cr>", desc = "Go to buffer 1" },
            ["<C-2>"] = { "<cmd>lua vim.api.nvim_set_current_buf(vim.fn.getbufinfo({buflisted=1})[2].bufnr)<cr>", desc = "Go to buffer 2" },
            ["<C-3>"] = { "<cmd>lua vim.api.nvim_set_current_buf(vim.fn.getbufinfo({buflisted=1})[3].bufnr)<cr>", desc = "Go to buffer 3" },
            ["<C-4>"] = { "<cmd>lua vim.api.nvim_set_current_buf(vim.fn.getbufinfo({buflisted=1})[4].bufnr)<cr>", desc = "Go to buffer 4" },
            ["<C-5>"] = { "<cmd>lua vim.api.nvim_set_current_buf(vim.fn.getbufinfo({buflisted=1})[5].bufnr)<cr>", desc = "Go to buffer 5" },       
            ["<C-6>"] = { "<cmd>lua vim.api.nvim_set_current_buf(vim.fn.getbufinfo({buflisted=1})[6].bufnr)<cr>", desc = "Go to buffer 6" },
            ["<C-7>"] = { "<cmd>lua vim.api.nvim_set_current_buf(vim.fn.getbufinfo({buflisted=1})[7].bufnr)<cr>", desc = "Go to buffer 7" },
            ["<C-8>"] = { "<cmd>lua vim.api.nvim_set_current_buf(vim.fn.getbufinfo({buflisted=1})[8].bufnr)<cr>", desc = "Go to buffer 8" },
            ["<C-9>"] = { "<cmd>lua vim.api.nvim_set_current_buf(vim.fn.getbufinfo({buflisted=1})[9].bufnr)<cr>", desc = "Go to buffer 9" },
                      
        },
        v = {
          -- Copy
           ["<C-c>"] = { '"+y', desc = "Copy" },

          -- Delete without yank
          ["d"] = { '"_d', desc = "Delete without yank" },

          -- Duplicate selection (Ctrl+D)
          ["<C-d>"] = { "y`>p", desc = "Duplicate selection" },
        },
        i = {
          ["<Esc>"] = { "<Esc>", desc = "Stay in insert mode" },
          ["`"]     = { "<C-\\><C-n>", desc = "Exit to normal mode" },
          ["<C-z>"] = { "<C-o>u", desc = "Undo" },
          ["<C-v>"] = { '<C-r>+', desc = "Paste" },
        },
      },
    },
  },
}
