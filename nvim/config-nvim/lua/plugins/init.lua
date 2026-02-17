return {
  -- Auto detect indentation
  { 'Darazaki/indent-o-matic', opts = {} },

  -- Toggle background transparency
  { 'xiyaowong/transparent.nvim' },

  -- Highlight todo, notes, etc in comments
  {
    'folke/todo-comments.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = true },
  },
}
