return {
  {
    'nvim-mini/mini.nvim',
    version = false,
    config = function()
      -- -----------------------------------------------
      -- Text editing
      -- -----------------------------------------------
      require('mini.ai').setup { n_lines = 500 }
      require('mini.pairs').setup()
      require('mini.splitjoin').setup()
      -- Changes 's' to Nop, use `cl` instead
      require('mini.surround').setup()

      local miniclue = require 'mini.clue'
      require('mini.clue').setup {
        -- Clue window settings
        window = {
          -- Floating window config
          config = {
            width = 'auto',
            border = 'rounded',
          },
          -- Delay before showing clue window
          delay = 400,
        },

        triggers = {
          { mode = { 'n', 'x' }, keys = '<Leader>' },
          { mode = { 'n', 'x' }, keys = 'g' },
          { mode = { 'n', 'x' }, keys = 's' },
          { mode = { 'n', 'x' }, keys = 'z' },

          { mode = 'n', keys = '[' },
          { mode = 'n', keys = ']' },

          -- Completions
          { mode = 'i', keys = '<C-x>' },

          -- Marks
          { mode = { 'n', 'x' }, keys = "'" },
          { mode = { 'n', 'x' }, keys = "g'" },
          { mode = { 'n', 'x' }, keys = '`' },
          { mode = { 'n', 'x' }, keys = 'g`' },

          -- Registers
          { mode = { 'n', 'x' }, keys = '"' },
          { mode = { 'i', 'c' }, keys = '<C-r>' },

          -- Windows
          { mode = 'n', keys = '<C-w>' },
        },

        clues = {
          -- Enhance this by adding descriptions for <Leader> mapping groups
          miniclue.gen_clues.square_brackets(),
          miniclue.gen_clues.builtin_completion(),
          -- Filter out gs and g? from the g clues
          vim.tbl_filter(function(clue) return not vim.tbl_contains({ 'gs', 'g?' }, clue.keys) end, miniclue.gen_clues.g()),
          miniclue.gen_clues.marks(),
          miniclue.gen_clues.registers(),
          miniclue.gen_clues.windows(),
          miniclue.gen_clues.z(),
        },
      }

      -- -----------------------------------------------
      -- General workflow
      -- -----------------------------------------------
      require('mini.diff').setup {
        view = {
          style = 'sign',
        },
      }
      require('mini.files').setup()
      require('mini.git').setup()

      -- -----------------------------------------------
      -- Appearance
      -- -----------------------------------------------
      require('mini.indentscope').setup {
        draw = {
          animation = require('mini.indentscope').gen_animation.linear { duration = 10 },
        },
        symbol = '│',
      }

      require('mini.notify').setup {}

      require('mini.starter').setup {
        -- Generated with figlet -f nvscript
        header = [[ ,dPYb,              ,dPYb, ,dPYb,
 IP'`Yb              IP'`Yb IP'`Yb
 I8  8I              I8  8I I8  8I
 I8  8'              I8  8' I8  8'
 I8 dPgg,    ,ggg,   I8 dP  I8 dP    ,ggggg,
 I8dP" "8I  i8" "8i  I8dP   I8dP    dP"  "Y8ggg
 I8P    I8  I8, ,8I  I8P    I8P    i8'    ,8I
,d8     I8, `YbadP' ,d8b,_ ,d8b,_ ,d8,   ,d8'
88P     `Y8888P"Y8888P'"Y888P'"Y88P"Y8888P"]],
      }

      require('mini.statusline').setup {}
      MiniStatusline.section_location = function(args)
        -- Use virtual column number to allow update when past last column
        if MiniStatusline.is_truncated(args.trunc_width) then return '%l:%2v' end

        -- Use `virtcol()` to correctly handle multi-byte characters
        return '%3l/%L:%2v %2p%%'
      end
    end,
  },
}
