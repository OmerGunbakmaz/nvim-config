if vim.g.neovide then
  vim.g.neovide_fullscreen = true

  -- Pencere başlığı: dosya varsa adı, yoksa (dashboard vb.) "Neovide" — "[Scratch]" yerine
  vim.o.title = true
  vim.o.titlestring = "%{&buftype ==# '' && expand('%:t') !=# '' ? expand('%:t') . ' - Neovide' : 'Neovide'}"

  -- Dosya/dizin verilmeden açılınca ~/workspace'te başla
  if vim.fn.argc() == 0 then
    vim.cmd.cd(vim.fn.expand "~/workspace")
  end

  -- :q / :wq / :x pencereyi değil sadece aktif dosyayı kapatsın (Neovide açık kalsın).
  -- Split varsa normal :q gibi split'i kapatır. Neovide'dan çıkmak için :qa
  local function file_windows()
    local n = 0
    for _, w in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
      local b = vim.api.nvim_win_get_buf(w)
      if vim.api.nvim_win_get_config(w).relative == "" and vim.bo[b].buftype == "" then n = n + 1 end
    end
    return n
  end

  vim.api.nvim_create_user_command("CloseBuf", function(o)
    if vim.bo.buftype ~= "" or file_windows() > 1 then
      vim.cmd(o.bang and "quit!" or "quit")
    else
      require("astrocore.buffer").close(0, o.bang)
    end
  end, { bang = true })

  local function abbrev(from, to)
    vim.cmd(("cnoreabbrev <expr> %s (getcmdtype() == ':' && getcmdline() ==# '%s') ? '%s' : '%s'"):format(from, from, to, from))
  end
  abbrev("q", "CloseBuf")
  abbrev("wq", "w <bar> CloseBuf")
  abbrev("x", "update <bar> CloseBuf")

  -- Güvenlik ağı: hangi yoldan gelirse gelsin (<Leader>q, neo-tree, dashboard, geçmişten :q ...)
  -- son pencere kapanacaksa önce yedek bir pencere aç, böylece Neovide kapanmaz.
  -- :qa yine çıkar (yedek pencere boş olduğu için engel olmaz).
  local sidebars = { ["neo-tree"] = true, aerial = true }
  vim.api.nvim_create_autocmd("QuitPre", {
    callback = function()
      if #vim.api.nvim_list_tabpages() > 1 then return end
      local cur = vim.api.nvim_get_current_win()
      for _, w in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
        if w ~= cur and vim.api.nvim_win_get_config(w).relative == ""
          and not sidebars[vim.bo[vim.api.nvim_win_get_buf(w)].filetype] then
          return -- başka normal pencere var, normal :q zaten çıkmaz
        end
      end

      local closing = vim.api.nvim_get_current_buf()
      local alt
      for _, b in ipairs(vim.fn.getbufinfo { buflisted = 1 }) do
        if b.bufnr ~= closing and (not alt or b.lastused > alt.lastused) then alt = b end
      end

      if sidebars[vim.bo[closing].filetype] then
        vim.cmd "noautocmd wincmd p"
      end
      vim.cmd "noautocmd split"
      local spare = vim.api.nvim_get_current_win()
      if alt then
        vim.api.nvim_win_set_buf(spare, alt.bufnr)
      else
        vim.cmd "noautocmd enew"
      end
      vim.api.nvim_set_current_win(cur)

      vim.schedule(function()
        if vim.api.nvim_win_is_valid(cur) then
          -- quit iptal oldu (ör. kaydedilmemiş dosya): yedek pencereyi geri kapat
          if vim.api.nvim_win_is_valid(spare) then pcall(vim.api.nvim_win_close, spare, false) end
        elseif vim.api.nvim_buf_is_valid(closing) and vim.bo[closing].buflisted then
          -- pencere kapandı: dosyayı sekmelerden de kaldır
          pcall(require("astrocore.buffer").close, closing)
        end
      end)
    end,
  })
end

-- Bir dosya açılınca, açılışta kalan boş "Untitled" buffer'ı kapat
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function(args)
    vim.schedule(function()
      for _, b in ipairs(vim.api.nvim_list_bufs()) do
        if
          b ~= args.buf
          and vim.api.nvim_buf_is_valid(b)
          and vim.bo[b].buflisted
          and vim.bo[b].buftype == ""
          and not vim.bo[b].modified
          and vim.api.nvim_buf_get_name(b) == ""
          and vim.api.nvim_buf_line_count(b) == 1
          and vim.api.nvim_buf_get_lines(b, 0, 1, false)[1] == ""
          and vim.fn.bufwinid(b) == -1
        then
          pcall(vim.api.nvim_buf_delete, b, {})
        end
      end
    end)
  end,
})

return {}
