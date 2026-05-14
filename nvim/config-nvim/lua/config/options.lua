vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.g.have_nerd_font = true

vim.o.termguicolors = true

vim.o.number = true
vim.o.mouse = 'a'
vim.o.showmode = true
vim.o.breakindent = true
vim.o.undofile = true

-- Default to 2 spaces instead of tabs
-- NOTE: The plugin indent-o-matic resets these
vim.opt.tabstop = 2
vim.opt.softtabstop = 0
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- Try to be smart about intending
vim.opt.smartindent = true
vim.opt.colorcolumn = '80'

-- Spell check
vim.opt.spelllang = 'en_us'
vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250

-- Decrease mapped sequence wait time
vim.o.timeoutlen = 300

-- Open splits where I expect them to be
vim.o.splitright = true
vim.o.splitbelow = true

-- Show some invisible characters in certain situations
vim.o.list = true
vim.opt.listchars = {
  tab = '» ',
  trail = '·',
  nbsp = '␣',
  --
  precedes = '<',
  extends = '>',
}

local function get_highlight_info_at_cursor()
  -- Get the current line and cursor position
  local line = vim.api.nvim_get_current_line()
  local col = vim.fn.col '.' - 1

  -- Get the character at the cursor position
  local char = line:sub(col + 1, col + 1)

  -- Get a list of all highlight groups
  local highlight_groups = vim.fn.filter(vim.fn.getcompletion('', 'highlight'), function(hl) return hl ~= '' end)

  -- Iterate through highlight groups and check if the character has this highlight group
  for _, hl in ipairs(highlight_groups) do
    -- Get the syntax item associated with the highlight group
    local syntax_item = vim.api.nvim_get_syn_highlight(syntax_group)

    if syntax_item ~= nil then
      -- Check if the current character has this syntax item
      if syntax_item.line:sub(col + 1, col + 1) == char then
        -- Get the highlight info for this highlight group
        local highlight_info = vim.fn.synattr(syntax_item.name, 'cterm')
        print(string.format('Highlight Group: %s\nAttributes: %s', hl, vim.inspect(highlight_info)))
        return
      end
    end
  end

  -- If no highlight group is found for the character under the cursor
  print 'No highlight information found for the character under the cursor.'
end

-- Bind the function to a key (e.g., F2)
vim.api.nvim_set_keymap('n', '<F2>', ':lua get_highlight_info_at_cursor()<CR>', { noremap = true, silent = true })

-- Allow some markdown characters to be hidden
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'markdown' },
  callback = function() vim.opt_local.conceallevel = 1 end,
})

-- Preview substitutions live, as you type!
vim.o.inccommand = 'split'

-- Show which line your cursor is on
vim.o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 8

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- NOTE: Do I like this?
vim.o.confirm = true

-- Diagnostic Config
-- See :help vim.diagnostic.Opts
vim.diagnostic.config {
  update_in_insert = false,
  severity_sort = true,
  float = { border = 'rounded', source = 'if_many' },
  underline = { severity = vim.diagnostic.severity.ERROR },

  -- Can switch between these as you prefer
  virtual_text = true, -- Text shows up at the end of the line
  virtual_lines = false, -- Teest shows up underneath the line, with virtual lines

  -- Auto open the float, so you can easily read the errors when jumping with `[d` and `]d`
  jump = { float = true },
}
