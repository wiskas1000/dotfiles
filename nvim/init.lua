vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2


-- Install package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Individual plugin setup
local plugin_catppuccin = {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000, 
  config = function()
    vim.cmd.colorscheme "catppuccin"
  end,
}

local plugin_onedark = {
  "navarasu/onedark.nvim",
  priority = 1000,
  -- config = function()
  --   vim.cmd.colorscheme "onedark"
  -- end
}

local plugin_copilot = {
  'github/copilot.vim'
}

local plugin_telescope_fzf_native = {
  'nvim-telescope/telescope-fzf-native.nvim',
  build = 'make',
}

local plugin_telescope = {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
   {
      'BurntSushi/ripgrep',
      cond = function()
        return vim.fn.executable('rg') == 1
      end
    },
    plugin_telescope_fzf_native,
  }
}

local plugin_fugitive = {
  'tpope/vim-fugitive',
}

-- Select plugins to use
local plugins = {
  plugin_catppuccin,
  plugin_onedark,
  plugin_copilot,
  plugin_fugitive,
  plugin_telescope,
  plugin_telescope_fzf_native,
}
local opts = {}

require("lazy").setup(plugins, opts)

-- Telescope setup
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                        -- the default case_mode is "smart_case"
    }
  }
}

-- Enable telescope fzf native, if installed
require('telescope').load_extension('fzf')
-- pcall(require('telescope').load_extension, 'fzf')


-- Telescope keybindings
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown 
    {
      winblend = 10,
      previewer = false,
    }
  )
end, { desc = '[/] Fuzzily search in current buffer' })

vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sr', require('telescope.builtin').resume, { desc = '[S]earch [R]esume' })


-- local builtin = require("telescope.builtin")
-- vim.keymap.set('n', '<C-p>', function() builtin.find_files() end)

require("catppuccin").setup()
