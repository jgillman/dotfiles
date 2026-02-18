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
      {
        'neovim/nvim-lspconfig',
        config = function()
          ------------------------------------------------------------------
          -- Capabilities (completion, etc.)
          ------------------------------------------------------------------
          local capabilities = vim.lsp.protocol.make_client_capabilities()

          ------------------------------------------------------------------
          -- LSP server definitions (NEW API)
          ------------------------------------------------------------------
          vim.lsp.config('lua_ls', {
            capabilities = capabilities,
            on_attach = on_attach,
            settings = {
              Lua = {
                diagnostics = {
                  -- disable = { "missing-fields" }
                  globals = { 'vim' },
                },
                workspace = {
                  library = vim.api.nvim_get_runtime_file('', true),
                  checkThirdParty = false,
                },
                format = { enable = false },
                telemetry = { enable = false },
              },
            },
          })
        end,
      },
    },
  },
}
