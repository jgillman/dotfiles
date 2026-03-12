return {
  -- Auto detect indentation
  { 'Darazaki/indent-o-matic', opts = {} },

  -- Toggle background transparency
  {
    'xiyaowong/transparent.nvim',
    lazy = true,
    keys = {
      { '<leader>tt', '<cmd>TransparentToggle<cr>', desc = '[T]oggle [T]ransparency' },
    },
  },

  -- Fun
  { 'eandrju/cellular-automaton.nvim' },

  -- Highlight todo, notes, etc in comments
  {
    'folke/todo-comments.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = true },
  },

  {
    'catgoose/nvim-colorizer.lua',
    event = 'BufReadPre',
    opts = {
      -- Don't highlight color names like Blue or red.
      user_default_options = {
        names = false,
      },
      virtualtext_inline = true,
      filetypes = {
        '*', -- Highlight all files, but customize some others.
        css = {
          -- Enable names, RGB, RGBA, RRGGBB, RRGGBBAA, AARRGGBB, rgb_fn, hsl_fn, oklch_fn
          css = true,
        },
      },
    },
    keys = {
      { '<leader>tc', '<cmd>ColorizerToggle<cr>', desc = '[T]oggle [C]olorizer' },
    },
  },
}
