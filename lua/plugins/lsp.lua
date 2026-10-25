vim.pack.add {
  gh 'j-hui/fidget.nvim',
  gh 'neovim/nvim-lspconfig',
  gh 'mason-org/mason.nvim',
  gh 'mason-org/mason-lspconfig.nvim',
  gh 'WhoIsSethDaniel/mason-tool-installer.nvim',
}

require('fidget').setup {}
require('mason').setup {}
require('mason-lspconfig').setup { automatic_enable = false }

local servers = {
  stylua = {},
  lua_ls = {
    settings = {
      Lua = { format = { enable = false } },
    },
  },
}

local ensure_installed = vim.tbl_keys(servers)
require('mason-tool-installer').setup { ensure_installed = ensure_installed }

for name, server in pairs(servers) do
  vim.lsp.config(name, server)
  vim.lsp.enable(name)
end

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lsp-attach-keybinds', { clear = true }),
  callback = function(event)
    local map = function(keys, func, desc)
      vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end
    map('grn', vim.lsp.buf.rename, 'Change var name')
    map('gra', vim.lsp.buf.code_action, 'Code action')
    map('grD', vim.lsp.buf.declaration, 'Jump to declaration')
  end,
})
