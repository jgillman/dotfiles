-- Remove current highlighted search
vim.keymap.set('n', '<Esc>', '<Cmd>nohlsearch<CR>')

vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Delete active buffer
vim.keymap.set('n', '<leader>c', '<Cmd>bprevious | bdelete #<CR>', { desc = 'Delete active [B]uffer' })

-- Toggle Paste mode
vim.keymap.set('n', '<leader>tp', '<Cmd>set invpaste | set paste?<CR>', { desc = '[T]oggle [P]aste mode' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Copy, Cut, and Paste from system clipboard
-- NOTE: This seems to be needed for Neovide
vim.keymap.set('v', '<D-c>', '"+y', { desc = 'Copy to system clipboard' })
vim.keymap.set('v', '<D-x>', '"+x', { desc = 'Cut to system clipboard' })
vim.keymap.set('n', '<D-v>', '"+gP', { desc = 'Paste from system clipboard' })
vim.keymap.set('i', '<D-v>', '<C-o>"+P', { desc = 'Paste from system clipboard' })
