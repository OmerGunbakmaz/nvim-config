-- Dizin ağacı sabit kalsın: buffer değiştirince ağaç o dosyaya atlamasın,
-- kök dizin (cwd) de kendiliğinden değişmesin; sadece :cd ile değişsin.
---@type LazySpec
return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        follow_current_file = { enabled = false },
        bind_to_cwd = true, -- :cd yapınca ağaç da oraya gitsin
        window = {
          mappings = {
            -- çift tık: klasörü aç/kapat, dosyayı aç (kök değişmez)
            -- klasörün içine girmek için "." , çıkmak için <BS>
            ["<2-LeftMouse>"] = "open",
          },
        },
      },
      buffers = {
        follow_current_file = { enabled = false },
      },
    },
  },
  {
    "AstroNvim/astrocore",
    opts = {
      rooter = {
        enabled = false, -- dosya açınca cwd'yi proje köküne taşıma
        autochdir = false,
      },
    },
  },
}
