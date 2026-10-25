vim.pack.add { gh 'lewis6991/gitsigns.nvim' }

require('gitsigns').setup {
  signs = {
    add = { text = '+' },
    change = { text = '~' },
    delete = { text = '_' },
    topdelete = { text = '‾' },
    changedelete = { text = '~' },
  },
  on_attach = function(bufnr)
    local gs = require 'gitsigns'
    local map = function(mode, l, r, desc) vim.keymap.set(mode, l, r, { buf = bufnr, desc = desc }) end

    map('n', ']c', function() if vim.wo.diff then vim.cmd.normal { ']c', bang = true } else gs.nav_hunk 'next' end end, 'Another git change')
    map('n', '[c', function() if vim.wo.diff then vim.cmd.normal { '[c', bang = true } else gs.nav_hunk 'prev' end end, 'Last git change')

    map('n', '<leader>hs', gs.stage_hunk, 'Git stage hunk')
    map('n', '<leader>hr', gs.reset_hunk, 'Git reset hunk')
    map('n', '<leader>hp', gs.preview_hunk, 'Preview of change')
    map('n', '<leader>tb', gs.toggle_current_line_blame, 'Change git blame')
  end,
}
