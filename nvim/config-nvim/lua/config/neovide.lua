-- Config specifically for Neovide
if vim.g.neovide then
  -- defined in config.toml
  -- vim.o.guifont = 'VictorMono Nerd Font,Victor Mono:h14'
  vim.g.neovide_scale_factor = 1.0
  vim.g.neovide_hide_mouse_when_typing = true
  vim.g.neovide_input_macos_option_key_is_meta = 'only_left'

  -- Copy and Paste
  local function save() vim.cmd.write() end
  local function copy() vim.cmd [[normal! "+y]] end
  local function cut() vim.cmd [[normal! "+x]] end
  local function paste() vim.api.nvim_paste(vim.fn.getreg '+', true, -1) end
  vim.keymap.set({ 'n', 'i', 'v' }, '<D-s>', save, { desc = 'Save' })
  vim.keymap.set('v', '<D-c>', copy, { silent = true, desc = 'Copy' })
  vim.keymap.set('v', '<D-x>', cut, { silent = true, desc = 'Cut' })
  vim.keymap.set({ 'n', 'i', 'v', 'c', 't' }, '<D-v>', paste, { silent = true, desc = 'Paste' })

  -- New Tab
  -- local function newtab()
  --   -- TODO: check to see if current buffer is the "start page" and close it if it is
  --   vim.cmd.tabnew()
  -- end
  -- vim.keymap.set('', '<D-t>', newtab, { desc = 'New Tab' })

  -- Allow for scaling up and down with Cmd + minus or plus (equals)
  -- Reset size with Cmd + 0
  local change_scale_factor = function(delta) vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta end
  vim.keymap.set('n', '<D-=>', function() change_scale_factor(1.25) end)
  vim.keymap.set('n', '<D-->', function() change_scale_factor(1 / 1.25) end)
  vim.keymap.set('n', '<D-0>', '<cmd>lua vim.g.neovide_scale_factor = 1.0<cr>')

  vim.g.neovide_window_blurred = true
  vim.g.neovide_opacity = 0.8

  local change_transparency = function(delta)
    local next_value = (vim.g.neovide_opacity or 1) + delta
    vim.g.neovide_opacity = math.min(1, math.max(0, next_value))
  end

  vim.keymap.set({ 'n', 'v', 'o' }, '<D-]>', function() change_transparency(0.05) end, { desc = 'Increase Neovide opacity' })
  vim.keymap.set({ 'n', 'v', 'o' }, '<D-[>', function() change_transparency(-0.05) end, { desc = 'Decrease Neovide opacity' })
end
