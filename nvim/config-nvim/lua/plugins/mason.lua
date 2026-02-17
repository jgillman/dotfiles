return {
  {
    'mason-org/mason-lspconfig.nvim',
    opts = {
      -- LSPs to install
      ensure_installed = {
        'helm_ls',
        'lua_ls',
        'stylua',
        'terraformls',
      },
    },
    dependencies = {
      { 'mason-org/mason.nvim', opts = {} },
      {
        -- Install non-LSP tools like linters and formatters
        'WhoIsSethDaniel/mason-tool-installer.nvim',
        opts = {
          ensure_installed = {
            'prettier',
            'shellcheck',
            'shfmt',
          },
        },
      },
      'neovim/nvim-lspconfig',
    },
  },
}
