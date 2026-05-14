-- Enable spellcheck, wrap, and linebreak for certain filetypes
vim.api.nvim_create_autocmd('FileType', {
  desc = 'Enable spellcheck for certain filetypes',
  pattern = { 'gitcommit', 'mail', 'markdown' },
  command = 'setlocal linebreak spell wrap',
})

-- Restore cursor position when opening a buffer
vim.api.nvim_create_autocmd('BufReadPost', {
  desc = 'Auto jump to last position',
  group = vim.api.nvim_create_augroup('auto-last-position', { clear = true }),
  callback = function(args)
    local position = vim.api.nvim_buf_get_mark(args.buf, [["]])
    local winid = vim.fn.bufwinid(args.buf)
    pcall(vim.api.nvim_win_set_cursor, winid, position)
  end,
})

-- Highlight when yanking (copying) text
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function() vim.hl.on_yank() end,
})

-- Enable spellcheck, wrap, and linebreak for certain filetypes
vim.api.nvim_create_autocmd('FileType', {
  desc = 'Enable spellcheck for certain filetypes',
  pattern = { 'gitcommit', 'mail', 'markdown' },
  command = 'setlocal linebreak spell wrap',
})

-- TODO: Change active directory to closest git root if available
-- vim.api.nvim_create_augroup('BufRead', {
--   desc = 'Change active directory to closest git root when available',
--   callback = function ()
--   vim.notify( 'asdf', vim.log.levels.INFO)
--     vim.cmd.lcd <current path via `git root` shell command>
--   end
-- })
