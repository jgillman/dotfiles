-- Why are these even standard?
vim.keymap.set('', 'g?', '<Nop>')
vim.keymap.set('', 'gs', '<Nop>')

-- Sane movement with wrap turned on
vim.keymap.set({ 'n', 'v' }, 'j', 'gj')
vim.keymap.set({ 'n', 'v' }, 'k', 'gk')

-- Default to searching with very magic mode
vim.keymap.set({ 'n', 'v' }, '/', '/\\v')

-- Remove current highlighted search
vim.keymap.set('n', '<Esc>', '<Cmd>nohlsearch<CR>')

vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Delete active buffer
vim.keymap.set('n', '<leader>c', '<Cmd>bprevious | bdelete #<CR>', { desc = 'Delete active [B]uffer' })

-- Toggle Paste mode
vim.keymap.set('n', '<leader>tp', '<Cmd>set invpaste | set paste?<CR>', { desc = '[T]oggle [P]aste mode' })

-- Toggle wrap
vim.keymap.set('n', '<leader>tw', '<Cmd>set wrap! | set wrap?<CR>', { desc = '[T]oggle [W]rap mode' })

-- Toggle writing mode: soft wrap prose at word boundaries instead of mid-word.
-- Window-local, so it only affects the window it was toggled in.
local writing_mode_options = {
  wrap = true,
  linebreak = true,
}

local function toggle_writing_mode()
  local saved = vim.w.writing_mode_saved

  if saved then
    for option, value in pairs(saved) do
      vim.wo[option] = value
    end
    vim.w.writing_mode_saved = nil
    vim.notify('Writing mode off')
    return
  end

  saved = {}
  for option, value in pairs(writing_mode_options) do
    saved[option] = vim.wo[option]
    vim.wo[option] = value
  end
  vim.w.writing_mode_saved = saved
  vim.notify('Writing mode on')
end

vim.keymap.set('n', '<leader>tW', toggle_writing_mode, { desc = '[T]oggle [W]riting mode' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.keymap.set('n', '<leader>b', '<cmd>lua MiniFiles.open()<cr>', { desc = '[B]rowse files' })

vim.keymap.set('i', '<M-BS>', '<C-w>', { desc = 'Delete word backwards' })
