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

local languages = {
  "bash",
  "c",
  "julia",
  "lua",
  "make",
  "python",
  "query",
  "r",
  "sql",
  "toml",
  "vim",
  "vimdoc",
  "xml",
  "yaml",
}

local languages_mason = {
  "clangd", -- C/C++
  "julials", -- Julia
  "lua_ls", -- Lua
--  "autotools-language-server", -- Make
  "pylsp", -- Python
--  "r_language_server", -- R
  "sqls", -- SQL
  "vimls", -- Vim
  "lemminx", -- XML
  "yamlls", -- YAML
}

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
--  config = function()
--    vim.cmd.colorscheme "onedark"
--  end
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

local plugin_vim_tmux_navigator = {
    'christoomey/vim-tmux-navigator',
  }

local plugin_treesitter = {
  'nvim-treesitter/nvim-treesitter',
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
  },
  build = ':TSUpdate',
}

local plugin_lualine = {
  -- Set lualine as statusline
  'nvim-lualine/lualine.nvim',
--   opts = {
--     options = {
--       icons_enabled = false,
--       -- theme = 'onedark',
--       theme = 'catppuccin',
--       component_separators = '|',
--       section_separators = '',
--     },
--  },
  config = function()
    require('lualine').setup {
      options = {
        icons_enabled = false,
        -- theme = 'onedark',
        -- theme = 'catppuccin',
        theme = 'dracula',
        component_separators = '|',
        section_separators = '',
      },
    }
  end
}

local plugin_mason = {
  "williamboman/mason.nvim",
  config = function()
    require('mason').setup()
  end
}

local plugin_masonlspconfig = {
  "williamboman/mason-lspconfig.nvim",
  config = function()
    require('mason-lspconfig').setup({
      ensure_installed = languages_mason,
    })
  end
}

local plugin_nvimlspconfig = {
  "neovim/nvim-lspconfig",
  dependencies = {
    -- Automatically install LSPs to stdpath for neovim
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',

    -- Useful status updates for LSP
    { 'j-hui/fidget.nvim', tag = 'legacy', opts = {} },

    -- Additional lua configuration, makes nvim stuff amazing!
    'folke/neodev.nvim',
  },
  config = function()
    local lspconfig = require('lspconfig')
    lspconfig.lua_ls.setup({})

    local on_attach = function(_, bufnr)
      local nmap = function(keys, func, desc)
        if desc then
          desc = 'LSP: ' .. desc
        end
        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
      end
      nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
      nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')
    end
  end
--     --  This function gets run when an LSP connects to a particular buffer.
--     local on_attach = function(_, bufnr)
--     -- NOTE: Remember that lua is a real programming language, and as such it is possible
--     -- to define small helper and utility functions so you don't have to repeat yourself
--     -- many times.
--     --
--     -- In this case, we create a function that lets us more easily define mappings specific
--     -- for LSP related items. It sets the mode, buffer and description for us each time.
--     local nmap = function(keys, func, desc)
--       if desc then
--         desc = 'LSP: ' .. desc
--       end
-- 
--     vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
--     end
-- 
--     nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
--     nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
-- 
--     nmap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
--     nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
--     nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
--     nmap('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
--     nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
--     nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
-- 
--     -- See `:help K` for why this keymap
--     nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
--     nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')
-- 
--     -- Lesser used LSP functionality
--     nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
--     nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
--     nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
--     nmap('<leader>wl', function()
--       print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
--     end, '[W]orkspace [L]ist Folders')
-- 
--     -- Create a command `:Format` local to the LSP buffer
--     vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
--       vim.lsp.buf.format()
--     end, { desc = 'Format current buffer with LSP' })
--   end
-- 
-- 
}



-- Select plugins to use
local plugins = {
  plugin_catppuccin,
  plugin_onedark,
  plugin_copilot,
  plugin_fugitive,
  plugin_telescope,
  plugin_telescope_fzf_native,
  plugin_treesitter,
  plugin_lualine,
  plugin_mason,
  plugin_masonlspconfig,
  plugin_nvimlspconfig,
  plugin_vim_tmux_navigator,
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

-- Treesitter setup
local config = require("nvim-treesitter.configs")

config.setup({
  ensure_installed = { languages },
  auto_install = false,
  sync_install = false,
  highlight = { enable = true },
  indent = { enable = true },
  incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = '<c-space>',
        node_incremental = '<c-space>',
        scope_incremental = '<c-s>',
        node_decremental = '<M-space>',
      },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['aa'] = '@parameter.outer',
        ['ia'] = '@parameter.inner',
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ['<leader>a'] = '@parameter.inner',
      },
      swap_previous = {
        ['<leader>A'] = '@parameter.inner',
      },
    },
  },
})

