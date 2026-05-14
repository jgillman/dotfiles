return {
  { -- Autocompletion
    'saghen/blink.cmp',
    dependencies = {
      'mgalliou/blink-cmp-tmux',
    },
    version = '1.*',
    --- @module 'blink.cmp'
    --- @type blink.cmp.Config
    opts = {
      keymap = {
        preset = 'super-tab',
      },
      cmdline = {
        keymap = { preset = 'inherit' },
        completion = { menu = { auto_show = true } },
      },

      appearance = {
        nerd_font_variant = 'mono',
      },

      completion = {
        -- By default, you may press `<c-space>` to show the documentation.
        -- Optionally, set `auto_show = true` to show the documentation after a delay.
        documentation = { auto_show = false, auto_show_delay_ms = 500 },
      },

      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer', 'tmux' },
        providers = {
          tmux = {
            module = 'blink-cmp-tmux',
            name = 'tmux',
          },
        },
      },

      fuzzy = { implementation = 'prefer_rust_with_warning' },

      -- Shows a signature help window while you type arguments for a function
      signature = { enabled = true },
    },
    opts_extend = { 'sources.default' },
  },
}
