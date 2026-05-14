return {
  -- 'obsidian-nvim/obsidian.nvim',
  dir = '~/Code/obsidian.nvim',
  version = '*', -- use latest release, remove to use latest commit
  ft = 'markdown',
  lazy = false, -- don't lazy load so we can use it on start screen
  keys = {
    { '<leader>o', '<cmd>Obsidian<cr>', desc = '[O]bsidian menu' },
  },
  ---@module 'obsidian'
  ---@type obsidian.config
  opts = {
    legacy_commands = false, -- this will be removed in the next major release
    workspaces = {
      { name = 'personal', path = '~/Sync/notes/personal' },
      { name = 'work', path = '~/Sync/notes/goldbelly' },
    },
    daily_notes = {
      folder = 'daily-notes',
      default_tags = {},
      template = 'templates/daily-note.md',
      workdays_only = false,
    },
    frontmatter = { enabled = false },
    unique_note = {
      format = 'YYYY.MM.DD.HHmm -',
      folder = 'capture',
      template = 'templates/new-capture-note',
    },
  },
}
