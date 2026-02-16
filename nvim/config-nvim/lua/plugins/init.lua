return {
  -- Auto detect indentation
  { 'Darazaki/indent-o-matic', opts = {} },

  -- Highlight todo, notes, etc in comments
  {
    'folke/todo-comments.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = true },
  },
}
